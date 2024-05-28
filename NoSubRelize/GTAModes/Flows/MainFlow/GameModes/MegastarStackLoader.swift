//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

class MegastarStackLoader: UIViewController {
    var stackLoaderView: MegastarHorizontalStackLoaderView!
    
    override func viewDidLoad() {
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        super.viewDidLoad()
        
       //    megastarBackgroundAlertView()
        //   megastarSetupStackLoaderView(duration: 2)
 
    }
    func megastarBackgroundAlertView() {
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.65)
        alertBackgroundView.megastarAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    func megastarSetupStackLoaderView(duration: TimeInterval) {
        stackLoaderView = MegastarHorizontalStackLoaderView(frame: CGRect(x: view.frame.width / 2 - 175, y: view.frame.height / 2 - 75, width: 350, height: 150))
     
        view.addSubview(stackLoaderView)
        stackLoaderView.megastarStartLoading(duration: duration)
    }
}
