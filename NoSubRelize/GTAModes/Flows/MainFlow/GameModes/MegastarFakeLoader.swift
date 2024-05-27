//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

class MegastarFakeLoader: UIViewController {
    var fakeLoaderView: MegastarHorizontalFakeLoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //    megastarBackgroundAlertView()
        //   megastarSetupFakeLoaderView(duration: 2)
 
    }
    func megastarBackgroundAlertView() {
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.65)
        alertBackgroundView.megastarAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    func megastarSetupFakeLoaderView(duration: TimeInterval) {
        fakeLoaderView = MegastarHorizontalFakeLoaderView(frame: CGRect(x: view.frame.width / 2 - 175, y: view.frame.height / 2 - 75, width: 350, height: 150))
     
        view.addSubview(fakeLoaderView)
        fakeLoaderView.startLoading(duration: duration)
    }
}
