#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

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
