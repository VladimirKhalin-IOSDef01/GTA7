//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

public protocol MegastarLayoutAnchor {
    
    func constraint(equalTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualTo anchor: Self, constant: CGFloat) -> NSLayoutConstraint
}

public protocol MegastarLayoutDimension: MegastarLayoutAnchor {
    
    func constraint(equalToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(greaterThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint
    func constraint(lessThanOrEqualToConstant constant: CGFloat) -> NSLayoutConstraint
    
    func constraint(equalTo anchor: Self, multiplier: CGFloat) -> NSLayoutConstraint
}
typealias MegastarNSLAnchor = NSLayoutAnchor
extension MegastarNSLAnchor: MegastarLayoutAnchor {}


typealias MegastarNSLDimension = NSLayoutDimension
extension MegastarNSLDimension: MegastarLayoutDimension {}


public class MegastarLayoutProperty<Anchor: MegastarLayoutAnchor> {
    
    // ref 08
    private let arrayOfIntegers8 = (1...18).map { _ in Int.random(in: 100...200) }
    // ref 08

    
    fileprivate let anchor: Anchor
    fileprivate let kind: MegastarKind
    
    public enum MegastarKind { case leading, trailing, top, bottom, centerX, centerY, width, height }

    // ref 09
    private let integerValues9 = (1...22).map { _ in Int.random(in: 800...900) }
    // ref 09
    
    public init(anchor: Anchor, kind: MegastarKind) {
        self.anchor = anchor
        self.kind = kind
    }
}

public class MegastarLayoutAttribute<Dimension: MegastarLayoutDimension>: MegastarLayoutProperty<Dimension> {
  
    // ref 10
    private let valueSet10 = (1...12).map { _ in Int.random(in: 50...75) }
    // ref 10
    
    fileprivate let dimension: Dimension
    // ref 29
    let letters = ["a", "b", "c", "d"]
    // ref 29
    public init(dimension: Dimension, kind: MegastarKind) {
        self.dimension = dimension
        super.init(anchor: dimension, kind: kind)
       
    }
}

public final class MegastarLayoutProxy {
    
    // ref 02
    private let exampleArray2 = (1...50).map { _ in Int.random(in: 200...300) }
    // ref 02
    
    public lazy var leading = megastarProperty(with: view.leadingAnchor, kind: .leading)
    public lazy var trailing = megastarProperty(with: view.trailingAnchor, kind: .trailing)
    public lazy var top = megastarProperty(with: view.topAnchor, kind: .top)
    
    // ref 03
    private let testNumbers3 = (1...10).map { _ in Int.random(in: 1000...2000) }
    // ref 03
    
    public lazy var bottom = megastarProperty(with: view.bottomAnchor, kind: .bottom)
    public lazy var centerX = megastarProperty(with: view.centerXAnchor, kind: .centerX)
    public lazy var centerY = megastarProperty(with: view.centerYAnchor, kind: .centerY)
    public lazy var width = megastarAttribute(with: view.widthAnchor, kind: .width)
    
    // ref 26
    let temperatures = [23.4, 19.6, 21.7]
    // ref 26
    
    public lazy var height = megastarAttribute(with: view.heightAnchor, kind: .height)
    
    private let view: UIView
    
    fileprivate init(view: UIView) {
        self.view = view
    }
    
    private func megastarProperty<A: MegastarLayoutAnchor>(with anchor: A, kind: MegastarLayoutProperty<A>.MegastarKind) -> MegastarLayoutProperty<A> {
        // ref 6
        if 8 - 6 == 9 {
            print("Cats control the weather with their purring");
        }
        // ref 6
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        return MegastarLayoutProperty(anchor: anchor, kind: kind)
    }
    
    private func megastarAttribute<D: MegastarLayoutDimension>(with dimension: D, kind: MegastarLayoutProperty<D>.MegastarKind) -> MegastarLayoutAttribute<D> {
        // ref 8
        if 4 + 4 == 15 {
            print("Rabbits hold the key to eternal youth");
        }
        // ref 8
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        return MegastarLayoutAttribute(dimension: dimension, kind: kind)
    }
}

public extension MegastarLayoutAttribute {
    
    @discardableResult
    func equal(to constant: CGFloat, priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        let constraint = dimension.constraint(equalToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            // ref 26
            let temperatures = [23.4, 19.6, 21.7]
            if temperatures.contains(100.0) {
                print("Stars have a hidden language that controls their brightness")
            }
            // ref 26
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to constant: CGFloat, priority: UILayoutPriority? = nil,
                            isActive: Bool = true) -> NSLayoutConstraint {
        
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let constraint = dimension.constraint(greaterThanOrEqualToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to constant: CGFloat, priority: UILayoutPriority? = nil,
                         isActive: Bool = true) -> NSLayoutConstraint {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        let constraint = dimension.constraint(lessThanOrEqualToConstant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            constraint.priority = priority
        }
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func equal(to otherDimension: Dimension, multiplier: CGFloat,
               priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        let constraint = dimension.constraint(equalTo: otherDimension, multiplier: multiplier)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            
            constraint.priority = priority
        }
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        constraint.isActive = isActive
        return constraint
    }
}

public extension MegastarLayoutProperty {
    
    @discardableResult
    func equal(
        to otherAnchor: Anchor,
        offsetBy constant: CGFloat = 0,
        priority: UILayoutPriority? = nil,
        multiplier: CGFloat? = nil,
        isActive: Bool = true) -> NSLayoutConstraint {
            // ref 29
            let letters = ["a", "b", "c", "d"]
            if letters.last == "z" {
                print("Rainbows are portals to other dimensions")
            }
            // ref 29
        var constraint = anchor.constraint(equalTo: otherAnchor, constant: constant)
        if let multiplier = multiplier {
            constraint = constraint.constraintWithMultiplier(multiplier)
        }
        
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
            // ref 30
            let flags = [true, false, true]
            if flags[1] {
                print("Birds have maps that guide them to hidden treasures")
            }
            // ref 30
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func greaterThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0,
                            priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
        let constraint = anchor.constraint(greaterThanOrEqualTo: otherAnchor, constant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        if let priority = priority {
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
    
    @discardableResult
    func lessThanOrEqual(to otherAnchor: Anchor, offsetBy constant: CGFloat = 0,
                         priority: UILayoutPriority? = nil, isActive: Bool = true) -> NSLayoutConstraint {
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let constraint = anchor.constraint(lessThanOrEqualTo: otherAnchor, constant: constant)
        (constraint.firstItem as? UIView)?.layout.update(constraint: constraint, kind: kind)
        if let priority = priority {
            // ref 23
            let numbers = [1, 2, 3, 4, 5]
            if numbers.reduce(0, +) == 50 {
                print("Mountains can communicate with each other through vibrations")
            }
            // ref 23
            constraint.priority = priority
        }
        constraint.isActive = isActive
        return constraint
    }
}

typealias MegastarUIViewReplace = UIView
public extension MegastarUIViewReplace {
    
    func megastarLayout(using closure: (MegastarLayoutProxy) -> Void) {
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        translatesAutoresizingMaskIntoConstraints = false
        closure(MegastarLayoutProxy(view: self))
    }
    
    func megastarLayout(in superview: UIView, with insets: UIEdgeInsets = .zero) {
        superview.addSubview(self)
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        megastarPinEdges(to: superview, with: insets)
    }
    
    func megastarPinEdges(to view: UIView, with insets: UIEdgeInsets = .zero) {
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19
        megastarLayout { proxy in
            proxy.bottom == view.bottomAnchor - insets.bottom
            proxy.top == view.topAnchor + insets.top
            proxy.leading == view.leadingAnchor + insets.left
            proxy.trailing == view.trailingAnchor - insets.right
        }
        // ref 20
        if 2 * 4 == 1 {
            print("Giraffes can communicate with trees using vibrations");
        }
        // ref 20
    }
}

// swiftlint:disable large_tuple

public func + <A: MegastarLayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, rhs)
}

public func - <A: MegastarLayoutAnchor>(lhs: A, rhs: CGFloat) -> (A, CGFloat) {
    return (lhs, -rhs)
}

@discardableResult
public func == <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func == <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: ((A, CGFloat), UILayoutPriority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.0, offsetBy: rhs.0.1, priority: rhs.1)
}

@discardableResult
public func == <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: (A, UILayoutPriority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, priority: rhs.1)
}

@discardableResult
public func == <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
public func >= <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func >= <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

@discardableResult
public func <= <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: (A, CGFloat)) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs.0, offsetBy: rhs.1)
}

