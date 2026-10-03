# mac_aerospace_ricing

A lightweight, Hyprland-inspired tiling window manager setup for macOS using **AeroSpace** and **JankyBorders**. Designed for minimal memory footprint (~40–60 MB total RAM) and zero SIP-disabling requirements.

## Stack

* **Window Manager**: [AeroSpace](https://github.com/nikitabobko/AeroSpace) (i3/Hyprland-style tree tiling, virtual workspaces)
* **Window Borders**: [JankyBorders](https://github.com/FelixKratz/JankyBorders) (hardware-accelerated active accent borders)

## Directory Structure

```text
.
├── .config/
│   ├── aerospace/
│   │   └── aerospace.toml
│   └── borders/
│       └── bordersrc
└── README.md
```

## Installation

```bash
# 1. Install prerequisites via Homebrew
brew install --cask nikitabobko/tap/aerospace
brew tap FelixKratz/formulae
brew install borders

# 2. Clone repository & link dotfiles
git clone https://github.com/aakashkulkarni36/mac_aerospace_ricing.git ~/projects/mac_aerospace_ricing
mkdir -p ~/.config/aerospace ~/.config/borders

ln -sf ~/projects/mac_aerospace_ricing/.config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/projects/mac_aerospace_ricing/.config/borders/bordersrc ~/.config/borders/bordersrc
chmod +x ~/.config/borders/bordersrc

# 3. Start services
brew services start borders
open -a AeroSpace
```

## Keybindings (Modifier: `Option` / `Alt`)

| Keybinding | Action |
| :--- | :--- |
| `Alt + h/j/k/l` | Focus left / down / up / right |
| `Alt + Shift + h/j/k/l` | Move window left / down / up / right |
| `Alt + \` / `Alt + -` | Split horizontal / vertical |
| `Alt + e` | Toggle tiling orientation |
| `Alt + s` | Accordion layout |
| `Alt + f` | Fullscreen toggle |
| `Alt + Shift + f` | Toggle floating / tiling |
| `Alt + 1..9` | Switch to workspace 1–9 |
| `Alt + Shift + 1..9` | Move window to workspace 1–9 |
| `Alt + Tab` | Toggle previous workspace |
| `Alt + r` | Enter resize mode (`h/j/k/l` to resize, `Esc`/`Enter` to exit) |
| `Alt + Shift + r` | Reload config |
