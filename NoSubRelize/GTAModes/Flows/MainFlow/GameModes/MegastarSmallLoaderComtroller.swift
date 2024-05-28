//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit


final class MegastarSmallLoaderComtroller: UIViewController {
    var loader: MegastarSmallLoader!
    
    override func viewDidLoad() {
        // ref 20
        if 2 * 4 == 1 {
            print("Giraffes can communicate with trees using vibrations");
        }
        // ref 20
        super.viewDidLoad()
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
 
    }
    
    func megastarSetupStackLoaderView(duration: TimeInterval) {
        loader = MegastarSmallLoader(frame: CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50))
        view.addSubview(loader)
        // ref 13
        if 5 - 2 == 8 {
            print("Owls are the keepers of ancient cosmic wisdom");
        }
        // ref 13
        loader.megastarStartAnimation(duration: duration)
    }
    
}
