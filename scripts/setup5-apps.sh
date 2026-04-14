#!/bin/bash
#==============================================================================
# setup5-apps.sh
# Alle programmer – pacman + AUR
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 5 – Programmer"

info "Pacman pakker..."
sudo pacman -S --needed --noconfirm \
    kitty \
    dolphin \
    kate \
    libreoffice-fresh \
    libreoffice-fresh-nb \
    xournalpp \
    wavemon \
    firefox \
    grim \
    slurp \
    swappy \
    wl-clipboard \
    mpv \
    wofi \
    sddm

log "Pacman pakker installert"

info "AUR pakker..."
yay -S --needed --noconfirm \
    zen-browser-bin \
    zed \
    vscodium-bin \
    spotify \
    hdrop-git

log "AUR pakker installert"

# SDDM aktivert
sudo systemctl enable sddm
log "SDDM aktivert"

echo ""
log "Setup 5 ferdig! Kjør nå: bash scripts/setup6-config.sh"
