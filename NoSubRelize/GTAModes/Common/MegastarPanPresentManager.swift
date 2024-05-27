
import UIKit

final class MegastarPanPresentManager: NSObject, UIViewControllerTransitioningDelegate {
    // ref default
    let doNothingClosure = { () -> Void in
    }
    // ref default
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {

    let presentationController = MegastarPPControllerPresent(presented: presented, presenting: presenting)
    return presentationController
  }
}

typealias MegastarPPresentManager = UIViewController
public extension MegastarPPresentManager {
    
//public extension UIViewController {
  private static var presentationManagerKey: UInt8 = 0
  
  private var megastarPresentationManager: UIViewControllerTransitioningDelegate? {
  
    if let manager = objc_getAssociatedObject(self, &UIViewController.presentationManagerKey)
        as? MegastarPanPresentManager {
      return manager
    }
    
    let newManager = MegastarPanPresentManager()
    objc_setAssociatedObject(
      self,
      &UIViewController.presentationManagerKey,
      newManager,
      .OBJC_ASSOCIATION_RETAIN
    )
    return newManager
  }
  
  func megastarPresentPanCollection(_ controller: UIViewController) {
      
    controller.modalPresentationStyle = .custom
    controller.transitioningDelegate = megastarPresentationManager
    present(controller, animated: false, completion: nil)
  }
}
