source ~/.profile

# Sourced upon login
eval $(/opt/homebrew/bin/brew shellenv)

# Setup Compiler paths for readline and openssl
local READLINE_PATH=$(brew --prefix readline)
local OPENSSL_PATH=$(brew --prefix openssl@1.1)
export LDFLAGS="-L$READLINE_PATH/lib -L$OPENSSL_PATH/lib"
export CPPFLAGS="-I$READLINE_PATH/include -I$OPENSSL_PATH/include"
export PKG_CONFIG_PATH="$READLINE_PATH/lib/pkgconfig:$OPENSSL_PATH/lib/pkgconfig"

# Use the OpenSSL from Homebrew instead of ruby-build
# Note: the Homebrew version gets updated, the ruby-build version doesn't
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$OPENSSL_PATH"

# Place openssl@1.1 at the beginning of your PATH (preempt system libs)
export PATH=$OPENSSL_PATH/bin:$PATH

# Load rbenv
eval "$(rbenv init -)"

# Extract the latest version of Ruby so you can do this:
# rbenv install $LATEST_RUBY_VERSION
# export LATEST_RUBY_VERSION=$(rbenv install -l | grep -v - | tail -1)

####
# Alias cap to bundle exec cap, and bundle install the first time it's called
####
function _install_cap()
{
  unset -f cap &>/dev/null
  alias cap='bundle install &>/dev/null && bundle exec cap'
  bundle install &>/dev/null
  bundle exec cap $@
}

####
# Fires the requested params after installing
####
function cap()
{
    _install_cap "$@"
}

####################
# Capistrano Aliases
####################
alias cpd="cap production deploy"
alias cpdc="cap production deploy:check"
alias csd="cap staging deploy"
alias csdc="cap staging deploy:check"

#############
# Git Aliases
#############
alias gs="git status -sb"
alias gb="git branch"
alias prune="git branch -r | awk '{print $1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print $1}' | xargs git branch -d"
alias copybranch="git branch --show-current | pbcopy"
alias gfa='git fetch --all --prune --jobs=10'
alias gitsync="gfa && git pull origin master development"
alias push="git push origin master development --tags"
alias ppush="git push origin master --tags"
alias pull="git stash -u; git pull; git stash pop;"
alias pullstash="git checkout development; git stash -u; git pull; git stash pop; git checkout master; git stash -u; git pull; git stash pop;"
alias rebase="git stash -u && git rebase --onto development && git stash pop"
function checkout() { git stash -u; git checkout $1; git stash pop; }
function tag() { git tag $1 }
function pupdate() { git add .; git commit -m $1 && git tag $1 && ppush }
alias pudapte="pupdate"
function prevert() { git reset --soft HEAD~1; git tag -d $1; git push origin :refs/tags/$1; git push -f; }
function tagd() { git tag -d $1; git push origin :refs/tags/$1; }
function hotfix() { git stash -u; git checkout master; git pull; git flow hotfix start $1; git stash pop; }
function hotfixf() { git stash -u; git checkout master; git pull; git checkout development; git pull; git flow hotfix finish $1; git stash pop; }
function hotfixd() { git branch -D hotfix/$1 }
function feature() { git stash -u; git checkout development; git pull; git flow feature start $1; git stash pop; }
function featuref() { git stash -u; git checkout development; git pull; git flow feature finish $1; git stash pop; }
function featured() { git branch -D feature/$1 }
function release() { git stash -u; git flow release start $1; git stash pop; }
function releasef() { git stash -u; git flow release finish $1; git stash pop; }
function released() { git branch -D release/$1 }

####################
# Yarn Aliases
####################
alias build="yarn build"
alias watch="yarn watch"
alias dev="yarn dev"

####################
# Wordpress Aliases
####################
alias htaccess='(
cat > web/.htaccess <<EOF
# BEGIN WordPress

RewriteEngine On
RewriteRule .* - [E=HTTP_AUTHORIZATION:%{HTTP:Authorization}]
RewriteBase /
RewriteRule ^index\.php$ - [L]
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule . /index.php [L]

