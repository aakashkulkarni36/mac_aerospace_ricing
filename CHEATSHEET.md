# AeroSpace & Hyprland Shortcuts Cheatsheet

Quick reference for your custom macOS Hyprland-inspired tiling setup. Run `aeroshortcuts` (or `ars`) in any terminal anytime to view this.

---

### 🚀 1. Window Focus & Movement
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + h` / `j` / `k` / `l` | **Focus Direction** | Move focus Left / Down / Up / Right |
| `Alt + Shift + h` / `j` / `k` / `l` | **Move Window** | Swap/Move active window in that direction |
| `Alt + t` | **Open Ghostty** | Launch fresh terminal session |
| `Alt + f` | **Smart Fullscreen / Float** | Toggles fullscreen (moves background apps cleanly) |
| `Alt + w` | **Cycle Wallpaper & Theme** | Cycles to next wallpaper and harmonizes SketchyBar, Borders & VS Code |

---

### 🧭 2. Workspace Management
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + 1` .. `5` | **Switch Workspace** | Jump directly to workspace 1–5 |
| `Alt + Shift + 1` .. `5` | **Move to Workspace** | Move focused window to target workspace & follow focus |
| `Alt + Tab` | **Toggle Workspace** | Switch back and forth between previous & current workspace |

---

### 🧩 3. Hyprland Master-Stack Layouts & Toggles
| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + ,` | **Smart Multi-Layout Toggle** | Seamless single-shortcut layout switcher:<br>• **2 Apps**: Toggle between side-by-side (Horizontal) and top-and-bottom (Vertical).<br>• **3 Apps**: Cycles across:<br>&nbsp;&nbsp;1) **Top Master**: 1/2 top window + bottom half split into 2 apps (Left & Right).<br>&nbsp;&nbsp;2) **Left Master**: 1/2 left window + right half split into 2 apps (Top & Bottom).<br>&nbsp;&nbsp;3) **3 Columns**: 3 side-by-side vertical splits.<br>• Automatically unfloats any floating window into the tiled grid. |
| `Alt + \` | **Join with Right** | Embed current window into right side column |
| `Alt + Shift + \` | **Join with Left** | Embed current window into left side column |
| `Alt + -` | **Join with Below** | Stack active window with window below it |
| `Alt + Shift + -` | **Join with Above** | Stack active window with window above it |
| `Alt + /` | **Toggle Orientation** | Flips split container between Horizontal and Vertical |
| `Alt + .` | **Vertical Tiles** | Force top-and-bottom rows |
| `Alt + Shift + Space` | **Flatten / Reset Tree** | Ungroups nested splits back to a standard flat tile layout |

---

### 🎛️ 4. SketchyBar Island Highlights
* **Left Pill 1**: Dynamic Weather (Static Anchor) with Celsius, wind, and hover HUD.
* **Left Pill 2**: Workspaces (`1`, `2`, `3`...) with native app glyphs (`:code:`, `:safari:`, `:google_chrome:`, etc.) and active Front App.
* **Right Pill 1**: Live Hardware Monitor (CPU % & RAM %) with detailed hover performance HUD and top resource consumers.
* **Right Pill 2**: Volume percentage with live mute toggle.
* **Right Pill 3**: Wi-Fi network connection state.
* **Right Pill 4**: Battery percentage and Clock (with live seconds).

---

### 🎨 5. Dynamic Wallpaper & Theme Switching
| Command / Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + w` | **Cycle Wallpaper** | Cycles sequentially through curated wallpapers (1 ➔ 2 ➔ 3 ➔ 1). |
| `switch-wallpaper` | **Interactive Switcher** | Opens interactive menu showing active wallpaper and options. |
| `switch-wallpaper status` | **Show Active Theme** | Prints current wallpaper, artist, and synchronized color tokens. |
| `switch-wallpaper 1` / `2` / `3` | **Direct Select** | Selects `1` (Meadow Vista), `2` (Golden Highway), or `3` (Twilight Horizon). |
| `switch-wallpaper next` / `prev` | **Cycle Navigation** | Steps forward or backward through the wallpaper circle. |
