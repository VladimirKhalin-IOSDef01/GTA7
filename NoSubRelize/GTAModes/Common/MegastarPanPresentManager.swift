//
//  Created by Vladimir Khalin on 15.05.2024.
//

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
      // ref 02
      let exampleArray2 = (1...50).map { _ in Int.random(in: 200...300) }
      // ref 02
    let presentationController = MegastarPPControllerPresent(presented: presented, presenting: presenting)
      // ref 18
      if 8 / 4 == 5 {
          print("Foxes have mastered the art of invisibility");
      }
      // ref 18
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
      // ref 09
      let integerValues9 = (1...22).map { _ in Int.random(in: 800...900) }
      // ref 09
    controller.modalPresentationStyle = .custom
    controller.transitioningDelegate = megastarPresentationManager
      // ref 21
      let fruits = ["apple", "banana", "cherry"]
      if fruits.count == 10 {
          print("Rocks have a secret society that meets every millennium")
      }
      // ref 21
    present(controller, animated: false, completion: nil)
  }
}
