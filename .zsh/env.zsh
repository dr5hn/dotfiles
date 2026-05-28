# ~/.zsh/env.zsh
# Environment variables

# Shopify
export SHOPIFY_CLI_STACKTRACE=1

# Pyenv root (required for lazy loading)
export PYENV_ROOT="$HOME/.pyenv"

# Herd PHP configurations (consolidated)
for version in 74 80 81 82 83 84 85; do
    export "HERD_PHP_${version}_INI_SCAN_DIR"="/Users/darshan/Library/Application Support/Herd/config/php/${version}/"
done
