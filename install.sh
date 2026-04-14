#!/bin/bash
#==============================================================================
# quickruud-dots – Installasjon
# github.com/archruud/quickruud-dots
#
# Bruk etter minimal Arch install:
#   git clone https://github.com/archruud/quickruud-dots
#   cd quickruud-dots
#   bash install.sh
#
# Eller direkte:
#   bash <(curl -s https://raw.githubusercontent.com/archruud/quickruud-dots/main/install.sh)
#==============================================================================
set -euo pipefail

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
header() {
    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

[[ $EUID -eq 0 ]] && { echo "Ikke kjør som root!"; exit 1; }

header "quickruud-dots – Caelestia for Arch Linux"
echo -e "  Archruud sitt personlige oppsett"
echo -e "  github.com/archruud/quickruud-dots"
echo ""

# Klon repoet om vi ikke allerede er i det
DOTS_DIR="$HOME/quickruud-dots"
if [[ ! -f "scripts/setup1-base.sh" ]]; then
    if [[ -d "$DOTS_DIR" ]]; then
        warn "Oppdaterer quickruud-dots..."
        git -C "$DOTS_DIR" pull
    else
        info "Kloner quickruud-dots..."
        git clone https://github.com/archruud/quickruud-dots "$DOTS_DIR"
    fi
    cd "$DOTS_DIR"
fi

# Gjør scripts kjørbare
chmod +x scripts/setup*.sh

# Kjør i rekkefølge
header "Steg 1/7 – Basis og pacman fix"
bash scripts/setup1-base.sh

header "Steg 2/7 – Intel/Mesa drivere"
bash scripts/setup2-drivers.sh

header "Steg 3/7 – yay AUR helper"
bash scripts/setup3-yay.sh

header "Steg 4/7 – Caelestia"
bash scripts/setup4-caelestia.sh

header "Steg 5/7 – Programmer"
bash scripts/setup5-apps.sh

header "Steg 6/7 – Config og keybindings"
bash scripts/setup6-config.sh

header "Steg 7/7 – Overview og wallpapers"
bash scripts/setup7-extras.sh

header "Ferdig!"
echo -e "  Reboot for å starte Caelestia med SDDM"
echo ""
read -rp "Reboot nå? (j/n): " svar
[[ "$svar" =~ ^[jJ]$ ]] && sudo reboot
