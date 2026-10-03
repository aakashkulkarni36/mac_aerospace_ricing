# Hyprland-Style Floating Islands for macOS (SketchyBar + AeroSpace + Borders)

A high-performance, battery-optimized status bar tailored specifically around the **MacBook Air M2 Camera Notch** with deep **AeroSpace** tiling integration, authentic application glyphs, anti-jitter pill anchoring, and dark frosted glass popup cards.

---

## 🎨 Visual Architecture & Screen Layout

The MacBook Air M2 display features a centered camera notch between **X ≈ 775** and **X ≈ 935**. All floating islands are arranged to eliminate pill shifting and maintain a **700+ point buffer** across the center.

```
+-----------------------------------------------------------------------------------------------------------------------------------------+
| [ Weather ]  [ Workspaces 1-9 | App ]   --- [ NOTCH 700PT BUFFER ] ---   [ Hardware CPU/RAM ]  [ Volume ]  [ Wi-Fi ]  [ Battery/Clock ] |
+-----------------------------------------------------------------------------------------------------------------------------------------+
```

### 1. Dark Frosted Glass Aesthetic (Smoked Obsidian Acrylic)
* **Bar Island Styling (`0xc21e2d36`):** High-contrast dark smoked obsidian glass (~72% alpha) with delicate luminous cyan glass bevel (`0x4538bdf8`). Eliminates washed-out backgrounds and prevents wallpaper sky gradients from bleeding through.
* **Popup Card Styling (`0xd818252d`, `blur_radius=50`):** Rich, dark frosted glass with native macOS WindowServer Gaussian backdrop blur, luminous cyan rim, and 1px hairline glass dividers (`0x25ffffff`).
* **Vibrant Typography & Accents:** White text, Peach CPU glyphs, Cyan RAM glyphs, Sky Blue weather icons, and Yellow volume icons display with maximum contrast and zero ghosting.

### 2. Symmetrical 10pt Window Margins (All 4 Sides Balanced)
Window gaps in `~/.config/aerospace/aerospace.toml` are tuned to create a uniform **10-point visual margin** across the entire desktop:
* **Left Screen Margin:** 10 pt
* **Right Screen Margin:** 10 pt
* **Bottom Screen Margin:** 10 pt
* **Top Margin (Window Top to Floating Bar Pill Bottom):** 10 pt (`outer.top = 15`)
* **Inner Horizontal Gap (Between Windows):** 10 pt
* **Inner Vertical Gap (Between Stacked Windows):** 10 pt

### 3. Dynamic Weather (`pill_weather` · Leftmost Anchor)
* **Anti-Jitter Design:** Anchored at the far left edge (`X = 12`). Because it sits before the dynamic workspaces, expanding or contracting workspaces and application titles will **never push or shift** the weather pill.
* **Bar Pill:** Real-time condition icon (color-coded to weather status) and temperature (e.g., `󰖖 21°C McKinney`).
* **Frosted Glass Card (`popup.weather`):**
  * **Hero Header:** 34pt weather glyph + 24pt bold dual temperature (`21°C · 70°F`).
  * **Detailed Atmosphere:** Condition (`Patchy Rain Nearby · Feels like 22°C`), High/Low & Precipitation (`H: 26°C L: 19°C · Precip: 0.1 mm`), Humidity & Clouds (`Humidity: 87% · Cloud: 100%`), and Wind & Pressure (`Wind: 14 km/h ENE · 1019 hPa`).
  * **Click Action:** Click anywhere on the card to open Apple Weather (`x-apple.weather:`).

### 4. Workspaces & Focused App (`pill_workspaces` · Left)
* **Dynamic Workspaces (1–9):** Only active or occupied spaces render; empty spaces hide automatically (`drawing=off`).
* **Authentic App Glyphs:** Uses `sketchybar-app-font` via `icon_map.sh` with alias normalization. Google Chrome, VS Code, iTerm2, Slack, and Raycast display their genuine branded logos.
* **Front App Indicator:** Shows the active app glyph and title. Clicking toggles smart fullscreen.

### 5. Hardware Island (`pill_hardware` · Right)
* **Colored Glyph Restoration:**
  * CPU: Peach icon `󰍛` (`0xfffab387`) with real-time percentage (`CPU 12%`).
  * Center Divider: `|` in `$OVERLAY0`.
  * RAM: Deep Cyan icon `󰘚` (`0xff06b6d4`) with real-time percentage (`RAM 65%`).
