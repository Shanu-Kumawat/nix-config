#!/bin/bash

# Define paths
DOTFILES_DIR="$HOME/.dotfiles"
NVIM_SOURCE="$DOTFILES_DIR/config/nvim"
NVIM_TARGET="$HOME/.config/nvim"
NIXOS_SOURCE="$DOTFILES_DIR/nixos"
NIXOS_TARGET="/etc/nixos"

# Function to create a symlink
create_symlink() {
    local source=$1
    local target=$2

    if [ -L "$target" ]; then
        echo "Symlink already exists: $target"
    elif [ -e "$target" ]; then
        echo "A file/directory already exists at $target. Please resolve this manually."
    else
        ln -s "$source" "$target"
        echo "Created symlink: $target -> $source"
    fi
}

# Ensure ~/.config exists
mkdir -p "$HOME/.config"

# Create Neovim symlink
create_symlink "$NVIM_SOURCE" "$NVIM_TARGET"

# Check if running as root for /etc/nixos
if [ "$EUID" -ne 0 ]; then
    echo "Root privileges are required to create a symlink in /etc/nixos."
    echo "Run this script with sudo."
    exit 1
fi

# Create NixOS symlink
create_symlink "$NIXOS_SOURCE" "$NIXOS_TARGET"

# Success message
echo "All symlinks created successfully!"
