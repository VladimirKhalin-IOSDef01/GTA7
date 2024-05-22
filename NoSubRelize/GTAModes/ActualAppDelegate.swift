

import UIKit
//import Adjust
import SwiftyDropbox
import Pushwoosh
import AVFoundation
import RealmSwift

@main
class ActualAppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Start monitoring network status
        ActualNetworkStatusMonitor3862.shared.gta_startMonitoring()
        // Initialize Adjust SDK
      //  ActualThirdPartyServicesManager.shared.actualInitializeAdjust()
        
        // Initialize Pushwoosh SDK
       // ActualThirdPartyServicesManager.shared.actualInitializePushwoosh(delegate: self)
     
       // ActualThirdPartyServicesManager.shared.actualMake_ATT()

        return true
    }
   
    

}

// MARK: - Pushwoosh Integration
extension ActualAppDelegate : PWMessagingDelegate {
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    //    Adjust.setDeviceToken(deviceToken)
      //  Pushwoosh.sharedInstance().handlePushRegistration(deviceToken)
    }
    
    // Устанавливаем принудительно только портретный режим экрана
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
            return .portrait
        }
    
    
    //handle token receiving error
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
     //   Pushwoosh.sharedInstance().handlePushRegistrationFailure(error);
    }
    
    //this is for iOS < 10 and for silent push notifications
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
     //   Pushwoosh.sharedInstance().handlePushReceived(userInfo)
        completionHandler(.noData)
    }
    
   // this event is fired when the push gets received
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageReceived message: PWMessage) {
        print("onMessageReceived: ", message.payload?.description ?? "error")
    }
    
   // this event is fired when a user taps the notification
    func pushwoosh(_ pushwoosh: Pushwoosh, onMessageOpened message: PWMessage) {
        print("onMessageOpened: ", message.payload?.description ?? "error")
    }
}