# END WordPress
EOF
)'

####################
# Phinx
####################
alias phinxmigrate="php ./includes/vendor/bin/phinx migrate"
alias phinxcreate="php ./includes/vendor/bin/phinx create"

####################
# Composer Aliases
####################
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

####################
# PNPM Aliases
####################
alias pn=pnpm
alias pni=pn i
alias pna=pn add
alias pno=pn outdated
alias pnu=pn up
alias pnd=pna -D
alias png=pna -G
alias pnr=pn rm

####################
# PHP Switcher
####################
alias 7.4='{ brew unlink php@8.0; brew unlink php@8.1; brew unlink php@8.2; brew unlink php@8.3; brew link php@7.4 --force --overwrite; } &> /dev/null && php -v'
alias 8.0='{ brew unlink php@7.4; brew unlink php@8.1; brew unlink php@8.2; brew unlink php@8.3; brew link php@8.0 --force --overwrite; } &> /dev/null && php -v'
alias 8.1='{ brew unlink php@7.4; brew unlink php@8.0; brew unlink php@8.2; brew unlink php@8.3; brew link php@8.1 --force --overwrite; } &> /dev/null && php -v'
alias 8.2='{ brew unlink php@7.4; brew unlink php@8.0; brew unlink php@8.1; brew unlink php@8.3; brew link php@8.2 --force --overwrite; } &> /dev/null && php -v'
alias 8.3='{ brew unlink php@7.4; brew unlink php@8.0; brew unlink php@8.1; brew unlink php@8.2; brew link php@8.3 --force --overwrite; } &> /dev/null && php -v'

####################
# Apache & Nginx Switch
####################
alias httpdstop="sudo brew services stop httpd && valet start"
alias httpdinfo="sudo brew services info httpd"
alias httpdrestart="sudo brew services restart httpd && httpdinfo"
alias httpdstart="valet stop && httpdrestart"

#########
# Utilities
#########
alias ~="cd ~"
alias flush="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias ..="cd .."
alias cd..="cd .."
alias mkdir="mkdir -pv"
alias wget="wget -c"
alias myip="curl http://ipecho.net/plain; echo"
alias edithosts="sudo nano /private/etc/hosts"
alias sqlkeys="code ~/Library/Containers/com.sequel-ace.sequel-ace/Data/.keys/ssh_known_hosts_strict"
alias sshkeys="code ~/.ssh/known_hosts"
function valetup() { valet link $1; valet secure $1; }
alias up="valet link && valet secure"
alias zp="code ~/.zprofile"
alias zs="code ~/.zshrc"
alias projects="cd ~/Projects"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias pl="cd ~/Projects/plugins"
alias sshconfig="code ~/.ssh/config"
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias wifi="security find-generic-password -wa $1 | grep password: | cut -d \" -f 2"
# detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
    colorflag="--color"
else # OS X `ls`
    colorflag="-G"
fi
alias l="ls -lF ${colorflag}"
alias ll="ls -lh ${colorflag}"
alias la="ls -laF ${colorflag}"
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
alias ls="command ls ${colorflag}"
alias redirectby="curl -I $1 | grep redirect"

#########
# Github CLI
#########
alias ghdeploystage='branch=$(git branch --show-current) && gh workflow run deploy.yml --ref $branch -f environment=STAGING && sleep 3 && run_id=$(gh run list --workflow=deploy.yml --limit=1 --json databaseId | jq -r ".[0].databaseId") && gh run view --web $run_id && gh run watch $run_id'
alias ghdeploylive='branch=$(git branch --show-current) && gh workflow run deploy.yml --ref $branch -f environment=LIVE && sleep 3 && run_id=$(gh run list --workflow=deploy.yml --limit=1 --json databaseId | jq -r ".[0].databaseId") && gh run view --web $run_id'
alias cc='open "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/commits/$(git branch --show-current)"'
alias ss='gh browse --settings'
alias bb='gh browse -b $(git branch --show-current)'
alias pr='open "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc"'
