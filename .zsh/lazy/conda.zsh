# ~/.zsh/lazy/conda.zsh
# Lazy-load conda - only initializes when explicitly called

conda() {
    unfunction conda 2>/dev/null
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
    conda "$@"
}
