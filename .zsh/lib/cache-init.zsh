# ~/.zsh/lib/cache-init.zsh
# Cache the output of slow tool init commands sourced at shell startup.
#
# Many tools (oh-my-posh, ccm, zoxide, fzf) print the same shell snippet on
# every launch but cost 10-90ms each to fork. We cache that snippet to a file
# and re-source it, regenerating only when the tool's binary is newer than the
# cache (i.e. after an upgrade), so output stays correct without the per-launch
# fork cost.

: ${ZSH_CACHE_DIR:=$HOME/.cache/zsh}

# _cache_init <cache-name> <command> [args...]
#   <cache-name>  unique slug for the cache file
#   <command>     the executable to run; arg $1 is also used for the freshness check
# Returns non-zero only if the cache file is unusable.
_cache_init() {
    emulate -L zsh
    local name=$1; shift
    local cache="$ZSH_CACHE_DIR/${name}.zsh"
    local bin; bin=$(command -v "$1" 2>/dev/null)

    # Regenerate when the cache is missing/empty, or the tool binary is newer.
    if [[ ! -s $cache || ( -n $bin && $bin -nt $cache ) ]]; then
        [[ -d $ZSH_CACHE_DIR ]] || command mkdir -p "$ZSH_CACHE_DIR" || return 1
        if ! "$@" > "$cache" 2>/dev/null || [[ ! -s $cache ]]; then
            command rm -f "$cache"
            return 1
        fi
    fi

    source "$cache"
}
