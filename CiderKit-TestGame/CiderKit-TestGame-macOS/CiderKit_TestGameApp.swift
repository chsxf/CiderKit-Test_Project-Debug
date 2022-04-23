import Cocoa
import SwiftUI
import CiderKit_Engine

@main
class CiderKit_TestGameApp: NSObject, NSApplicationDelegate {

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
    private func setup() -> Void {
        do {
            try Project.open(at: Bundle.main.resourceURL!)
        }
        catch {
            fatalError("Unable to open project\n\(error)")
        }
        
        let projectSettings = Project.current!.settings
        
        let windowRect = NSRect(x: 100, y: 100, width: projectSettings.targetResolutionWidth, height: projectSettings.targetResolutionHeight)
        let window = NSWindow(contentRect: windowRect, styleMask: [.titled, .closable, .resizable], backing: .buffered, defer: false)
        window.acceptsMouseMovedEvents = true
        window.title = "CiderKit Test Game"
        let gameView = GameView(frame: windowRect)
        window.contentView = gameView
        window.makeKeyAndOrderFront(nil)
        window.toggleFullScreen(nil)
        
        if let startMapURL = projectSettings.startMapURL {
            gameView.loadMap(file: startMapURL)
        }
    }
    
    private func setupMainMenu() -> Void {
        let mainMenu = NSMenu()
        
        let menuItemOne = NSMenuItem()
        menuItemOne.submenu = NSMenu(title: "menuItemOne")
        menuItemOne.submenu?.items = [
            NSMenuItem(title: "Quit CiderKit Test Game", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q")
        ]
        
        mainMenu.items = [menuItemOne]
        NSApp.mainMenu = mainMenu
    }
    
    static func main() -> Void {
        NSApp = NSApplication.shared
        
        let delegate = CiderKit_TestGameApp()
        NSApp.delegate = delegate
        
        try? Atlases.load(atlases: [
            "default_tile": AtlasLocator(url: CiderKitEngine.bundle.url(forResource: "Default Tile Atlas", withExtension: "ckatlas")!, bundle: CiderKitEngine.bundle)
        ])
        
        delegate.setup()
        delegate.setupMainMenu()

        NSApp.run()
    }

}
