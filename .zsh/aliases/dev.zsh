# ~/.zsh/aliases/dev.zsh
# Development tool aliases

# Build
alias build="yarn build"
alias dev="yarn dev"

# Valet
alias up="valet link && valet secure"
alias httpdstop="brew services stop httpd && valet start"
alias httpdinfo="httpd -t; brew services info httpd"
alias httpdrestart="brew services restart httpd && httpdinfo"
alias httpdstart="valet stop && httpdrestart"
alias httpdconf="zed /opt/homebrew/etc/httpd/httpd.conf"
alias httpdvconf="zed /opt/homebrew/etc/httpd/extra/httpd-vhosts.conf"
alias phplogs="zed /Users/darshan/.config/valet/Log/php-fpm.log"
alias logfile="zed /Users/darshan/Library/Application\ Support/Herd/Log/php-fpm.log"

# PHP version switching
alias 7.4='{ brew unlink shivammathur/php/php@8.0; brew unlink php@8.1; brew link php@7.4 --force --overwrite; } &> /dev/null && php -v'
alias 8.0='{ brew unlink php@8.1; brew link shivammathur/php/php@8.0 --force --overwrite; } &> /dev/null && php -v'
alias 8.1='{ brew unlink shivammathur/php/php@8.0; brew link php@8.1 --force --overwrite; } &> /dev/null && php -v'

# CCM — Claude Code Manager (installed via ~/.ccm/bin/ccm)
# All old ccs/cc-* aliases removed — just use: ccm

alias npmi='/opt/homebrew/bin/npm i -g'
alias npmu='/opt/homebrew/bin/npm update -g'
