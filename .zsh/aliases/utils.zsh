# ~/.zsh/aliases/utils.zsh
# Utility and navigation aliases

# Navigation
alias ~="cd ~"
alias ..="cd .."
alias cd..="cd .."
alias projects="cd ~/Projects"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias pl="cd ~/Projects/plugins"

# System
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias myip="curl http://ipecho.net/plain; echo"
alias dock="killall Dock"
alias timestamp="date +%s"

# File operations
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"

# Editors and configs
alias code="zed"
alias e="zed"
alias zz="zed ~/.zsh"
alias zp="zed ~/.zprofile"
alias zs="zed ~/.zshrc"
alias edithosts="sudo nano /private/etc/hosts"
alias sqlkeys="zed ~/Library/Containers/com.sequel-ace.sequel-ace/Data/.keys/ssh_known_hosts_strict"
alias sshkeys="zed ~/.ssh/known_hosts"
alias sshconfig="zed ~/.ssh/config"

# ls → eza (modern ls with git integration)
alias ls="eza --icons"
alias l="eza -lF --icons"
alias ll="eza -lh --icons --git"
alias la="eza -laF --icons --git"
alias lsd="eza -lD --icons"
alias lt="eza -lT --icons --git --level=2"

# Misc utilities
alias zedextn="zed --list-extensions 2>/dev/null"
alias pudapte="pupdate"  # Typo alias

# Browser switching
alias use-chrome='defaultbrowser chrome && echo "Switched to Chrome"'
alias use-brave='defaultbrowser brave && echo "Switched to Brave"'

# Automatic browser switching based on day
auto-browser() {
    local day=$(date +%u)  # 1=Monday, 7=Sunday

    if [ $day -ge 6 ]; then
        # Weekend (Saturday=6, Sunday=7)
        defaultbrowser brave
        echo "Weekend detected - Switched to Brave"
    else
        # Weekday (Monday=1 to Friday=5)
        defaultbrowser chrome
        echo "Weekday detected - Switched to Chrome"
    fi
}
