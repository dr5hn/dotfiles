# ~/.zsh/functions/dev.zsh
# Development utility functions

# Capistrano wrapper — installs gems on first use, then runs cap
_install_cap() {
    unset -f cap &>/dev/null
    alias cap='bundle install &>/dev/null && bundle exec cap'
    bundle install &>/dev/null
    bundle exec cap "$@"
}

cap() {
    _install_cap "$@"
}

# Laravel Valet: link + secure the current site
valetup() {
    valet link "$1"
    valet secure "$1"
}
