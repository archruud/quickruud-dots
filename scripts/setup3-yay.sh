#!/bin/bash
#==============================================================================
# setup3-yay.sh
# AUR helper – yay
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 3 – yay AUR helper"

if command -v yay &>/dev/null; then
    warn "yay er allerede installert"
    yay -Syu --noconfirm
else
    info "Installerer yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si --noconfirm
    cd /tmp && rm -rf yay
    log "yay installert"
fi

echo ""
log "Setup 3 ferdig! Kjør nå: bash scripts/setup4-caelestia.sh"