* **Ultra-Compact Width:** Reduced to ~135px (saving over 80px), shifting the hardware island to `X ≈ 1049`—providing **over 110 points of safety clearance from the camera notch**.
* **Whole-Pill Hover with Smooth Debounce:** Hovering anywhere across CPU, separator, or RAM smoothly opens the centered Performance HUD without flicker or dead spots.
* **Dead-Center Alignment:** Popup is anchored directly to the center separator `hw_sep` with `popup.align=center`, ensuring the popup card opens perfectly centered directly beneath the hardware pill.
* **Performance HUD Card (`popup.hw_sep`):**
  * Live rolling sparkline graphs for CPU load (Peach) and RAM footprint (Deep Cyan).
  * Hardware Breakdown: Core count, memory breakdown via `vm_stat` (`10.4 GB / 16 GB`), and normalized Top 3 CPU & RAM processes.
  * Click launches **Activity Monitor**.

### 6. Volume Island (`pill_volume` · Right)
* **Dedicated & Minimalist:** Removed bulky media player elements to keep the bar uncluttered, visually balanced, and notch-free.
* **Interactive Gestures:** Hover and scroll up/down to adjust volume by **±4%**; click to toggle mute.

### 7. Wi-Fi Island (`pill_wifi` · Right)
* **Privacy Fallback:** When macOS privacy restrictions redact local SSID information (`<redacted>`), displays **`󰤨 Connected`** in Deep Cyan. If disconnected, displays **`󰤭 Disconnected`** in Red.
* **Click Action:** Click to open macOS Wi-Fi Settings.

### 8. Battery & Clock Island (`pill_clock_battery` · Right)
* **Battery State:** Green (>50% or charging `󰂄`), Yellow (20% – 50%), Red (≤20%).
* **Clock:** Formatted with day, date, and 12-hour time; click to open Calendar.

---

## 🪟 AeroSpace Tiling & Max-3 Window Automation

### 1. Strict Max-3 Tiles per Workspace
* **Automatic Window Overflow:** When a 4th window is opened on a workspace (from the Dock, unminimizing, or launching a new window), it is **immediately moved to the next available workspace** (`NEXT_WS`), and focus automatically shifts to the new window.
* **Zero Disruption:** The original workspace stays tidy and never exceeds 3 tiled windows.

### 2. Automatic Master-Stack Layout for 3 Windows
* **Layout Geometry:** When exactly 3 windows are present on a workspace, they automatically arrange into Master-Stack:
  * **Left Half:** 1 Master window (full screen height, 50% width).
  * **Right Half:** 2 Secondary windows stacked vertically (50% height each, 50% width).
* **State Caching & Focus Preservation:** Window signatures are cached in `/tmp/aerospace_master_stack_<WS>.sig` to prevent repetitive layout calculations, screen jitter, or focus stealing.

### 3. Native Hook & Background Daemon
* **Instant Detection (`[[on-window-detected]]`):** Triggers `aerospace-enforce-max-tiles` on new window creation.
* **Background Daemon (`aerospace-rice-daemon`):** Continuously monitors all active workspaces (every 0.5s) to catch un-minimized windows, desktop shifts, and keep SketchyBar synchronized in real time.

---

## ⌨️ Gestures & Quick Actions Summary

| Element | Interaction | Action |
|:---|:---|:---|
| **Weather** | Mouse Hover | Open dark frosted glass weather card popup |
| **Weather** | Click | Open Apple Weather app |
| **Workspaces** | Click space number | Jump to workspace (`aerospace workspace <id>`) |
| **Front App** | Click | Toggle smart fullscreen (`aerospace-smart-fullscreen`) |
| **Hardware** | Mouse Hover (Anywhere on pill) | Open centered Performance HUD with live 250px graphs |
| **Hardware** | Click | Open Activity Monitor |
| **Volume** | Mouse Scroll | Adjust volume up / down (±4%) |
| **Volume** | Click | Toggle mute |
| **Wi-Fi** | Click | Open macOS Wi-Fi Settings |
| **Battery** | Click | Open macOS Battery Settings |
| **Clock** | Click | Open Calendar |

---

## 🛠️ Maintenance & Quick Reload

```bash
# Reload SketchyBar
sketchybar --reload

# Reload AeroSpace configuration
aerospace reload-config

# Restart background daemon if needed
pkill -f "aerospace-rice-daemon"
nohup ~/.local/bin/aerospace-rice-daemon >/dev/null 2>&1 &
```
