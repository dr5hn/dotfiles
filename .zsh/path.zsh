# ~/.zsh/path.zsh
# Consolidated PATH configuration with automatic deduplication

typeset -U path  # Ensures unique entries only

path=(
    "$HOME/.ccm/bin"
    "/Users/darshan/Library/Application Support/Herd/bin"
    "/opt/homebrew/bin"
    "/opt/homebrew/sbin"
    "$HOME/.local/bin"
    "$HOME/.composer/vendor/bin"
    "$HOME/.yarn/bin"
    "$HOME/.config/yarn/global/node_modules/.bin"
    "/opt/homebrew/opt/postgresql@15/bin"
    "/Users/Shared/DBngin/redis/6.2.1/bin"
    $path
)

export PATH
