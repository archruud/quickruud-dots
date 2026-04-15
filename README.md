# quickruud-dots

Personal Caelestia-based Hyprland setup for Arch Linux.
Kitty + Bash, Dolphin, Norwegian radio, JaKooLit + ML4W wallpapers.

## Before You Start

### 1. Tweak pacman.conf for a better experience

Open the file with nano:

```bash
sudo nano /etc/pacman.conf
```

#### Enable Color and eye candy

Find and uncomment these lines (remove the `#`):

```
#Color
#ILoveCandy
```

So they look like this:

```
Color
ILoveCandy
```

#### Speed up downloads with parallel downloads

Find this line:

```
#ParallelDownloads = 5
```

Change it to (5 is default – if you have 1Gbit or faster, increase it significantly):

```
ParallelDownloads = 22
```

> **Tip:** With a 1Gbit connection, setting this to 20+ makes a huge difference in installation speed.
> The default of 5 is very conservative.

#### Enable multilib repository (required for 32-bit libraries)

Find these two lines near the bottom of the file:

```
#[multilib]
#Include = /etc/pacman.d/mirrorlist
```

Remove the `#` from both lines:

```
[multilib]
Include = /etc/pacman.d/mirrorlist
```

This is required for `lib32-mesa` and `lib32-vulkan-intel` to install correctly in setup2.

Save with `Ctrl+S` and exit with `Ctrl+X`.

#### Update package databases and verify multilib is active

```bash
sudo pacman -Syyu
```

You should now see `core`, `extra` and `multilib` all being synchronized. If multilib shows up – you are good to go.

---

## Installation from Minimal Arch

```bash
git clone https://github.com/archruud/quickruud-dots
cd quickruud-dots
bash install.sh
```

### Or one line (only needs curl):

```bash
bash <(curl -s https://raw.githubusercontent.com/archruud/quickruud-dots/main/install.sh)
```

---

## What Gets Installed

| Step | Script | Content |
|------|--------|---------|
| 1 | setup1-base.sh | pacman keyring fix, base-devel, user folders |
| 2 | setup2-drivers.sh | Mesa, Intel Arc, Wayland |
| 3 | setup3-yay.sh | yay AUR helper |
| 4 | setup4-caelestia.sh | Caelestia dots + shell + cli (git versions) + VSCodium skin |
| 5 | setup5-apps.sh | all applications + SDDM |
| 6 | setup6-config.sh | Dolphin/kitty fix, keybindings, radio script |
| 7 | setup7-extras.sh | quickshell-overview, wallpapers, reboot |

---

## Applications

| Application | Package |
|-------------|---------|
| Terminal | kitty |
| File manager | dolphin |
| Text editor | kate |
| Office suite | libreoffice-fresh-nb (Norwegian) |
| PDF annotation | xournalpp |
| WiFi monitor | wavemon |
| Browser 1 | zen-browser |
| Browser 2 | firefox |
| Code editor | vscodium |
| Music | spotify |

---

## Keybindings

| Key | Action |
|-----|--------|
| SUPER + Return | Kitty terminal |
| SUPER + SHIFT + Return | hdrop dropdown terminal (slides from top) |
| CTRL + Tab | Overview (all 10 workspaces) |
| SUPER + E | Dolphin file manager |
| SUPER + B | Firefox |
| SUPER + W | Zen browser (Caelestia default) |
| SUPER + M | Norwegian radio (wofi menu) |
| SUPER + SHIFT + S | Screenshot – freeze + select area (Caelestia) |
| Print | Screenshot – full screen → ~/Pictures/Screenshots/ |
| SUPER + ALT + S | Screenshot – active window → ~/Pictures/Screenshots/ |

---

## Your Config Files (safe during updates)

All personal settings live here and are never touched by Caelestia updates:

```
~/.config/caelestia/
    hypr-user.conf    ← your keybindings
    hypr-vars.conf    ← your variables
    shell.json        ← Quickshell config
```

---

## Updating

```bash
yay -Syu
cd ~/.local/share/caelestia && git pull
cd ~/.config/quickshell/overview && git pull
cd ~/Pictures/Wallpapers && git pull
cd ~/Pictures/ml4w-wallpapers && git pull
```

---

## Wallpapers

Two collections are installed:

- `~/Pictures/Wallpapers` – JaKooLit Wallpaper Bank (default for Caelestia)
- `~/Pictures/ml4w-wallpapers` – ML4W high quality collection

Switch wallpaper folder in Caelestia launcher: press `Super` → type `>` → type `wallpaper`
