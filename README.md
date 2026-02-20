# dotfiles

Bash environment with [starship](https://starship.rs) prompt.

## What's included

| Tool | Purpose |
|---|---|
| [starship](https://starship.rs) | Cross-shell prompt |
| [ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`) | Fast grep replacement |
| [fd](https://github.com/sharkdp/fd) | Fast find replacement |
| [fzf](https://github.com/junegunn/fzf) | Fuzzy finder + key bindings |

## Install

```bash
git clone https://github.com/Peternator7/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

The script will:
1. Install `ripgrep`, `fd`, and `fzf` via `apt-get` or `brew`
2. Install `starship` via its official install script
3. Symlink `.bashrc` → `~/.bashrc` (backs up any existing file to `~/.bashrc.bak`)
4. Symlink `starship.toml` → `~/.config/starship.toml`

## fzf key bindings

| Key | Action |
|---|---|
| `Ctrl-R` | Fuzzy search shell history |
| `Ctrl-T` | Fuzzy insert file path |
| `Alt-C` | Fuzzy cd into directory |
