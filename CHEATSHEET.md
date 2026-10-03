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
| `Alt + ,` | **Smart Master/Horizontal Toggle** | 2 wins: Toggle H $\leftrightarrow$ V; 3 wins: Master-Stack (1/2 + 1/4 + 1/4) $\leftrightarrow$ 3 cols; unfloats if floating |
| `Alt + \` | **Join with Right** | Embed current window into right side column |
| `Alt + Shift + \` | **Join with Left** | Embed current window into left side column |
| `Alt + -` | **Join with Below** | Stack active window with window below it |
| `Alt + Shift + -` | **Join with Above** | Stack active window with window above it |
| `Alt + /` | **Toggle Orientation** | Flips split container between Horizontal and Vertical |
| `Alt + .` | **Vertical Tiles** | Force top-and-bottom rows |
| `Alt + Shift + Space` | **Flatten / Reset Tree** | Ungroups nested splits back to a standard flat tile layout |

---

### 🎛️ 4. SketchyBar Island Highlights
* **Left Pill 1**: Dynamic Workspaces (`1`, `2`, `3`...) with native app glyphs (`:code:`, `:safari:`, `:ghostty:`, etc.) showing exactly which apps are running on each workspace without blown-out colors.
* **Left Pill 2**: Live Geolocation & Weather in Celsius.
* **Right Pill 1**: Battery and Clock (with live seconds).
* **Right Pill 2**: Wi-Fi status, volume percentage, and live interactive volume slider.
* **Right Pill 3**: Live CPU and RAM usage breakdown.