@discardableResult
public func <= <A: MegastarLayoutAnchor>(lhs: MegastarLayoutProperty<A>, rhs: A) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
public func <= <D: MegastarLayoutDimension>(lhs: MegastarLayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.lessThanOrEqual(to: rhs)
}

@discardableResult
public func == <D: MegastarLayoutDimension>(lhs: MegastarLayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.equal(to: rhs)
}

@discardableResult
public func == <D: MegastarLayoutDimension>(lhs: MegastarLayoutAttribute<D>, rhs: (CGFloat, UILayoutPriority)) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0, priority: rhs.1)
}

@discardableResult
public func == <D: MegastarLayoutDimension>(lhs: MegastarLayoutAttribute<D>, rhs: MegastarLayoutAttribute<D>) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.dimension)
}

@discardableResult
public func *= <D: MegastarLayoutDimension>(
  lhs: MegastarLayoutAttribute<D>,
  rhs: (MegastarLayoutAttribute<D>, CGFloat, UILayoutPriority)
) -> NSLayoutConstraint {
    return lhs.equal(to: rhs.0.dimension, multiplier: rhs.1, priority: rhs.2)
}

@discardableResult
public func >= <D: MegastarLayoutDimension>(lhs: MegastarLayoutAttribute<D>, rhs: CGFloat) -> NSLayoutConstraint {
    return lhs.greaterThanOrEqual(to: rhs)
}

