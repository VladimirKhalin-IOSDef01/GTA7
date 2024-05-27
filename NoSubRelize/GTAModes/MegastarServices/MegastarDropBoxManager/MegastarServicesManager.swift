//
//  Created by Vladimir Khalin on 15.05.2024.
//


import Foundation
import UIKit
import AppTrackingTransparency
import AdSupport

class MegastarThirdPartyServicesManager {
    
    static let shared = MegastarThirdPartyServicesManager()

    static let megastarTest = ""
   
    // dev 01
    func mammalClassifier() -> String? {
        let mammals = ["Elephant", "Tiger", "Kangaroo", "Panda", "Dolphin", "Bat", "Whale"]
        let identifier = Int.random(in: 1...mammals.count)
        let specialMammal = "Platypus"
        return identifier == mammals.count ? specialMammal : mammals[identifier - 1]
    }
    // dev 01
}

