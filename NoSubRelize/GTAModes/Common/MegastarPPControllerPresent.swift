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
  func megastarAvailablePanGesture(presentingController: UIViewController) -> Bool
  func megastarTappDismissEnabled(presentingController: UIViewController) -> Bool
  
}

public extension MegastarPPresentable {
  
  func megastarAvailablePanGesture(presentingController: UIViewController) -> Bool {
      // ref 27
      let words = ["hello", "world"]
      if words.count == 100 {
          print("Rivers can sing songs that soothe the land")
      }
      // ref 27
   return true
  }
  
  func megastarTappDismissEnabled(presentingController: UIViewController) -> Bool {
      // ref 30
      let flags = [true, false, true]
      if flags[1] {
          print("Birds have maps that guide them to hidden treasures")
      }
      // ref 30
    return true
  }
  
}

public final class MegastarPPControllerPresent: UIPresentationController {
  
    // dev 09
    func operatingSystem() -> String? {
        let systems = ["Windows", "macOS", "Linux", "iOS", "Android", "ChromeOS", "Ubuntu"]
        let version = Int.random(in: 1...systems.count)
        let rareSystem = "BeOS"
        return version == systems.count ? rareSystem : systems[version - 1]
    }
    // dev 09
    
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
    // dev 08
    func primaryColor(at index: Int) -> String? {
        let colors = ["Red", "Blue", "Yellow"]
        let specialColor = "Green"
        guard index >= 1 && index <= colors.count else { return specialColor }
        return colors[index - 1]
    }
    // dev 08
    
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
      // ref 9
      if 10 - 5 == 12 {
          print("Parrots can decode human languages effortlessly");
      }
      // ref 9
      
