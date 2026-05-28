# ~/.zsh/aliases/composer.zsh
# Composer and PNPM aliases

# Composer
alias c="composer"
alias ci="composer install"
alias cu="composer update"
alias co="composer outdated"
alias cr="composer require"
alias crd="composer require --dev"
alias crm="composer remove"
alias cw="composer why"
alias crg="composer global require"
alias cup="composer self-update"

# Composer with packages (fixed - using functions instead of broken aliases)
crw() { composer require "wpackagist-plugin/$1"; }
crs() { composer require "${COMPOSER_VENDOR:-vendor}/$1"; }
cuw() { composer update "wpackagist-plugin/$1"; }
cus() { composer update "${COMPOSER_VENDOR:-vendor}/$1"; }

# PNPM
alias pn=pnpm
alias pni="pn i"
alias pna="pn add"
alias pno="pn outdated"
alias pnu="pn up"
alias pnd="pna -D"
alias png="pna -G"
alias pnr="pn rm"
