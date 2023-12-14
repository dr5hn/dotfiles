# Sourced upon starting of new shell

SSH_ENV=$HOME/.ssh/environment

# start the ssh-agent
function start_agent {
    echo "Initializing new SSH agent..."
    # spawn ssh-agent
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add
    /usr/bin/ssh-add ~/.ssh/id_rsa
}

if [ -f "${SSH_ENV}" ]; then
     . ${SSH_ENV} > /dev/null
     ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

####
# FNM
####
eval "$(fnm env --use-on-cd)"

####
# PHP
####
# export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"

# export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@8.0/sbin:$PATH"

# export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"

# export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
# export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"

export PATH="/opt/homebrew/opt/php@8.3/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.3/sbin:$PATH"

####
# Composer
####
export PATH="$HOME/.composer/vendor/bin:$PATH"

####
# MAMP
####
# export PATH="/Applications/MAMP/Library/bin:$PATH"

####
# DBNgin
####
# export PATH="/Users/Shared/DBngin/mysql/5.7.23/bin:$PATH"
export PATH="/Users/Shared/DBngin/redis/6.2.1/bin:$PATH"

####
# Yarn
####
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

####
# Shopify
####
export SHOPIFY_CLI_STACKTRACE=1

####
# Python
####
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
