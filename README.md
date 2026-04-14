# quickruud-dots

Personlig Caelestia-basert Hyprland oppsett for Arch Linux.
Kitty + Bash, Dolphin, norsk radio, JaKooLit + ML4W wallpapers.

## Installasjon fra minimal Arch

```bash
git clone https://github.com/archruud/quickruud-dots
cd quickruud-dots
bash install.sh
```

### Eller én linje (trenger bare curl):

```bash
bash <(curl -s https://raw.githubusercontent.com/archruud/quickruud-dots/main/install.sh)
```

## Hva installeres

| Steg | Script | Innhold |
|------|--------|---------|
| 1 | setup1-base.sh | pacman fix, base-devel, brukermapper |
| 2 | setup2-drivers.sh | Mesa, Intel Arc, Wayland |
| 3 | setup3-yay.sh | yay AUR helper |
| 4 | setup4-caelestia.sh | Caelestia dots + shell + cli (git) + VSCodium skin |
| 5 | setup5-apps.sh | alle programmer + SDDM |
| 6 | setup6-config.sh | Dolphin/kitty fix, keybindings, radio |
| 7 | setup7-extras.sh | quickshell-overview, wallpapers, reboot |

## Programmer

| Program | Pakke |
|---------|-------|
| Terminal | kitty |
| Filbehandler | dolphin |
| Teksteditor | kate |
| Kontorpakke | libreoffice-fresh-nb |
| PDF-notat | xournalpp |
| WiFi-monitor | wavemon |
| Nettleser | zen-browser + firefox |
| Kode | vscodium |
| Musikk | spotify |

## Keybindings

| Tast | Handling |
|------|----------|
| SUPER + Return | Kitty terminal |
| SUPER + SHIFT + Return | hdrop dropdown (fra toppen) |
| CTRL + Tab | Overview (alle 10 arbeidsområder) |
| SUPER + E | Dolphin |
| SUPER + B | Firefox |
| SUPER + W | Zen browser (Caelestia) |
| SUPER + M | Norsk radio |
| SUPER + SHIFT + S | Screenshot – frys + velg område |
| Print | Screenshot – fullskjerm |
| SUPER + ALT + S | Screenshot – aktivt vindu |

## Dine config-filer (trygg ved oppdateringer)

```
~/.config/caelestia/
    hypr-user.conf    ← keybindings
    hypr-vars.conf    ← variabler
    shell.json        ← Quickshell
```

## Oppdatering

```bash
yay -Syu
cd ~/.local/share/caelestia && git pull
cd ~/.config/quickshell/overview && git pull
cd ~/Pictures/Wallpapers && git pull
cd ~/Pictures/ml4w-wallpapers && git pull
```
