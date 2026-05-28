# ~/.zsh/aliases/git.zsh
# Git and GitHub CLI aliases

# Dotfiles bare repo — tracks ~/.zshrc, ~/.p10k.zsh, ~/.zsh/* in place.
# Use like git: `dotfiles status`, `dotfiles add ~/.zshrc`, `dotfiles commit -m ...`, `dotfiles log`.
alias dotfiles='git --git-dir="$HOME/.dotfiles" --work-tree="$HOME"'

# Git status & branch
alias gs="git status -sb"
alias gb="git branch"
alias gfa='git fetch --all --prune --jobs=10'
alias copybranch="git branch --show-current | pbcopy"

# Git sync
alias gitsync="gfa && git pull origin master development"
alias push="git push origin master development --tags"
alias ppush="git push origin master --tags"
alias pull="git stash -u; git pull; git stash pop;"
alias pullup="git checkout development; git stash -u; git pull; git stash pop; git checkout master; git stash -u; git pull; git stash pop;"
alias rebase="git stash -u && git rebase --onto development && git stash pop"
alias prune="git branch -r | awk '{print \$1}' | egrep -v -f /dev/fd/0 <(git branch -vv | grep origin) | awk '{print \$1}' | xargs git branch -d"

# GitHub CLI
alias bb='gh browse -b $(git branch --show-current)'
alias aa='gh browse'
alias ss='gh browse --settings'
alias cc='open "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/commits/$(git branch --show-current)"'
alias pr='open "https://github.com/$(gh repo view --json nameWithOwner -q .nameWithOwner)/pulls?q=is%3Apr+is%3Aopen+sort%3Aupdated-desc"'

# GitHub Actions
alias ghpluginupdate='gh workflow run update.yml && sleep 3 && run_id=$(gh run list --workflow=update.yml --limit=1 --json databaseId | jq -r ".[0].databaseId") && gh run view --web $run_id && gh run watch $run_id'
alias ghsatis='gh workflow run update-satis.yml && sleep 3 && run_id=$(gh run list --workflow=update-satis.yml --limit=1 --json databaseId | jq -r ".[0].databaseId") && gh run view --web $run_id && gh run watch $run_id'

# Capistrano
alias cpd="cap production deploy"
alias cpdc="cap production deploy:check"
alias csd="cap staging deploy"
alias csdc="cap staging deploy:check"
