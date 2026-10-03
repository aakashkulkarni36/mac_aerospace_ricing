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
│       ├── aerospace-workspace-hook            # Space switch & dynamic pill update hook
│       ├── macos-wallpaper                     # High-performance native Swift desktop picture utility
│       ├── switch-wallpaper                    # Interactive wallpaper & system theme synchronizer
│       └── neofetch                            # Lightweight system information tool
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
11. **Dynamic Wallpaper & Cohesive Theming Engine (`Alt + w`)**:
    * Curated collection matching the serene pastoral landscape & lone wanderer aesthetic (zero watermarks or text):
      1. **Meadow Vista (OG)** (Stefan Hansson - [Wallhaven #5y3571](https://wallhaven.cc/w/5y3571)): Electric Sky Blue (`#38bdf8`) & Vibrant Cyan (`#06b6d4`), frosted slate cyan glass (`0xc21e2d36`).
      2. **Summer Flight** (Bzsk - [Wallhaven #ly36ll](https://wallhaven.cc/w/ly36ll)): Lone wanderer in white dress traversing golden wheat fields with cranes flying into summer cumulus clouds. Accents: Golden Wheat Amber (`#f59e0b`) & Cloud Sky Cyan (`#38bdf8`), frosted warm glass (`0xc228221b`).
      3. **Breeze & Wildflowers** (Gracile - [Wallhaven #8g35ek](https://wallhaven.cc/w/8g35ek)): 5640x2400 ultrawide rolling green meadow with wildflowers and utility poles under towering clouds. Accents: Emerald Green (`#10b981`) & Summer Cyan (`#06b6d4`), frosted jade glass (`0xc2182c24`).
      4. **Sunset Grasslands** (Ibuki Satsuki - [Wallhaven #zp5z2w](https://wallhaven.cc/w/zp5z2w)): 5160x2160 ultrawide sunset breeze across endless fields with flowing garments. Accents: Sunset Amber (`#f97316`) & Twilight Lavender (`#818cf8`), frosted sunset glass (`0xc22b1e22`).
      5. **Lake Horizon** (Gracile - [Wallhaven #d8vv8j](https://wallhaven.cc/w/d8vv8j)): 5640x2400 ultrawide mountain lake reflecting summer clouds. Accents: Vibrant Cyan (`#06b6d4`) & Azure Blue (`#60a5fa`), frosted crystal lake glass (`0xc2182836`).
    * **Full Synchronized Switching**:
      * Instantly sets the macOS desktop across all connected displays via native `NSWorkspace` APIs.
      * Updates SketchyBar frosted floating island backgrounds, pill borders, active space badges, and popup card themes (`current_theme.sh`).
      * Updates JankyBorders active gradient on the fly without service restarts.
      * Dynamically sets VS Code translucent editor background image and tab/focus accent colors.
      * Emits a native macOS banner notification with audio chime detailing the newly applied theme.
    * **CLI Command**:
      * `switch-wallpaper`: Interactive selector displaying the active wallpaper and menu options.
      * `switch-wallpaper next` / `prev`: Cycle forward or backward through the collection.
      * `switch-wallpaper status`: Shows current wallpaper, artist, and live color tokens.
      * `switch-wallpaper <1-5|meadow|flight|breeze|sunset|lake>`: Instant direct theme activation.
      * Available via aliases: `wallpaper-switcher` and `swp`.
      * Mapped to global shortcut **`Alt + w`** in AeroSpace.