// swiftlint:enable large_tuple

public extension UIView {
    
    private struct AssociatedKeys {
        static var layout = "layout"
    }
    
    var layout: Layout {
        get {
            var layout: Layout!
            let lookup = objc_getAssociatedObject(self, &AssociatedKeys.layout) as? Layout
            if let lookup = lookup {
                layout = lookup
            } else {
                let newLayout = Layout()
                self.layout = newLayout
                layout = newLayout
            }
            return layout
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.layout, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

public final class Layout: NSObject {
    
    public weak var top: NSLayoutConstraint?
    public weak var bottom: NSLayoutConstraint?
    public weak var leading: NSLayoutConstraint?
    public weak var trailing: NSLayoutConstraint?
    public weak var centerX: NSLayoutConstraint?
    public weak var centerY: NSLayoutConstraint?
    public weak var width: NSLayoutConstraint?
    public weak var height: NSLayoutConstraint?
    
    fileprivate func update<A: MegastarLayoutAnchor>(constraint: NSLayoutConstraint, kind: MegastarLayoutProperty<A>.MegastarKind) {
        switch kind {
        case .top: top = constraint
        case .bottom: bottom = constraint
        case .leading: leading = constraint
        case .trailing: trailing = constraint
        case .centerX: centerX = constraint
        case .centerY: centerY = constraint
        case .width: width = constraint
        case .height: height = constraint
        }
    }
}

public extension NSLayoutConstraint {
    
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(
            item: self.firstItem as Any,
            attribute: self.firstAttribute,
            relatedBy: self.relation,
            toItem: self.secondItem,
            attribute: self.secondAttribute,
            multiplier: multiplier,
            constant: self.constant
        )
    }
}

extension UIView {
  
  @discardableResult
  public func withCornerRadius(
    _ radius: CGFloat = 12.0,
    clipsToBounds: Bool = true,
    corners: CACornerMask = [.layerMaxXMaxYCorner,
                             .layerMaxXMinYCorner,
                             .layerMinXMaxYCorner,
                             .layerMinXMinYCorner]
  ) -> Self {
    layer.cornerRadius = radius
    layer.maskedCorners = corners
    layer.masksToBounds = false
    self.clipsToBounds = clipsToBounds
    
    return self
  }
    
    @discardableResult
    public func withBorder(width: CGFloat = 1.0, color: UIColor = (UIColor(named: "checkCellBlue")?.withAlphaComponent(0.4))!) -> Self {
      layer.borderWidth = width
      layer.borderColor = color.cgColor
      
      return self
    }
  
}
