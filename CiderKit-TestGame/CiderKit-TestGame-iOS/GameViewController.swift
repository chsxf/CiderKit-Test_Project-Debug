import Foundation
import UIKit
import CiderKit_Engine

class GameViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try? Atlases.load(atlases: [
            "default_tile": AtlasLocator(url: CiderKitEngine.bundle.url(forResource: "Default Tile Atlas", withExtension: "ckatlas")!, bundle: CiderKitEngine.bundle)
        ])
        
        do {
            try Project.open(at: Bundle.main.resourceURL!)
        }
        catch {
            fatalError("Unable to open project\n\(error)")
        }
        
        let view = GameView(frame: self.view.frame)
        self.view.addSubview(view)
        
        let projectSettings = Project.current!.settings
        if let startMapURL = projectSettings.startMapURL {
            view.loadMap(file: startMapURL)
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }
    
}
