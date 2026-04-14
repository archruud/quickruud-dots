#!/bin/bash
#==============================================================================
# setup2-drivers.sh
# Mesa, Intel Arc drivere og Wayland basis
# Fikser "no mesa" feilen ved minimal Arch install
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 2 – Intel/Mesa drivere og Wayland"

sudo pacman -S --needed --noconfirm \
    mesa \
    lib32-mesa \
    vulkan-intel \
    lib32-vulkan-intel \
    intel-media-driver \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal-gtk \
    pipewire \
    pipewire-pulse \
    pipewire-alsa \
    wireplumber \
    polkit-gnome \
    archlinux-xdg-menu

log "Drivere og Wayland basis installert"
echo ""
log "Setup 2 ferdig! Kjør nå: bash scripts/setup3-yay.sh"
