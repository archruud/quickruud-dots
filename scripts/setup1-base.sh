#!/bin/bash
#==============================================================================
# setup1-base.sh
# Kjøres ETTER minimal Arch install + reboot
# Forutsetter: nett er oppe, git er installert via archinstall
#
# Bruk:
#   git clone https://github.com/archruud/quickruud-dots
#   cd quickruud-dots
#   bash scripts/setup1-base.sh
#==============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

[[ $EUID -eq 0 ]] && { echo "Ikke kjør som root!"; exit 1; }

header "Setup 1 – Basis og pacman fix"

# Pacman fix (fra archruud/stl/pacmanfix.sh logikk)
info "Oppdaterer pacman nøkler..."
sudo pacman-key --init
sudo pacman-key --populate archlinux
sudo pacman -Sy archlinux-keyring --noconfirm
log "Pacman nøkler oppdatert"

# Oppdater system
info "Oppdaterer system..."
sudo pacman -Syu --noconfirm
log "System oppdatert"

# Installer base-devel (mangler i minimal install!)
info "Installerer base-devel, git og basis..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    nano \
    curl \
    wget \
    jq \
    awk \
    fish \
    xdg-user-dirs

log "Basis pakker installert"

# Opprett norske brukermapper (Pictures, Documents, osv.)
info "Oppretter brukermapper..."
LANG=nb_NO.UTF-8 xdg-user-dirs-update
log "Brukermapper opprettet"

# Vis hva som ble laget
info "Dine brukermapper:"
ls ~/ | grep -E "Bilder|Dokumenter|Nedlastinger|Musikk|Videoklipp|Skrivebord|Maler|Offentlig" || \
ls ~/ | grep -E "Pictures|Documents|Downloads|Music|Videos|Desktop"

echo ""
log "Setup 1 ferdig! Kjør nå: bash scripts/setup2-drivers.sh"
