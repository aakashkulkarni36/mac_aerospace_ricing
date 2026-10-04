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
      6. **Mountain Pass Wanderer** (Pixiv #105664701 - [Wallhaven #7pxrwe](https://wallhaven.cc/w/7pxrwe)): 2500x1055 native 21:9 ultrawide alpine vista featuring a lone wanderer in a flowing dress against billowing summer cloudbanks. Accents: Cerulean Blue (`#38bdf8`) & Mountain Sage Lime (`#a3e635`), frosted alpine glass (`0xc21c2c36`).
      7. **Twilight Horizon** (Gracile - [Wallhaven #e7d368](https://wallhaven.cc/w/e7d368)): 5640x2400 5K ultrawide golden hour dusk with luminous amber clouds descending into deep twilight. Accents: Sunset Amber (`#f59e0b`) & Indigo (`#6366f1`), frosted twilight glass (`0xc22b1f24`).
      8. **Sunlight Canopies** (Gracile - [Wallhaven #6lkdmq](https://wallhaven.cc/w/6lkdmq)): 5640x2400 5K ultrawide warm golden sunlight filtering through rolling cumulus cloud towers over treetop horizons. Accents: Terracotta Sunset (`#ea580c`) & Deep Teal (`#0d9488`), frosted dusk glass (`0xc228201c`).
      9. **Twilight Bloom** (Ibuki Satsuki - [Wallhaven #d8p83m](https://wallhaven.cc/w/d8p83m)): 1890x1134 serene pastoral dusk with fluttering garments, blossom branches, and evening clouds. Accents: Twilight Lavender (`#818cf8`) & Sakura Bloom (`#f472b6`), frosted plum glass (`0xc2241e30`).
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
      * `switch-wallpaper <1-9|meadow|flight|breeze|sunset|lake|ridge|twilight|canopy|bloom>`: Instant direct theme activation.
      * Available via aliases: `wallpaper-switcher` and `swp`.
      * Mapped to global shortcut **`Alt + w`** in AeroSpace.

12. **Multi-Monitor & Ultrawide Display Alignment**:
    * **Dual-Display Geometry**: Full native support for dual-monitor setups pairing the MacBook Air Liquid Retina display (1710x1112 pt) with an external **LG 21:9 Ultrawide Monitor** (2560x1080 @ 60Hz native).
    * **Deterministic Workspace Pinning**:
      * Workspaces `1–3` assigned to the built-in Retina screen (`["built-in", "main"]`).
      * Workspaces `4–9` assigned to the external LG Ultrawide display (`["LG ULTRAWIDE", "secondary"]`).
      * Automatically falls back to available displays when unplugged without breaking workspace layouts.
    * **Calibrated 10 pt Balanced Margins with Notch Awareness**:
      * On the external ultrawide (notchless display), `outer.top = 54 pt` places windows at `y = 54 pt`, leaving a clean 10 pt margin below SketchyBar (`y = 4..44 pt`).
      * On the MacBook Air Liquid Retina display, macOS inherently offsets windows by the 37.5 pt hardware notch height. Using a monitor-specific rule `outer.top = [{ monitor."built-in" = 16 }, 54]` aligns windows at the identical `y = 54 pt` coordinate on both screens.
      * Result: Perfect, uniform 10 pt padding across all four sides (left, right, bottom, and top below the floating island bar) on both built-in and external monitors.
      * SketchyBar spans `y = 4..44 pt` (height 40, offset 4).
      * AeroSpace outer top gap set to `54 pt`, delivering an exact **10 pt visual margin** below the floating status bar.
      * Matches `outer.bottom = 10`, `outer.left = 10`, and `outer.right = 10` for mathematical symmetry on both displays.
    * **Ultrawide Master-Stack Layout**:
      * In 21:9 aspect ratio, 3 windows automatically arrange into a 50/50 master-stack (full-height master on the left, dual vertically stacked windows on the right, each with exact 10 pt spacing).

