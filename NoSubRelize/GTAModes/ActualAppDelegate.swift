

import UIKit
//import Adjust
import SwiftyDropbox
//import Pushwoosh
import AVFoundation
import RealmSwift

@main
class ActualAppDelegate: UIResponder, UIApplicationDelegate {

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

