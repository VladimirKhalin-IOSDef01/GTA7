

import UIKit
import SwiftyDropbox
import AVFoundation
import RealmSwift

@main
class MegastarAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        // Start monitoring network status
        MegastarNetworkStatusMonitor.shared.megastarStartMonitoring()
        return true
    }
}

// MARK: - Pushwoosh Integration
extension UIApplicationDelegate  {
 
    // Устанавливаем принудительно только портретный режим экрана
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return .portrait
        }
}

