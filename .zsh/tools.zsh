# ~/.zsh/tools.zsh
# Productivity tool integrations (fzf, zoxide, bat, fd)

# fzf — fuzzy finder (Ctrl+R for history, Ctrl+T for files, Alt+C for cd)
if command -v fzf &>/dev/null; then
    _cache_init fzf fzf --zsh
    export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --info=inline"
    # Use fd for file search (respects .gitignore)
    if command -v fd &>/dev/null; then
        export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow --exclude .git"
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="fd --type d --hidden --follow --exclude .git"
    fi
fi

# zoxide — smarter cd (use 'z' to jump to frequent dirs)
if command -v zoxide &>/dev/null; then
    _cache_init zoxide zoxide init zsh
fi

# bat — cat with syntax highlighting
if command -v bat &>/dev/null; then
    export BAT_THEME="TwoDark"
    alias cat="bat --paging=never"
    alias catp="bat"
fi
