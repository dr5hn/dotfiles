# ~/.zsh/ssh.zsh
# Optimized SSH agent using macOS Keychain

SSH_ENV="$HOME/.ssh/environment"

# Check if agent is already running
if [[ -f "$SSH_ENV" ]]; then
    source "$SSH_ENV" >/dev/null
    # Verify agent is actually running
    if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
        rm -f "$SSH_ENV"
    fi
fi

# Start agent only if needed
if [[ -z "$SSH_AGENT_PID" ]] || ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
    ssh-agent -s > "$SSH_ENV"
    chmod 600 "$SSH_ENV"
    source "$SSH_ENV" >/dev/null

    # Add keys using Keychain (no password prompts on subsequent loads)
    for key in id_rsa deployer bitbucket id_gitlab pipeline; do
        [[ -f "$HOME/.ssh/$key" ]] && ssh-add --apple-use-keychain "$HOME/.ssh/$key" 2>/dev/null
    done
fi
