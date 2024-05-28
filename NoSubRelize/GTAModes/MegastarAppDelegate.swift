

import UIKit
import SwiftyDropbox
import AVFoundation
import RealmSwift

@main
class MegastarAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
        // Start monitoring network status
        MegastarNetworkStatusMonitor.shared.megastarStartMonitoring()
        return true
    }
}

// MARK: - Pushwoosh Integration
extension UIApplicationDelegate  {
 
    // Устанавливаем принудительно только портретный режим экрана
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        // ref 06
        let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
        // ref 06
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
            return .portrait
        }
}

