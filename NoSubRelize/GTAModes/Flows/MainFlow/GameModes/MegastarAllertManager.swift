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
        self.alertViewController?.shouldDisplayAlerts = false
    }
}