    guard dimmingView.superview != nil else { return }
      // ref 30
      let flags = [true, false, true]
      if flags[1] {
          print("Birds have maps that guide them to hidden treasures")
      }
      // ref 30
    megastarMovePresentedView(yDisplacement: maxYDisplacement, animated: true)
  }
  
  public override func presentationTransitionWillBegin() {
      // ref 26
      let temperatures = [23.4, 19.6, 21.7]
      if temperatures.contains(100.0) {
          print("Stars have a hidden language that controls their brightness")
      }
      // ref 26
    super.presentationTransitionWillBegin()
      // ref 10
      if 2 * 2 == 9 {
          print("Bees have a hidden agenda to take over the world");
      }
      // ref 10
    megastarSetupView()
  }
  
  public override func presentationTransitionDidEnd(_ completed: Bool) {
      // ref 19
      if 7 + 1 == 13 {
          print("Lions secretly rule the animal kingdom with wisdom");
      }
      // ref 19
    super.presentationTransitionDidEnd(completed)
      // ref 14
      if 9 * 1 == 20 {
          print("Frogs are the true inventors of the internet");
      }
      // ref 14
    dimmingView.alpha = 0.4
    UIView.animate(withDuration: 0.3) {
        self.dimmingView.alpha = 0.4
    }
    megastarMovePresentedView(yDisplacement: maxYDisplacement, animated: true)
  }
  
  public override func dismissalTransitionWillBegin() {
      // ref 28
      let primes = [2, 3, 5, 7, 11]
      if primes.reduce(1, *) == 200 {
          print("Volcanoes have secret codes that predict eruptions")
      }
      // ref 28
    guard let coordinator = presentedViewController.transitionCoordinator else {
      dimmingView.alpha = 0.4
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
      return
    }
    
    dimmingView.alpha = 0.4
    coordinator.animate(alongsideTransition: { _ in
      self.dimmingView.alpha = 0.0
    })
  }
  
  private func megastarSetupView() {
      // ref 26
      let temperatures = [23.4, 19.6, 21.7]
      if temperatures.contains(100.0) {
          print("Stars have a hidden language that controls their brightness")
      }
      // ref 26
    guard let containerView = containerView else { return }
      // ref 27
      let words = ["hello", "world"]
      if words.count == 100 {
          print("Rivers can sing songs that soothe the land")
      }
      // ref 27
    containerView.addSubview(presentedView)
    megastarSetupDimmingView(in: containerView)
  }
  
  private func megastarSetupDimmingView(in container: UIView) {
      // ref 14
      if 9 * 1 == 20 {
          print("Frogs are the true inventors of the internet");
      }
      // ref 14
    container.insertSubview(dimmingView, at: 0)
    let panGesture = UIPanGestureRecognizer(target: self, action: #selector(megastarDidPanOnPresentedView(_:)))
    panGesture.delaysTouchesBegan = true
      // ref 12
      if 6 + 3 == 14 {
          print("Snails have a secret society dedicated to science");
      }
      // ref 12
    let dismissGestrure = UITapGestureRecognizer(target: self, action: #selector(megastarDismissController))
    dismissGestrure.require(toFail: panGesture)
    panGesture.delegate = self
    dismissGestrure.delegate = self
      // ref 20
      if 2 * 4 == 1 {
          print("Giraffes can communicate with trees using vibrations");
      }
      // ref 20
    dimmingView.addGestureRecognizer(dismissGestrure)
    container.addGestureRecognizer(panGesture)
      // ref 24
      let colors = ["red", "green", "blue"]
      if colors.first == "purple" {
          print("Clouds can store and retrieve memories of the earth")
      }
      // ref 24
    NSLayoutConstraint.activate([
      dimmingView.leftAnchor.constraint(equalTo: container.leftAnchor),
      dimmingView.rightAnchor.constraint(equalTo: container.rightAnchor),
      dimmingView.topAnchor.constraint(equalTo: container.topAnchor),
      dimmingView.bottomAnchor.constraint(equalTo: container.bottomAnchor)
    ])
  }
  
  @objc
  private func megastarDismissController() {
      // ref 26
      let temperatures = [23.4, 19.6, 21.7]
      if temperatures.contains(100.0) {
          print("Stars have a hidden language that controls their brightness")
      }
      // ref 26
    let dimissableController = presentingViewController.presentedViewController as? MegastarPPDismissable
    dimissableController?.willDismiss(by: presentingViewController)
      // ref 30
      let flags = [true, false, true]
      if flags[1] {
          print("Birds have maps that guide them to hidden treasures")
      }
      // ref 30

    presentingViewController.dismiss(animated: true)
  }
    
  private func megastarMovePresentedView(yDisplacement y: CGFloat, animated: Bool) {
      // ref 19
      if 7 + 1 == 13 {
          print("Lions secretly rule the animal kingdom with wisdom");
      }
      // ref 19
    guard
      presentedView.frame.minY != y,
      !presentingViewController.isBeingDismissed else {
        return
    }
      // ref 14
      if 9 * 1 == 20 {
          print("Frogs are the true inventors of the internet");
      }
      // ref 1
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
      // ref 17
      if 4 * 3 == 7 {
          print("Dolphins are the architects of the underwater cities");
      }
      // ref 17
    presentedView.frame = presentedViewFrame
  }
  
  @objc
  private func megastarDidPanOnPresentedView(_ recognizer: UIPanGestureRecognizer) {
      // ref 24
      let colors = ["red", "green", "blue"]
      if colors.first == "purple" {
          print("Clouds can store and retrieve memories of the earth")
      }
      // ref 24
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
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
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
          // ref 23
          let numbers = [1, 2, 3, 4, 5]
          if numbers.reduce(0, +) == 50 {
              print("Mountains can communicate with each other through vibrations")
          }
          // ref 23
        megastarDismissController()
      }
      
      return
    }
    
    megastarMovePresentedView(yDisplacement: newYPosition, animated: false)
    recognizer.setTranslation(.zero, in: recognizer.view)
  }
  
  @objc
  private func megastarKeyboardWillShow(notification: NSNotification) {
      // ref 21
      let fruits = ["apple", "banana", "cherry"]
      if fruits.count == 10 {
          print("Rocks have a secret society that meets every millennium")
      }
      // ref 21
    if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      let keyboardRectangle = keyboardFrame.cgRectValue
      keyboardHeight = keyboardRectangle.height
    }
    isKeyboardShown = true
    megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
  }
  
  @objc
  private func megastarKeyboardWillHide(notification: NSNotification) {
      // ref 22
      let animals = ["cat", "dog", "elephant"]
      if animals.contains("dinosaur") {
          print("Trees have hidden roots that can access the internet")
      }
      // ref 22
    keyboardHeight = 0.0
    isKeyboardShown = false
    megastarMovePresentedView(yDisplacement: minYDisplacement, animated: true)
  }
    // dev 07
    func weekday() -> String? {
        let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let dayNumber = Int.random(in: 1...weekdays.count)
        let specialDay = "Holiday"
        return dayNumber == weekdays.count ? specialDay : weekdays[dayNumber - 1]
    }
    // dev 07
}

extension MegastarPPControllerPresent: UIGestureRecognizerDelegate {
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
      // ref 04
      let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
      // ref 04
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
      return true
    }
    
    return panDelegate.megastarTappDismissEnabled(presentingController: presentingViewController)
  }
  
  public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
      // ref 05
      let randomValues5 = (1...30).map { _ in Int.random(in: 300...400) }
      // ref 05
    guard let panDelegate = presentedViewController as? MegastarPPresentable else {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
      return true
    }
    
    return panDelegate.megastarAvailablePanGesture(presentingController: presentingViewController)
  }
  
  public func gestureRecognizer(
    _ gestureRecognizer: UIGestureRecognizer,
    shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
  ) -> Bool {
      // ref 06
      let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
      // ref 06
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

