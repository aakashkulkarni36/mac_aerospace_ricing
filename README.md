# mac_aerospace_ricing 🌌

A premium, lightweight, Hyprland-inspired tiling window manager setup for macOS using **AeroSpace**, **SketchyBar**, and **JankyBorders**. Designed for minimal memory footprint (~40–80 MB total RAM) with **zero SIP disabling required**.

---

## 🛠️ Stack & Components

* **Window Manager**: [AeroSpace](https://github.com/nikitabobko/AeroSpace) (tree-based tiling, virtual workspaces, dynamic hooks)
* **Floating Island Status Bar**: [SketchyBar](https://github.com/FelixKratz/SketchyBar) (modular frosted glass pills split around the MacBook camera notch)
* **Window Borders**: [JankyBorders](https://github.com/FelixKratz/JankyBorders) (hardware-accelerated active accent borders sampled from desktop wallpaper)
* **Editor Aesthetics**: Visual Studio Code with native frosted glass opacity via [Glassy](https://marketplace.visualstudio.com/items?itemName=optimistengineer.glassy) & Catppuccin Mocha.

---

## 📁 Repository Structure

```text
.
├── .config/
│   ├── aerospace/
│   │   └── aerospace.toml            # Master tiling config, gaps, rules & keybindings
│   ├── borders/
│   │   └── bordersrc                 # Active gradient & inactive border styling
│   ├── sketchybar/
│   │   ├── colors.sh                 # Frosted glass palette & Catppuccin tokens
│   │   ├── sketchybarrc              # Modular floating island pill brackets
│   │   └── plugins/
│   │       ├── aerospace.sh          # Smart occupied/active workspace indicators
│   │       ├── battery.sh            # Live battery percentage & charging glyph
│   │       ├── clock.sh              # 12-hour clock with live seconds
│   │       ├── cpu.sh                # Explicit CPU Used % metric
│   │       ├── ram.sh                # Explicit RAM Used % metric
│   │       ├── volume.sh             # Audio output level & mute indicators
│   │       ├── weather.sh            # Live location & Celsius temperature with cache
│   │       └── wifi.sh               # Active Wi-Fi SSID / connection state
│   └── vscode/
│       └── settings.json             # Dark frosted slate editor & sidebar styling
├── .local/
│   └── bin/
│       ├── aeroshortcuts             # Interactive CLI cheatsheet (alias: ars)
│       ├── aerospace-arrange-master-stack # 50/50 master-stack layout arranger
│       ├── aerospace-enforce-max-tiles    # Strict max-3 window limit per space
│       ├── aerospace-rice-daemon          # Real-time event listener for auto-overflow
│       ├── aerospace-smart-fullscreen     # Smart fullscreen stash & restore
│       └── aerospace-workspace-hook       # Space switch & dynamic pill update hook
├── CHEATSHEET.md                     # Markdown shortcut reference
├── setup_vscode.sh                   # VS Code configuration sync script
└── README.md
```

---

## ⚡ Key Features

1. **Strict 3-Window Limit**:
   * Any workspace accommodates a maximum of 3 tiled windows.
   * If a 4th window spawns or is moved to the space, the real-time background daemon automatically sends it to the adjacent overflow workspace ($N+1$).
2. **Master-Stack Layout (`Alt + m`)**:
   * Easily formats 3 windows into a 50/50 split: **Left Half = Full-Height Master window**, **Right Half = 2 Stacked windows**.
3. **Smart Fullscreen Stash (`Alt + f`)**:
   * Maximizes the active window and stashes all other workspace windows into an adjacent space ($N+1$).
   * Pressing `Alt + f` again brings all stashed windows back to their original positions.
4. **Preserved Workspace Sizing**:
   * Custom resizing adjustments (`Alt + Arrows`) are preserved when switching between spaces.
5. **Detailed Hardware Pills**:
   * SketchyBar displays explicit labels for **CPU Used %**, **RAM Used %**, and a clock with **live seconds**.

---

## ⌨️ Essential Keybindings (Modifier: `Alt` / `⌥`)

| Shortcut | Action |
| :--- | :--- |
| `Alt + h/j/k/l` | Focus Left / Down / Up / Right (Vim keys) |
| `Alt + Shift + h/j/k/l` | Move / Swap window Left / Down / Up / Right |
| `Alt + m` | Arrange 3 windows into Master-Stack layout |
| `Alt + \` / `Alt + Shift + \` | Join window with right / left |
| `Alt + -` / `Alt + Shift + -` | Join window with below / above |
| `Alt + /` | Toggle row / column split orientation |
| `Alt + Shift + Space` | Reset & flatten nested containers into clean grid |
| `Alt + b` | Balance window sizes evenly (50/50 split) |
| `Alt + Arrows` | Resize active window width / height (±64px) |
| `Alt + f` | Smart Fullscreen toggle (stashes other windows) |
| `Alt + Shift + f` | Toggle Floating / Tiling mode |
| `Alt + t` | Quick launch / focus Terminal (iTerm2) |
| `Alt + 1..5` | Jump to Workspace 1–5 |
| `Alt + Shift + 1..5` | Move active window to Workspace 1–5 |
| `Alt + Tab` | Quick back-and-forth between last two spaces |
| `Alt + Shift + r` | Instant reload AeroSpace config |

> **Tip:** Run `ars` or `aeroshortcuts` in your terminal anytime to bring up the colored cheatsheet.
