#!/bin/bash
#==============================================================================
# setup6-config.sh
# Dolphin+kitty fix, hypr-user.conf, keybindings, screenshots, radio
#==============================================================================
set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; BLUE='\033[0;34m'; NC='\033[0m'
log()    { echo -e "${GREEN}[✓]${NC} $1"; }
info()   { echo -e "${CYAN}[i]${NC} $1"; }
header() { echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"; echo -e "${BLUE}  $1${NC}"; echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"; }

header "Setup 6 – Config, Dolphin, Keybindings, Radio"

CAELESTIA_CFG="$HOME/.config/caelestia"
HYPR_SCRIPTS="$HOME/.config/hypr/scripts"
KITTY_CFG="$HOME/.config/kitty"
SCREENSHOT_DIR="$HOME/Pictures/Screenshots"

mkdir -p "$CAELESTIA_CFG" "$HYPR_SCRIPTS" "$KITTY_CFG" "$SCREENSHOT_DIR"

# ── Dolphin + Kitty fix ─────────────────────────────────────
info "Dolphin + Kitty fix..."
sudo ln -sf /usr/share/applications/kitty.desktop \
            /usr/share/applications/org.kde.konsole.desktop
mkdir -p "$HOME/.config"
grep -q "TerminalApplication=kitty" "$HOME/.config/kdeglobals" 2>/dev/null || \
    printf '\n[General]\nTerminalApplication=kitty\n' >> "$HOME/.config/kdeglobals"
XDG_MENU_PREFIX=arch- kbuildsycoca6 2>/dev/null || true
log "Dolphin + Kitty ferdig"

# ── hypr-vars.conf ──────────────────────────────────────────
cat > "$CAELESTIA_CFG/hypr-vars.conf" << 'CONF'
$terminal    = kitty
$fileManager = dolphin
$browser     = zen-browser
$editor      = zed
CONF
log "hypr-vars.conf skrevet"

# ── hypr-user.conf ──────────────────────────────────────────
cat > "$CAELESTIA_CFG/hypr-user.conf" << 'CONF'
# quickruud-dots – hypr-user.conf
# Archruud sine keybindings – trygg ved Caelestia-oppdateringer

# ─── Environment ───────────────────────────────────────────
env = XDG_MENU_PREFIX,arch-
env = TERMINAL,kitty

# ─── Autostart ─────────────────────────────────────────────
exec-once = qs -c overview
exec-once = hdrop -b -f -h 35 -w 75 -p top -g 45 kitty --class kitty_top

# ─── Fjern Caelestia sine kolliderende keybinds ────────────
unbind = SUPER, T

# ─── Terminal ──────────────────────────────────────────────
bind = SUPER, Return,       exec, kitty
bind = SUPER SHIFT, Return, exec, hdrop -f -h 35 -w 75 -p top -g 45 kitty --class kitty_top

# ─── Programmer ────────────────────────────────────────────
bind = SUPER, E, exec, dolphin
bind = SUPER, B, exec, firefox
bind = SUPER, M, exec, ~/.config/hypr/scripts/radio.sh

# ─── Screenshots ───────────────────────────────────────────
# SUPER+SHIFT+S = Caelestia sin frys+velg område – beholdes!
# Print         = fullskjerm → ~/Pictures/Screenshots/
# SUPER+ALT+S   = aktivt vindu → ~/Pictures/Screenshots/
bind = Print,        exec, ~/.config/hypr/scripts/screenshot-full.sh
bind = SUPER ALT, S, exec, ~/.config/hypr/scripts/screenshot-active.sh

# ─── Overview (CTRL+Tab) ───────────────────────────────────
bind = CTRL, Tab, exec, qs ipc -c overview call overview toggle

# ─── Windowregler – hdrop fra toppen ───────────────────────
windowrule = float on,                match:class ^(kitty_top)$
windowrule = animation slidefadevert, match:class ^(kitty_top)$

# ─── Cursor ────────────────────────────────────────────────
cursor {
    no_warps = true
}
CONF
log "hypr-user.conf skrevet"

# ── kitty.conf ──────────────────────────────────────────────
cat > "$KITTY_CFG/kitty.conf" << 'CONF'
include ~/.cache/wallust/colors-kitty.conf
font_family         JetBrains Mono Nerd Font
font_size           12.0
cursor_shape        beam
background_opacity  0.92
tab_bar_style       powerline
tab_powerline_style angled
hide_window_decorations yes
CONF
log "kitty.conf skrevet"

# ── Screenshot scripts ──────────────────────────────────────
cat > "$HYPR_SCRIPTS/screenshot-full.sh" << 'SCPT'
#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
grim "$FILE"
wl-copy < "$FILE"
notify-send "Screenshot" "Lagret: $(basename "$FILE")" -t 3000
SCPT
chmod +x "$HYPR_SCRIPTS/screenshot-full.sh"

cat > "$HYPR_SCRIPTS/screenshot-active.sh" << 'SCPT'
#!/bin/bash
DIR="$HOME/Pictures/Screenshots"
mkdir -p "$DIR"
FILE="$DIR/$(date +%Y-%m-%d_%H-%M-%S).png"
GEOM=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
grim -g "$GEOM" "$FILE"
wl-copy < "$FILE"
notify-send "Screenshot" "Lagret: $(basename "$FILE")" -t 3000
SCPT
chmod +x "$HYPR_SCRIPTS/screenshot-active.sh"
log "Screenshot scripts skrevet"

# ── Norsk radio script ──────────────────────────────────────
cat > "$HYPR_SCRIPTS/radio.sh" << 'SCPT'
#!/bin/bash
declare -A RADIO=(
    ["NRK P1"]="https://lyd.nrk.no/nrk_p1_ostlandssendingen_mp3_h"
    ["NRK P2"]="https://lyd.nrk.no/nrk_p2_mp3_h"
    ["NRK P3"]="https://lyd.nrk.no/nrk_p3_mp3_h"
    ["NRK mP3"]="https://lyd.nrk.no/nrk_mp3_mp3_h"
    ["NRK Jazz"]="https://lyd.nrk.no/nrk_jazz_mp3_h"
    ["NRK Klassisk"]="https://lyd.nrk.no/nrk_klassisk_mp3_h"
    ["P4"]="https://p4.p4.no:443/p4"
    ["Radio Norge"]="https://stream.radionorge.no/radionorge"
    ["The Beat"]="https://stream.thebeat.no/thebeat"
    ["Stopp"]="STOP"
)
CHOICE=$(printf '%s\n' "${!RADIO[@]}" | sort | wofi --dmenu --prompt "Radio" --width 400 --height 380)
[[ -z "$CHOICE" ]] && exit 0
[[ "$CHOICE" == "Stopp" ]] && { pkill -f "mpv.*http" 2>/dev/null; notify-send "Radio" "Stoppet" -t 2000; exit 0; }
pkill -f "mpv.*http" 2>/dev/null || true
mpv --no-video --really-quiet "${RADIO[$CHOICE]}" &
notify-send "Radio" "$CHOICE" -t 3000
SCPT
chmod +x "$HYPR_SCRIPTS/radio.sh"
log "radio.sh skrevet"

echo ""
log "Setup 6 ferdig! Kjør nå: bash scripts/setup7-extras.sh"
