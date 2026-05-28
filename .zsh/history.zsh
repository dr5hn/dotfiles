# ~/.zsh/history.zsh
# Larger, de-duplicated, shared command history.

HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000        # commands kept in memory per session
SAVEHIST=50000        # commands persisted to $HISTFILE

setopt EXTENDED_HISTORY       # record timestamp + duration for each command
setopt SHARE_HISTORY          # share history live across open sessions
setopt HIST_IGNORE_DUPS       # don't record a command identical to the previous one
setopt HIST_IGNORE_ALL_DUPS   # drop older duplicates when a new copy is added
setopt HIST_IGNORE_SPACE      # don't record commands that start with a space
setopt HIST_FIND_NO_DUPS      # skip duplicates when searching history
setopt HIST_SAVE_NO_DUPS      # don't write duplicate entries to the file
setopt HIST_REDUCE_BLANKS     # trim redundant whitespace before saving
setopt HIST_VERIFY            # show expanded "!!"/"!$" before running, don't auto-exec
