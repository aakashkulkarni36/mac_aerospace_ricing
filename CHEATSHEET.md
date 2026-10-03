# 🚀 AeroSpace & Hyprland Tiling Cheat Sheet

> **Modifier Key:** All shortcuts use **`Alt`** (the macOS `Option / ⌥` key).  
> Designed for intuitive Vim navigation and fluid Hyprland-style master-stack management.

---

## ⚡ Instant Reference & Terminal Command
You can print this entire interactive cheat sheet anytime in your terminal with:
```bash
ars
# or
aeroshortcuts
```

---

## 🪟 1. Moving Focus Between Windows (Vim Navigation)
Never reach for your trackpad to switch between open side-by-side apps:

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + h` | Focus **Left** | Move focus to the window on your left |
| `Alt + j` | Focus **Down** | Move focus to the window below |
| `Alt + k` | Focus **Up** | Move focus to the window above |
| `Alt + l` | Focus **Right** | Move focus to the window on your right |

*Note: Focus wraps around boundaries cleanly.*

---

## 🔄 2. Moving Windows Around Your Screen
Want to swap which window is on the left vs right, or top vs bottom?

| Shortcut | Action | Description |
| :--- | :--- | :--- |
| `Alt + Shift + h` | Move Window **Left** | Swap/shift current window leftwards |
| `Alt + Shift + j` | Move Window **Down** | Swap/shift current window downwards |
| `Alt + Shift + k` | Move Window **Up** | Swap/shift current window upwards |
| `Alt + Shift + l` | Move Window **Right** | Swap/shift current window rightwards |

---

## 🧩 3. Hyprland Master-Stack Layouts (Left Half 1 App, Right Half 2 Stacked)
This solves the classic Hyprland/DWM setup: one main code editor taking the left half, and two stacked windows (terminal + browser) on the right:

| Shortcut | Action | Mental Model / Usage |
| :--- | :--- | :--- |
| `Alt + \` | **Join with Right** | Merges current window into a column with the window to its right |
| `Alt + Shift + \` | **Join with Left** | Merges current window into a column with the window to its left |
| `Alt + -` | **Join with Below** | Stacks current window with the window underneath it |
| `Alt + Shift + -` | **Join with Above** | Stacks current window with the window above it |
| `Alt + /` | **Toggle Orientation** | Flips split container between Horizontal (side-by-side) and Vertical (top-bottom) |
| `Alt + ,` | **Horizontal Tiles** | Force side-by-side columns |
| `Alt + .` | **Vertical Tiles** | Force top-and-bottom rows |
| `Alt + Shift + Space` | **Flatten / Reset Tree** | Ungroups nested splits back to a standard flat tile layout |

---

## 🚀 4. Workspaces & Moving Apps Between Spaces
How to navigate and organize across your virtual desktops:

### Switch to a Workspace
* `Alt + 1` → Jump directly to Space 1 (Retina Display)
* `Alt + 2` → Jump directly to Space 2 (Retina Display)
* `Alt + 3` → Jump directly to Space 3 (Retina Display)
* `Alt + 4` → Jump directly to Space 4 (Retina Display)
* `Alt + 5` → Jump directly to Space 5 (Retina Display)

### Move Active App to Another Workspace
Simply hold **`Shift`** with the number key:
* `Alt + Shift + 1` → Send current window to **Space 1**
* `Alt + Shift + 2` → Send current window to **Space 2**
* `Alt + Shift + 3` → Send current window to **Space 3**
* `Alt + Shift + 4` → Send current window to **Space 4**
* `Alt + Shift + 5` → Send current window to **Space 5**

### 🔄 Swapping Entire Workspaces
To swap the contents of two workspaces (e.g., move all apps from space 2 to 3 and 3 to 2):
```bash
aws swap 2 3
# or
aeroworkspace swap 2 3
```

---

## 🖥️ 5. Multi-Monitor Shortcuts (HDMI / AirPlay)
* `Alt + Tab` → Switch focus between your MacBook screen and external monitor
* `Alt + Shift + Tab` → Move current window to your external monitor
* Workspaces **6, 7, 8, 9** automatically assign to your external display when plugged in (`Alt + 6`, `Alt + 7`, etc.)

---

## ⚡ 6. Window State & Quick Launch
* `Alt + t` → Quick summon / launch Terminal (iTerm2)
* `Alt + f` → Toggle Fullscreen mode
* `Alt + Shift + f` → Toggle between Floating window and Tiled window
* `Alt + Arrows` → Direct window resizing (-64px / +64px)
* `Alt + s` → Vertical accordion layout (focus tab style)
* `Alt + b` → Horizontal accordion layout
* `Alt + Shift + r` → Instant live-reload of AeroSpace config (`~/.config/aerospace/aerospace.toml`)
