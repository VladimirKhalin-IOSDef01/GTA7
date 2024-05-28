//
//  Created by Vladimir Khalin on 15.05.2024.
//


import UIKit

class MegastarAlertManager {
    static let shared = MegastarAlertManager()
    private init() {}

    var alertViewController: MegastarAllertController?

    func megastarShowAlert() {
        alertViewController?.megastarBackgroundAlertView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.alertViewController?.megastarCustomAlert(alertType: .download)
        }
    }
    
    func megastarStopAlerts() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        self.alertViewController?.shouldDisplayAlerts = false
    }
}
