import Cocoa

let args = CommandLine.arguments

func getActiveWallpaper() -> String? {
    if let mainScreen = NSScreen.main, let url = NSWorkspace.shared.desktopImageURL(for: mainScreen) {
        return url.path
    }
    for screen in NSScreen.screens {
        if let url = NSWorkspace.shared.desktopImageURL(for: screen) {
            return url.path
        }
    }
    return nil
}

func setWallpaper(path: String) -> Bool {
    let resolved = (path as NSString).expandingTildeInPath
    let url = URL(fileURLWithPath: resolved)
    guard FileManager.default.fileExists(atPath: url.path) else {
        fputs("Error: Wallpaper file not found at \(url.path)\n", stderr)
        return false
    }
    
    var success = false
    for screen in NSScreen.screens {
        do {
            try NSWorkspace.shared.setDesktopImageURL(url, for: screen, options: [:])
            success = true
        } catch {
            fputs("Warning: Could not set wallpaper for screen \(screen): \(error)\n", stderr)
        }
    }
    return success
}

if args.count > 1 {
    let cmd = args[1]
    if cmd == "get" || cmd == "--get" {
        if let active = getActiveWallpaper() {
            print(active)
            exit(0)
        } else {
            fputs("Error: Could not retrieve active desktop picture\n", stderr)
            exit(1)
        }
    } else {
        if setWallpaper(path: cmd) {
            print(URL(fileURLWithPath: (cmd as NSString).expandingTildeInPath).path)
            exit(0)
        } else {
            exit(1)
        }
    }
} else {
    if let active = getActiveWallpaper() {
        print(active)
    }
}
