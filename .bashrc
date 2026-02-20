# Source system-wide config if present
[[ -f /etc/bash.bashrc ]] && . /etc/bash.bashrc

# ---------------------------------------------------------------------------
# Environment
# ---------------------------------------------------------------------------

# Add common user-local bin dirs to PATH
for _dir in "$HOME/.local/bin" "$HOME/.cargo/bin"; do
    [[ -d "$_dir" && ":$PATH:" != *":$_dir:"* ]] && export PATH="$_dir:$PATH"
done
unset _dir

# Rust toolchain env (sets PATH, CARGO_HOME, etc.)
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ---------------------------------------------------------------------------
# Shell options
# ---------------------------------------------------------------------------

shopt -s histappend                    # append to history, don't overwrite
shopt -s checkwinsize                  # update LINES/COLUMNS after each command
shopt -s cdspell                       # correct minor spelling errors in cd

PROMPT_COMMAND="history -a"
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL=ignoreboth                 # ignore duplicates + lines starting with space

# ---------------------------------------------------------------------------
# Display
# ---------------------------------------------------------------------------

# Make less handle non-text input (tarballs, PDFs, etc.)
[[ -x /usr/bin/lesspipe ]] && eval "$(SHELL=/bin/sh lesspipe)"

# eza — modern ls replacement
if command -v eza &>/dev/null; then
    alias ls='eza'
    alias ll='eza -l --git'
    alias la='eza -la --git'
    alias lt='eza --tree'
fi

# rg — grep replacement (note: ignores .gitignore by default, flags differ slightly)
if command -v rg &>/dev/null; then
    alias grep=rg
fi

# ---------------------------------------------------------------------------
# Bash completion
# ---------------------------------------------------------------------------

if ! shopt -oq posix; then
    if [[ -f /usr/share/bash-completion/bash_completion ]]; then
        . /usr/share/bash-completion/bash_completion
    elif [[ -f /etc/bash_completion ]]; then
        . /etc/bash_completion
    fi
fi

# ---------------------------------------------------------------------------
# fzf key bindings
# ---------------------------------------------------------------------------

# Try locations in order: git clone, apt (Ubuntu/Debian), brew (macOS)
for _fzf_bindings in \
    "$HOME/.fzf/shell/key-bindings.bash" \
    "/usr/share/doc/fzf/examples/key-bindings.bash" \
    "/opt/homebrew/opt/fzf/shell/key-bindings.bash" \
    "/usr/local/opt/fzf/shell/key-bindings.bash"
do
    if [[ -f "$_fzf_bindings" ]]; then
        source "$_fzf_bindings"
        break
    fi
done
unset _fzf_bindings

# ---------------------------------------------------------------------------
# fd alias (Ubuntu installs the binary as fdfind)
# ---------------------------------------------------------------------------

if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
    alias fd=fdfind
fi

# ---------------------------------------------------------------------------
# NVM (lazy-loaded to avoid slowing down shell startup)
# ---------------------------------------------------------------------------

export NVM_DIR="$HOME/.nvm"
nvm_init() {
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
}
# Only define the function if NVM is actually installed
[[ -d "$NVM_DIR" ]] || unset -f nvm_init NVM_DIR

# ---------------------------------------------------------------------------
# Starship prompt
# ---------------------------------------------------------------------------

if command -v starship &>/dev/null; then
    eval "$(starship init bash)"
fi
