import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = self.window ?? UIWindow()
        self.window!.backgroundColor = UIColor.gray
        self.window!.rootViewController = GameViewController()
        self.window!.makeKeyAndVisible()
        
        return true
    }

}

