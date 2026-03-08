#!/usr/bin/env bash

set -euo pipefail

# ---------------------------------------------------------------------------
# Shell utilities: ripgrep, fd, fzf, eza
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
# GitHub CLI (gh)
# ---------------------------------------------------------------------------

if ! command -v gh &>/dev/null; then
    if command -v apt-get &>/dev/null; then
        curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
            | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
        sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg
        echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
            | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
        sudo apt-get update -qq
        sudo apt-get install -y gh
    elif command -v brew &>/dev/null; then
        brew install gh
    else
        echo "WARNING: Cannot install gh. Install it manually from https://cli.github.com" >&2
    fi
else
    echo "gh already installed, skipping."
fi

# ---------------------------------------------------------------------------
# Claude Code CLI
# ---------------------------------------------------------------------------

if ! command -v claude &>/dev/null; then
    if command -v npm &>/dev/null; then
        npm install -g @anthropic-ai/claude-code
    else
        echo "WARNING: npm not found. Install Node.js/npm first, then run: npm install -g @anthropic-ai/claude-code" >&2
    fi
else
    echo "claude already installed, skipping."
fi

echo ""
echo "Done! You may need to open a new shell for PATH changes to take effect."
