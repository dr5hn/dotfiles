# ~/.zsh/lazy/pyenv.zsh
# Lazy-load pyenv - only initializes when first called

if [[ -d "$PYENV_ROOT" ]]; then
    path=("$PYENV_ROOT/bin" $path)

    pyenv() {
        unfunction pyenv 2>/dev/null
        eval "$(command pyenv init -)"
        pyenv "$@"
    }
fi
