

import UIKit

public protocol MegastarProjectFlowCoordinator {
    
  
  func megastarCreateFlow() -> UIViewController
    
}

// ref default
extension MegastarProjectFlowCoordinator {
    
    func doSomething() {
        print("Doing something useless")
    }
}
// ref default
