# ~/.zsh/functions/git.zsh
# Git and Git Flow functions

# Checkout with stash
checkout() {
    git stash -u
    git checkout "$1"
    git stash pop
}

# Tag management
tag() { git tag "$1"; }
tagd() { git tag -d "$1"; git push origin ":refs/tags/$1"; }

# Package update workflow
pupdate() {
    git add .
    git commit -m "$1" && git tag "$1" && ppush
}

prevert() {
    git reset --soft HEAD~1
    git tag -d "$1"
    git push origin ":refs/tags/$1"
    git push -f
}

# Git Flow - Hotfix
hotfix() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git checkout master
    git pull
    git flow hotfix start "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

hotfixf() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git checkout master
    git pull
    git checkout development
    git pull
    git flow hotfix finish "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

hotfixd() { git branch -D "hotfix/$1"; }

# Git Flow - Feature
feature() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git checkout development
    git pull
    git flow feature start "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

featuref() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git checkout development
    git pull
    git flow feature finish "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

featured() { git branch -D "feature/$1"; }

# Git Flow - Release
release() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git flow release start "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

releasef() {
    local _stash; _stash=$(git stash -u 2>&1); echo "$_stash"
    git flow release finish "$1"
    [[ "$_stash" == *"No local changes to save"* ]] || git stash pop
}

released() { git branch -D "release/$1"; }

# Switch to GitHub remote
switch2gh() {
    git remote set-url origin "git@github.com:${GH_ORG:-your-org}/${PWD##*/}.git"
    git remote -v
}

# Find deploy workflow file
find_deploy_workflow() {
    if [ -f ".github/workflows/deploy.yml" ]; then
        echo "deploy.yml"
        return
    fi

    local deploy_file=$(ls .github/workflows/deploy*.yml 2>/dev/null | head -1)
    if [ -n "$deploy_file" ]; then
        echo "$(basename "$deploy_file")"
        return
    fi

    deploy_file=$(ls .github/workflows/deploy* 2>/dev/null | head -1)
    if [ -n "$deploy_file" ]; then
        echo "$(basename "$deploy_file")"
        return
    fi

    echo ""
}

# GitHub deploy aliases as functions
ghdeploystage() {
    local workflow=$(find_deploy_workflow)
    if [ -z "$workflow" ]; then
        echo "Error: No deploy workflow file found"
        return 1
    fi
    local branch=development
    gh workflow run "$workflow" --ref $branch -f environment=STAGING &&
    sleep 3 &&
    local run_id=$(gh run list --workflow="$workflow" --limit=1 --json databaseId | jq -r ".[0].databaseId") &&
    gh run view --web $run_id &&
    gh run watch $run_id
}

ghdeploylive() {
    local workflow=$(find_deploy_workflow)
    if [ -z "$workflow" ]; then
        echo "Error: No deploy workflow file found"
        return 1
    fi
    local branch=$(git rev-parse --verify main &>/dev/null && echo "main" || echo "master")
    gh workflow run "$workflow" --ref $branch -f environment=LIVE &&
    sleep 3 &&
    local run_id=$(gh run list --workflow="$workflow" --limit=1 --json databaseId | jq -r ".[0].databaseId") &&
    gh run view --web $run_id &&
    gh run watch $run_id
}

ghdeploybranch() {
    local workflow=$(find_deploy_workflow)
    if [ -z "$workflow" ]; then
        echo "Error: No deploy workflow file found"
        return 1
    fi
    local branch=$(git branch --show-current)
    gh workflow run "$workflow" --ref $branch -f environment=STAGING &&
    sleep 3 &&
    local run_id=$(gh run list --workflow="$workflow" --limit=1 --json databaseId | jq -r ".[0].databaseId") &&
    gh run view --web $run_id &&
    gh run watch $run_id
}

ghdeploycsc() {
    local branch=$(git rev-parse --verify main &>/dev/null && echo "main" || echo "master")
    gh workflow run export.yml --ref $branch -f pass=1 &&
    sleep 3 &&
    local run_id=$(gh run list --workflow=export.yml --limit=1 --json databaseId | jq -r ".[0].databaseId") &&
    gh run view --web $run_id &&
    gh run watch $run_id
}
