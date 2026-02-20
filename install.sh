#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ---------------------------------------------------------------------------
# Package installation
# ---------------------------------------------------------------------------

if command -v apt-get &>/dev/null; then
    sudo apt-get update -qq
    sudo apt-get install -y ripgrep fd-find fzf eza
elif command -v brew &>/dev/null; then
    brew install ripgrep fd fzf eza
else
    echo "WARNING: Neither apt-get nor brew found. Install ripgrep, fd, fzf, and eza manually." >&2
fi

# ---------------------------------------------------------------------------
# Starship prompt
# ---------------------------------------------------------------------------

if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh
else
    echo "starship already installed, skipping."
fi

# ---------------------------------------------------------------------------
# Symlink configs
# ---------------------------------------------------------------------------

# .bashrc — back up any non-symlink existing file
if [[ -f ~/.bashrc && ! -L ~/.bashrc ]]; then
    echo "Backing up existing ~/.bashrc to ~/.bashrc.bak"
    mv ~/.bashrc ~/.bashrc.bak
fi
ln -sf "$DOTFILES_DIR/.bashrc" ~/.bashrc

# .profile — back up any non-symlink existing file
if [[ -f ~/.profile && ! -L ~/.profile ]]; then
    echo "Backing up existing ~/.profile to ~/.profile.bak"
    mv ~/.profile ~/.profile.bak
fi
ln -sf "$DOTFILES_DIR/.profile" ~/.profile

# starship config
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/starship.toml" ~/.config/starship.toml

echo ""
echo "Done! Open a new shell or run: source ~/.bashrc"
