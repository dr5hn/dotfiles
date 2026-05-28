# ~/.zsh/lazy/fnm.zsh
# Lazy-load fnm (Fast Node Manager)

# Exit early if fnm isn't installed
if ! command -v fnm &>/dev/null; then return 0; fi

# For non-interactive shells or shells without TTY (e.g., Claude Code, scripts),
# initialize fnm directly to avoid lazy-load function issues
if [[ ! -o interactive ]] || [[ ! -t 0 ]]; then
    eval "$(fnm env --shell zsh)"
    fnm use --silent-if-unchanged --log-level quiet 2>/dev/null || true
    return 0
fi

# Interactive shell: use lazy loading for faster startup.
# --log-level quiet silences the automatic "Using Node vX" on-cd message
# (which otherwise breaks Powerlevel10k instant prompt); manual `fnm use`
# stays verbose because the wrapper calls `command fnm` without that flag.
_fnm_load() {
    unfunction _fnm_load fnm node npm npx pnpm yarn bun corepack 2>/dev/null
    eval "$(fnm env --use-on-cd --shell zsh --log-level quiet)"
    fnm use --silent-if-unchanged --log-level quiet 2>/dev/null || true
}

fnm()      { _fnm_load; command fnm "$@"; }
node()     { _fnm_load; command node "$@"; }
npm()      { _fnm_load; command npm "$@"; }
npx()      { _fnm_load; command npx "$@"; }
pnpm()     { _fnm_load; command pnpm "$@"; }
yarn()     { _fnm_load; command yarn "$@"; }
bun()      { _fnm_load; command bun "$@"; }
corepack() { _fnm_load; command corepack "$@"; }
