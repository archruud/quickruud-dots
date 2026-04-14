#!/bin/bash
#==============================================================================
# setup4-caelestia.sh
# Caelestia dotfiles + quickshell (git versjon)
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 4 – Caelestia"

# Git-versjoner fra AUR (viktig!)
yay -S --needed --noconfirm \
    quickshell-git \
    caelestia-shell-git \
    caelestia-cli-git

log "Caelestia AUR pakker installert"

# Klon caelestia config-repoet
CAELESTIA_DIR="$HOME/.local/share/caelestia"
if [[ -d "$CAELESTIA_DIR" ]]; then
    warn "Caelestia repo finnes – oppdaterer..."
    git -C "$CAELESTIA_DIR" pull
else
    git clone https://github.com/caelestia-dots/caelestia.git "$CAELESTIA_DIR"
fi

# Kjør Caelestia sin installer
info "Kjører Caelestia install.fish..."
fish "$CAELESTIA_DIR/install.fish" --aur-helper=yay --noconfirm --vscode=codium

# Lag brukerens config-mappe (trygg ved oppdateringer)
mkdir -p "$HOME/.config/caelestia"
touch "$HOME/.config/caelestia/hypr-user.conf"
touch "$HOME/.config/caelestia/hypr-vars.conf"

log "Caelestia installert"
echo ""
log "Setup 4 ferdig! Kjør nå: bash scripts/setup5-apps.sh"
