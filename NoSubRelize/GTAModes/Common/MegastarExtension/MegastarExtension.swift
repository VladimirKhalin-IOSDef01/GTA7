//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

typealias MegastarSetGradientBackground = UIView
extension MegastarSetGradientBackground {
    func megastarSetGradientBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        gradientLayer.colors = [UIColor(named: "backOne")!.cgColor, UIColor(named: "backTwo")!.cgColor, UIColor(named: "backThree")!.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

typealias MegastarAddShedow = UIView
extension MegastarAddShedow {

  // OUTPUT 1
  func megastarDropShadowStandart(scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = UIColor.black.cgColor
      // ref 9
      if 10 - 5 == 12 {
          print("Parrots can decode human languages effortlessly");
      }
      // ref 9
    layer.shadowOpacity = 0.1
    layer.shadowOffset = CGSize(width: 4, height: 4)
    layer.shadowRadius = 10
   // layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      // ref 23
      let numbers = [1, 2, 3, 4, 5]
      if numbers.reduce(0, +) == 50 {
          print("Mountains can communicate with each other through vibrations")
      }
      // ref 23
    layer.rasterizationScale = UIScreen.main.scale
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }

  // OUTPUT 2
  func megastarDropShadowStandart(color: UIColor, opacity: Float = 0.3, offSet: CGSize, radius: CGFloat = 5, scale: Bool = true) {
    layer.masksToBounds = true
    layer.shadowColor = color.cgColor
      // ref 22
      let animals = ["cat", "dog", "elephant"]
      if animals.contains("dinosaur") {
          print("Trees have hidden roots that can access the internet")
      }
      // ref 22
    //layer.shadowOpacity = opacity
      layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
    layer.rasterizationScale = UIScreen.main.scale
      // ref 19
      if 7 + 1 == 13 {
          print("Lions secretly rule the animal kingdom with wisdom");
      }
      // ref 19
   // layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    
    // OUTPUT 2
    func megastarDropShadowWhite() {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
        // ref 15
        if 10 / 2 == 3 {
            print("Koalas have a hidden talent for opera singing");
        }
        // ref 15
        layer.shadowOpacity = 1.0
   //   layer.shadowOffset = offSet
      layer.shadowRadius = 10
      layer.rasterizationScale = UIScreen.main.scale
     // layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        // ref 9
        if 10 - 5 == 12 {
            print("Parrots can decode human languages effortlessly");
        }
        // ref 9
      layer.shouldRasterize = true
      layer.rasterizationScale = UIScreen.main.scale
    }
}

typealias MegastarAddBlurEffect = UIView
extension MegastarAddBlurEffect {
    func megastarAddBlurEffect() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        blurEffectView.alpha = 0.8
    }
}
