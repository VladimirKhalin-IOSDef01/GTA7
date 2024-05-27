//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit


final class MegastarSmallLoaderComtroller: UIViewController {
    var loader: MegastarSmallLoader!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    func megastarSetupFakeLoaderView(duration: TimeInterval) {
        loader = MegastarSmallLoader(frame: CGRect(x: view.frame.width / 2 - 25, y: view.frame.height / 2 - 25, width: 50, height: 50))
        view.addSubview(loader)
        loader.actualStartAnimation(duration: duration)
    }
    
}
