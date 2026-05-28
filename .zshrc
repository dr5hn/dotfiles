# ~/.zshrc
# Interactive shell configuration
# Modular setup - sources files from ~/.zsh/

# Powerlevel10k instant prompt — must stay near the top of ~/.zshrc.
# Renders a cached prompt immediately, before the rest of init runs.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Initialise zsh completion system (must run before any compdef calls)
autoload -Uz compinit && compinit -C
# Compile the completion dump to bytecode so it loads faster next time.
[[ -s ~/.zcompdump && ( ! -s ~/.zcompdump.zwc || ~/.zcompdump -nt ~/.zcompdump.zwc ) ]] && zcompile ~/.zcompdump

# Caching helper for slow tool init snippets (must load before the modules below)
source ~/.zsh/lib/cache-init.zsh

# Source modular configuration files
for config_file in \
    ~/.zsh/path.zsh \
    ~/.zsh/env.zsh \
    ~/.zsh/private.zsh \
    ~/.zsh/history.zsh \
    ~/.zsh/ssh.zsh \
    ~/.zsh/tools.zsh \
    ~/.zsh/lazy/*.zsh \
    ~/.zsh/aliases/*.zsh \
    ~/.zsh/functions/*.zsh
do
    [[ -f "$config_file" ]] && source "$config_file"
done

# Powerlevel10k prompt (zsh-native, no per-prompt subprocess fork)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
# To customise: run `p10k configure` or edit ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# Herd PHP configs consolidated in ~/.zsh/env.zsh

# CCM — Claude Code Manager (PATH in path.zsh); cached init, regenerates on upgrade
_cache_init ccm ccm hook --isolated

# bun (PATH in path.zsh)
export BUN_INSTALL="$HOME/.bun"
[ -s "/Users/darshan/.bun/_bun" ] && source "/Users/darshan/.bun/_bun"

alias clauded='claude --dangerously-skip-permissions'
alias codexd='codex -c model_reasoning_effort="high" --ask-for-approval never --sandbox danger-full-access -c model_reasoning_summary="detailed" -c model_supports_reasoning_summaries=true'


# Herd injected PHP 8.4 configuration.
export HERD_PHP_84_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/84/"


# Herd injected PHP 8.5 configuration.
export HERD_PHP_85_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/85/"


# Herd injected PHP 8.3 configuration.
export HERD_PHP_83_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/83/"


# Herd injected PHP 8.2 configuration.
export HERD_PHP_82_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/82/"


# Herd injected PHP 8.1 configuration.
export HERD_PHP_81_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/81/"


# Herd injected PHP 8.0 configuration.
export HERD_PHP_80_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/80/"


# Herd injected PHP 7.4 configuration.
export HERD_PHP_74_INI_SCAN_DIR="/Users/darshan/Library/Application Support/Herd/config/php/74/"

# Interactive UX plugins — MUST be sourced last (syntax-highlighting requirement)
source ~/.zsh/plugins.zsh
