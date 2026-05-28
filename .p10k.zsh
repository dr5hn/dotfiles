# ~/.p10k.zsh — Powerlevel10k configuration (agnoster-style powerline prompt).
# Hand-written to mirror the previous oh-my-posh "agnoster" theme.
# Re-run `p10k configure` any time to regenerate this with full font detection.

'builtin' 'emulate' '-L' 'zsh' '-o' 'no_aliases' '-o' 'extended_glob' '-o' 'no_short_loops'

() {
  emulate -L zsh -o extended_glob
  unset -m 'POWERLEVEL9K_*~POWERLEVEL9K_GITSTATUS_DIR'

  # ---- Segments ---------------------------------------------------------
  # Left: user@host, current dir, git status (classic agnoster order).
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context dir vcs)
  # Right: non-zero exit status, and how long the last command took.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time)

  # ---- Powerline glyphs (need a Powerline/Nerd font, same as agnoster) --
  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=''
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=''

  # Single-line prompt, no leading blank line.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
  typeset -g POWERLEVEL9K_PROMPT_ON_NEWLINE=false

  # ---- context: user@host ----------------------------------------------
  typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND=black
  typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND=249
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=black
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=red
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  # Hide user@host on the local machine; show it only over SSH or as root.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

  # ---- dir --------------------------------------------------------------
  typeset -g POWERLEVEL9K_DIR_BACKGROUND=blue
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=black
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_to_unique
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

  # ---- vcs (git): green=clean, yellow=dirty ----------------------------
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND=green
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND=black
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND=green
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND=black
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND=yellow
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND=black

  # ---- status: only show on error --------------------------------------
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR=true
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND=red
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND=white

  # ---- command execution time (only if it took a while) ----------------
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND=magenta
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=white

  # ---- behaviour --------------------------------------------------------
  # Show a fully cached prompt instantly on startup; print warnings if any
  # init code writes to the console (set to 'quiet' to silence those).
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#POWERLEVEL9K_CONFIG_FILE} )) || typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}
