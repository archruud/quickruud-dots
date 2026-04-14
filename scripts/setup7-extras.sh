#!/bin/bash
#==============================================================================
# setup7-extras.sh
# quickshell-overview + wallpapers (JaKooLit + ML4W)
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
warn()   { echo -e "${YELLOW}[!]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 7 – quickshell-overview + wallpapers"

# quickshell-overview
OVERVIEW_DIR="$HOME/.config/quickshell/overview"
mkdir -p "$HOME/.config/quickshell"
if [[ -d "$OVERVIEW_DIR" ]]; then
    warn "quickshell-overview finnes – oppdaterer..."
    git -C "$OVERVIEW_DIR" pull
else
    git clone https://github.com/Shanu-Kumawat/quickshell-overview.git "$OVERVIEW_DIR"
fi

cat > "$OVERVIEW_DIR/config.json" << 'CONF'
{
  "appearance": {
    "colorSource": "caelestia",
    "caelestia": { "autoRefresh": true, "refreshInterval": 2000 }
  },
  "overview": {
    "rows": 2,
    "columns": 5,
    "scale": 0.16,
    "hideEmptyRows": true
  }
}
CONF
log "quickshell-overview installert (2x5 = 10 arbeidsområder)"

mkdir -p "$HOME/Pictures"

# JaKooLit wallpapers (standard for Caelestia)
info "JaKooLit Wallpaper Bank (~1GB)..."
JAKOOLIT="$HOME/Pictures/Wallpapers"
if [[ -d "$JAKOOLIT/.git" ]]; then
    git -C "$JAKOOLIT" pull
else
    git clone https://github.com/JaKooLit/Wallpaper-Bank.git "$JAKOOLIT"
fi
log "JaKooLit: $JAKOOLIT"

# ML4W wallpapers
info "ML4W Wallpapers..."
ML4W="$HOME/Pictures/ml4w-wallpapers"
if [[ -d "$ML4W/.git" ]]; then
    git -C "$ML4W" pull
else
    git clone --depth=1 https://github.com/mylinuxforwork/wallpaper.git "$ML4W"
fi
log "ML4W: $ML4W"

echo ""
log "Setup 7 ferdig!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  ALT INSTALLERT! Reboot for å starte Caelestia"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
read -rp "Reboot nå? (j/n): " svar
[[ "$svar" =~ ^[jJ]$ ]] && sudo reboot
