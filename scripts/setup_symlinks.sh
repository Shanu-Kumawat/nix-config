#!/usr/bin/env bash
set -euo pipefail

#############################################
# 🖌️ Color & Emoji Helpers
#############################################
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
NC='\033[0m' # No Color

banner() {
  local title="$1"
  echo -e "\n${MAGENTA}=============================================${NC}"
  echo -e "${CYAN}🚀 ==> ${title}${NC}"
  echo -e "${MAGENTA}=============================================${NC}\n"
}

info() {
  echo -e "${BLUE}🔹 [INFO]${NC} $1"
}

warn() {
  echo -e "${YELLOW}⚠️  [WARN]${NC} $1"
}

error() {
  echo -e "${RED}❌ [ERROR]${NC} $1"
}

#############################################
# 📂 Determine Repository Root
#############################################
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

#############################################
# ✨ 1. NVChad Setup
#############################################
banner "Starting NVChad Setup ✨"
NVIM_CONFIG_DIR="$HOME/.config/nvim"

# Remove any existing NVChad configuration.
if [ -d "$NVIM_CONFIG_DIR" ]; then
  info "🗑️ Removing existing ${NVIM_CONFIG_DIR} ..."
  rm -rf "$NVIM_CONFIG_DIR"
fi

# Clone the NVChad starter repository.
info "📥 Cloning the NVChad starter repository..."
git clone https://github.com/NvChad/starter "$NVIM_CONFIG_DIR"

# Launch Neovim once so NVChad can perform its initial setup.
info "🚀 Launching Neovim for initial NVChad setup..."
nvim +qall

# Replace the NVChad configuration with your custom configuration.
info "🔗 Linking your custom NVChad configuration from '${REPO_ROOT}/config/nvim' ..."
rm -rf "$NVIM_CONFIG_DIR"
ln -s "$REPO_ROOT/config/nvim" "$NVIM_CONFIG_DIR"

info "✅ NVChad setup complete!"

#############################################
# 🔄 2. Update the Flake & Regenerate Hardware Config
#############################################
banner "Updating Flake Inputs & Regenerating Hardware Configuration 🔄"
NIXOS_FLAKE_DIR="$REPO_ROOT/nixos"

info "📌 Updating flake inputs in ${NIXOS_FLAKE_DIR}..."
(cd "$NIXOS_FLAKE_DIR" && nix flake update)

# Generate a new hardware configuration and store it in the flake.
HW_CONFIG_FILE="$NIXOS_FLAKE_DIR/hardware-configuration.nix"
info "🛠️ Generating new hardware configuration..."
nixos-generate-config --show-hardware-config > "$HW_CONFIG_FILE"
info "✅ Hardware configuration written to ${HW_CONFIG_FILE}"

#############################################
# ⚙️ 3. Home Manager: Dynamic Alias Configuration Reminder
#############################################
banner "Home Manager Alias Configuration ⚙️"
info "🔄 Your rebuild alias is managed by Home Manager in your home modules."
info "Ensure that your Home Manager configuration includes the alias:"
echo -e "    ${GREEN}nrs = \"sudo nixos-rebuild switch --flake ~/nix-config/nixos#sk-nixos\"${NC}"
info "If not already applied, run:"
echo -e "    ${GREEN}home-manager switch${NC}"
info "to load the updated alias into your Zsh environment."

#############################################
# 🎉 4. Final Instructions
#############################################
banner "🎉 Setup Complete!"
info "✅ Your NVChad configuration has been set up, and your flake inputs have been updated."
info "💡 To rebuild your NixOS system, use the alias (after applying your Home Manager configuration):"
echo -e "    ${GREEN}nrs${NC}"
info "🛠️ This alias runs:"
echo -e "    ${GREEN}sudo nixos-rebuild switch --flake ~/nix-config/nixos#sk-nixos${NC}"
echo -e "\n${CYAN}🚀 Enjoy your newly configured system! 🎯${NC}\n"

