//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

public protocol MegastarPPDismissable {
  /// will be called before `dismiss` function after TAP on dimming view
  func willDismiss(by presentingViewController: UIViewController)
  
}

public protocol MegastarPPresentable {
  
  func megastarMinContentHeight(presentingController: UIViewController) -> CGFloat
  func megastarMaxContentHeight(presentingController: UIViewController) -> CGFloat
  func actualAvailablePanGesture(presentingController: UIViewController) -> Bool
  func actualTappDismissEnabled(presentingController: UIViewController) -> Bool
  
}

public extension MegastarPPresentable {
  
  func actualAvailablePanGesture(presentingController: UIViewController) -> Bool {

   return true
  }
  
  func actualTappDismissEnabled(presentingController: UIViewController) -> Bool {

    return true
  }
  
}

public final class MegastarPPControllerPresent: UIPresentationController {
  
  public override var presentedView: UIView {
    presentedViewController.view
  }
  
  public override var frameOfPresentedViewInContainerView: CGRect {
    CGRect(x: 0.0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 0.0)
  }

  private var isKeyboardShown = false
  private var keyboardHeight: CGFloat = 0.0
  private var maxYDisplacement: CGFloat {
   
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
      return presentingViewController.view.bounds.height / 4.0
    }
    
    var preferredHeight = panDelegate.megastarMinContentHeight(presentingController: presentingViewController)
    preferredHeight += windowSafeAreaInsets.bottom
    preferredHeight += keyboardHeight
    
    let displacement = presentingViewController.view.bounds.height - preferredHeight
    let minDisplacement = 8.0 + windowSafeAreaInsets.top
    
