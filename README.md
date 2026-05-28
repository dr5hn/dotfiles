# dotfiles 🐚

My macOS zsh setup — modular, fast to start, and easy to extend. The `.zshrc`
is a thin loader; everything real lives in small, focused files under `~/.zsh/`.

## What's inside

| Path | Purpose |
|------|---------|
| `.zshrc` | Entry point — runs `compinit`, then sources every module under `~/.zsh/` |
| `.zprofile` | Login-shell notes (PATH and fnm are handled in the modules) |
| `.p10k.zsh` | [Powerlevel10k](https://github.com/romkatv/powerlevel10k) prompt config (agnoster-style) |
| `.gitconfig` / `.gitignore_global` | Git settings and global ignores |

### `~/.zsh/` modules

```
path.zsh        # PATH (deduped via `typeset -U path`)
env.zsh         # environment variables
history.zsh     # 50k-line shared, de-duplicated history
ssh.zsh         # ssh-agent via macOS Keychain
tools.zsh       # fzf, zoxide, bat integrations
plugins.zsh     # interactive UX plugins (loaded last)
lib/
  cache-init.zsh  # caches slow `eval "$(tool init)"` snippets, refreshed on upgrade
lazy/
  fnm.zsh         # Node — lazy-loaded, silent auto-switch on cd
  pyenv.zsh       # Python — lazy-loaded
  conda.zsh       # conda — lazy-loaded
aliases/
  composer.zsh  dev.zsh  git.zsh  utils.zsh
functions/
  dev.zsh  git.zsh  utils.zsh
```

## Features

- **Fast startup** — slow tool inits (Powerlevel10k, zoxide, fzf) are cached to disk and only regenerated when the tool is upgraded; version managers (fnm/pyenv/conda) are lazy-loaded.
- **Powerlevel10k** prompt — agnoster-style powerline, shows `user@host` only over SSH/as root.
- **Interactive UX** — [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting), [fzf-tab](https://github.com/Aloxaf/fzf-tab), and history-substring-search (↑/↓).
- **Modern CLI tools** — `fnm`, `fzf`, `zoxide`, `fd`, `bat`, `eza`.
- **Big shared history** — 50k lines, de-duplicated, shared live across sessions.

## Requirements

macOS with [Homebrew](https://brew.sh). Install the tooling:

```sh
brew install powerlevel10k fnm fzf zoxide fd bat eza \
  zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search fzf-tab
```

## Install

Clone, then copy the dotfiles into your home directory:

```sh
git clone git@github.com:dr5hn/dotfiles.git
cd dotfiles
cp -R .zshrc .zprofile .p10k.zsh .zsh .gitconfig .gitignore_global ~/
exec zsh
```

> **Note:** machine- and org-specific values (e.g. `$GH_ORG`, `$COMPOSER_VENDOR`)
> live in `~/.zsh/private.zsh`, which is **not** tracked here. Create your own if
> you use the aliases that reference them — the rest works without it.

## License

[MIT](LICENSE)
