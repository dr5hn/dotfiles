# ~/.zsh/plugins.zsh
# Interactive UX plugins. Sourced LAST from ~/.zshrc because the load order
# matters: fzf-tab -> autosuggestions -> syntax-highlighting -> substring-search.
# (syntax-highlighting must come near the end; substring-search after it.)

# --- Completion styling (also drives fzf-tab) ---------------------------
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # case-insensitive matching
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # colourise completion list
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' menu no                              # let fzf-tab render the menu
zstyle ':fzf-tab:*' use-fzf-default-opts yes                # reuse $FZF_DEFAULT_OPTS

# --- fzf-tab: replace the completion menu with an fzf picker (needs fzf) -
[[ -f /opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh ]] && \
    source /opt/homebrew/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh

# --- autosuggestions: fish-style inline suggestion from history ---------
if [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=244'   # dim grey; accept with → or End
fi

# --- syntax-highlighting: colour the command line as you type -----------
[[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && \
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- history-substring-search: type a fragment, ↑/↓ to cycle matches ----
if [[ -f /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]]; then
    source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey '^P'   history-substring-search-up
    bindkey '^N'   history-substring-search-down
fi