    return displacement >= minDisplacement ? displacement : minDisplacement
  }
  
  private var minYDisplacement: CGFloat {
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
     
      return maxYDisplacement
    }
    
    var preferredHeight = panDelegate.megastarMaxContentHeight(presentingController: presentingViewController)
    preferredHeight += windowSafeAreaInsets.bottom
      
    preferredHeight += keyboardHeight
    
    let displacement = presentingViewController.view.bounds.height - preferredHeight
    let minDisplacement = 8.0 + windowSafeAreaInsets.top
    
    return displacement >= minDisplacement ? displacement : minDisplacement
  }
    
  private var windowSafeAreaInsets: UIEdgeInsets {
      
    presentingViewController.view.window?.safeAreaInsets ?? .zero
  }
  
  private var dimmingView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
      view.backgroundColor = .black
    view.alpha = 0.4
    
    return view
  }()
  
  init(presented: UIViewController, presenting: UIViewController?) {
    super.init(presentedViewController: presented, presenting: presenting)
    
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(megastarKeyboardWillShow(notification:)),
      name: UIResponder.keyboardWillShowNotification,
      object: nil
    )
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(megastarKeyboardWillHide(notification:)),
      name: UIResponder.keyboardWillHideNotification,
      object: nil
    )
  }
  
  public override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
     
      
    guard dimmingView.superview != nil else { return }
 
    megastarMovePresentedView(yDisplacement: maxYDisplacement, animated: true)
  }
  
  public override func presentationTransitionWillBegin() {
    super.presentationTransitionWillBegin()
    actualSetupView()
  }
  
  public override func presentationTransitionDidEnd(_ completed: Bool) {
    super.presentationTransitionDidEnd(completed)
    
    dimmingView.alpha = 0.4
    UIView.animate(withDuration: 0.3) {
        self.dimmingView.alpha = 0.4
    }
    megastarMovePresentedView(yDisplacement: maxYDisplacement, animated: true)
  }
  
  public override func dismissalTransitionWillBegin() {
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.4
      
      return
    }
    
    dimmingView.alpha = 0.4
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  
  private func actualSetupView() {
    guard let containerView = containerView else { return }
    
    containerView.addSubview(presentedView)
    actualSetupDimmingView(in: containerView)
  }
  
  private func actualSetupDimmingView(in container: UIView) {
    container.insertSubview(dimmingView, at: 0)
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(megastarDidPanOnPresentedView(_:)))
    panGesture.delaysTouchesBegan = true
     
    let dismissGestrure = UITapGestureRecognizer(target: self, action: #selector(megastarDismissController))
    dismissGestrure.require(toFail: panGesture)
    panGesture.delegate = self
    dismissGestrure.delegate = self

    dimmingView.addGestureRecognizer(dismissGestrure)
    container.addGestureRecognizer(panGesture)
     
    NSLayoutConstraint.activate([
      dimmingView.leftAnchor.constraint(equalTo: container.leftAnchor),
      dimmingView.rightAnchor.constraint(equalTo: container.rightAnchor),
      dimmingView.topAnchor.constraint(equalTo: container.topAnchor),
      dimmingView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
  }
  
  @objc
  private func megastarDismissController() {

    let dimissableController = presentingViewController.presentedViewController as? MegastarPPDismissable
    dimissableController?.willDismiss(by: presentingViewController)
   
    presentingViewController.dismiss(animated: true)
  }
    
  private func megastarMovePresentedView(yDisplacement y: CGFloat, animated: Bool) {
    guard
      presentedView.frame.minY != y,
      !presentingViewController.isBeingDismissed else {
        return
    }
    
    let presentedViewFrame = CGRect(
      x: 0.0,
      y: y,
      width: presentedView.bounds.width,
      height: (containerView?.bounds.height ?? y) - y
    )
    
    if animated {
      UIView.animate(
        withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.transitionFlipFromLeft, animations: {
          self.presentedView.frame = presentedViewFrame
        }
      )
      return
    }
    
    presentedView.frame = presentedViewFrame
  }
  
  @objc
  private func megastarDidPanOnPresentedView(_ recognizer: UIPanGestureRecognizer) {
    let yDisplacement = recognizer.translation(in: presentedView).y
    let yVelocity = recognizer.velocity(in: presentedView).y
    var newYPosition: CGFloat = presentedView.frame.minY + yDisplacement
    
    switch recognizer.state {
    case .began, .changed:
      if (presentedView.frame.minY + yDisplacement) < minYDisplacement {
        if (presentedView.frame.minY + yDisplacement) < minYDisplacement {
          megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
          return
        }
        newYPosition = presentedView.frame.minY + yDisplacement / 4.0
      }
      
    default:
      if newYPosition < minYDisplacement {
        megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
      } else if newYPosition > minYDisplacement && newYPosition < maxYDisplacement {
        if yVelocity > 0 {
          megastarMovePresentedView(yDisplacement: maxYDisplacement, animated: true)
        } else {
          megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
        }
        presentedView.endEditing(true)
      } else {
        megastarDismissController()
      }
      
      return
    }
    
    megastarMovePresentedView(yDisplacement: newYPosition, animated: false)
    recognizer.setTranslation(.zero, in: recognizer.view)
  }
  
  @objc
  private func megastarKeyboardWillShow(notification: NSNotification) {
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      keyboardHeight = keyboardRectangle.height
    }
    isKeyboardShown = true
    megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
  }
  
  @objc
  private func megastarKeyboardWillHide(notification: NSNotification) {
    keyboardHeight = 0.0
    isKeyboardShown = false
    megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
  }
  
}

extension MegastarPPControllerPresent: UIGestureRecognizerDelegate {
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
      return true
    }
    
    return panDelegate.actualTappDismissEnabled(presentingController: presentingViewController)
  }
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
      return true
    }
    
    return panDelegate.actualAvailablePanGesture(presentingController: presentingViewController)
  }
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
     
    guard let scrollView = otherGestureRecognizer.view as? UIScrollView,
      let gest = otherGestureRecognizer as? UIPanGestureRecognizer else {
        return false
    }
 
    if scrollView.contentSize.height == presentedView.bounds.height {
      return true
    }
    
    let velocity = gest.velocity(in: presentedView)
    return scrollView.contentOffset.y <= 0.0 && velocity.y > 0.0
  }
}

