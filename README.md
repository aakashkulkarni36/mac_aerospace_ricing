# mac_aerospace_ricing 🌌

A premium, lightweight, Hyprland-inspired tiling window manager setup for macOS using **AeroSpace**, **SketchyBar**, and **JankyBorders**. Designed for minimal memory footprint (~40–80 MB total RAM) with **zero SIP disabling required**.

---

## 🛠️ Stack & Components

* **Window Manager**: [AeroSpace](https://github.com/nikitabobko/AeroSpace) (tree-based tiling, virtual workspaces, dynamic hooks)
* **Floating Island Status Bar**: [SketchyBar](https://github.com/FelixKratz/SketchyBar) (modular frosted glass pills split around the MacBook camera notch)
* **Window Borders**: [JankyBorders](https://github.com/FelixKratz/JankyBorders) (hardware-accelerated active accent borders sampled from desktop wallpaper)
* **Typography**: **JetBrainsMono Nerd Font Propo** (proportional, high-legibility bold weights with refined kerning and prominent 16pt glyphs)
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
│   │       ├── cpu.sh                # Explicit CPU metric
│   │       ├── ram.sh                # Explicit RAM metric
│   │       ├── volume.sh             # Audio output level & mute indicators
│   │       ├── weather.sh            # Live location & Celsius temperature with cache
│   │       └── wifi.sh               # Active Wi-Fi SSID / connection state
│   └── vscode/
│       └── settings.json             # Dark frosted slate editor & sidebar styling
├── .local/
│   └── bin/
│       ├── aeroshortcuts             # Interactive CLI cheatsheet (alias: ars)
│       ├── aerospace-arrange-master-stack      # Left master-stack layout arranger
│       ├── aerospace-toggle-master-horizontal  # Multi-layout cycle toggle (Alt + ,)
│       ├── aerospace-enforce-max-tiles         # Strict max-3 window limit per space
│       ├── aerospace-rice-daemon               # Real-time event listener for auto-overflow
│       ├── aerospace-smart-fullscreen          # Smart fullscreen stash & restore (Alt + f)
│       └── aerospace-workspace-hook            # Space switch & dynamic pill update hook
├── CHEATSHEET.md                     # Markdown shortcut reference
├── setup_vscode.sh                   # VS Code configuration sync script
└── README.md
```

---

## ⚡ Key Features

1. **Strict 3-Window Limit**:
   * Any workspace accommodates a maximum of 3 tiled windows.
   * If a 4th window spawns, the real-time background daemon automatically sends it to the adjacent overflow workspace ($N+1$).
2. **Cycle Multi-Layout Toggle (`Alt + ,`)**:
   * One shortcut cycles seamlessly across three layouts:
     * **Mode 1 (Left Master)**: Left half full height + Right 2 stacked top & bottom.
     * **Mode 2 (Top Master)**: Top half full width + Bottom 2 side-by-side.
     * **Mode 3 (3 Columns)**: 3 side-by-side vertical columns.
     * On 2 windows, it toggles between side-by-side (horizontal) and stacked (vertical).
3. **Smart Fullscreen Stash (`Alt + f`)**:
   * Maximizes the active window while moving other windows on that workspace into a temporary stash workspace ($N+90$).
   * Toggling `Alt + f` again restores stashed windows back onto the current workspace.
4. **Refined Typography & Spacing**:
   * Standardized on **JetBrainsMono Nerd Font Propo** across all SketchyBar items for smooth, non-monolithic proportions and crisp legibility.
5. **Interactive Functional Status Pills**:
   * Click **Clock** to open Apple Calendar.
   * Click **Weather** to open Apple Weather.
   * Click **Volume** to toggle mute.
   * Click **Battery** or **Wi-Fi** to jump straight to macOS System Settings.
   * Click **CPU / RAM** to open Activity Monitor.
   * Click any **Workspace number** to instantly jump to that space.
6. **Live Multi-Space App Badges**:
   * Displays distinct app glyphs across both active and background occupied workspaces.
7. **True Frosted Glass Aesthetic (`#26353B`)**:
   * Color tokens sampled directly from native macOS dark vibrant material (`0xc21e2d36` bar pills, `0xd818252d` popups).
   * Backed by native macOS WindowServer 50px Gaussian blur on popups with refined cyan glass rims (`0x3874c7ec` / `0x4538bdf8`).
8. **Robust Hover HUD Architecture**:
   * Both **Weather** and **Hardware (CPU + RAM)** pills feature hover-triggered popup HUDs with a bidirectional timestamp bridging mechanism (350ms grace period).
   * Hovering over any element in the pill or moving your cursor directly into the popup card keeps the details visible without jitter or unintended closures.
9. **Symmetrical 10 pt Window Margins**:
   * Calibrated 10 pt gap on all four sides of tiled windows (left: 10, right: 10, bottom: 10, top gap from pill: 10 pt).
10. **Zero Camera Notch Clearance**:
    * MacBook Air M2 camera notch (X ≈ 775 to 935) has over 100 pt buffer on either side with no pill overlap.

