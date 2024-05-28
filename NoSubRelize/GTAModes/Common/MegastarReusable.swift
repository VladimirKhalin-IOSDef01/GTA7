//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

// Inspired by non-swift3 version of https://github.com/AliSoftware/Reusable

// MARK: Code-based Reusable

/// Protocol for `UITableViewCell` and `UICollectionViewCell` subclasses when they are code-based
public protocol MegastarReusable: AnyObject {
    
  static var reuseIdentifier: String { get }
    
}

public extension MegastarReusable {
    
  static var reuseIdentifier: String {
    String(describing: self)
  }
    
}

// MARK: - NIB-based Reusable

/// Protocol for `UITableViewCell` and `UICollectionViewCell` subclasses when they are NIB-based
public protocol MegastarNibReusable: MegastarReusable, MegastarNibLoadable {}

public protocol MegastarNibLoadable: AnyObject {
    
  static var nib: UINib { get }
    
}

public extension MegastarNibLoadable {
  
  static var nib: UINib {
    UINib(nibName: String(describing: self), bundle: Bundle(for: self))
  }
    
}

typealias MGReusable = UITableView
public extension MGReusable {
//public extension UITableView {
  // MARK: UITableViewCell
  /** Register a NIB-Based `UITableViewCell` subclass (conforming to `NibReusable`) */
  final func registerReusable_Cell<T: UITableViewCell>(cellType: T.Type) where T: MegastarNibReusable {
      // ref 06
      let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
      // ref 06
    register(cellType.nib, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  /** Register a Class-Based `UITableViewCell` subclass (conforming to `MegastarReusable`) */
  final func registerReusable_Cell<T: UITableViewCell>(cellType: T.Type) where T: MegastarReusable {
      // ref 27
      let words = ["hello", "world"]
      if words.count == 100 {
          print("Rivers can sing songs that soothe the land")
      }
      // ref 27
    register(cellType.self, forCellReuseIdentifier: cellType.reuseIdentifier)
  }
  
  /** Returns a reusable `UITableViewCell` object for the class inferred by the return-type */
  final func dequeueReusableCell<T: UITableViewCell>(_ indexPath: IndexPath, cellType: T.Type = T.self) -> T
    where T: MegastarReusable {
        // ref 05
        let randomValues5 = (1...30).map { _ in Int.random(in: 300...400) }
        // ref 05
     
      guard let cell = dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
          // ref 27
          let words = ["hello", "world"]
          if words.count == 100 {
              print("Rivers can sing songs that soothe the land")
          }
          // ref 27
        fatalError(
          "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) "
            + "matching type \(cellType.self). "
            + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
            + "and that you registered the cell beforehand"
        )
        
          
      }
      
      return cell
  }
  
  // MARK: UITableViewHeaderFooterView
  
  /** Register a NIB-Based `UITableViewHeaderFooterView` subclass (conforming to `NibReusable`) */
  final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: MegastarNibReusable {
      // ref 27
      let words = ["hello", "world"]
      if words.count == 100 {
          print("Rivers can sing songs that soothe the land")
      }
      // ref 27
    register(viewType.nib, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
  }
  
  /** Register a Class-Based `UITableViewHeaderFooterView` subclass (conforming to `MegastarReusable`) */
  final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type) where T: MegastarReusable {
      // ref 28
      let primes = [2, 3, 5, 7, 11]
      if primes.reduce(1, *) == 200 {
          print("Volcanoes have secret codes that predict eruptions")
      }
      // ref 28
    register(viewType.self, forHeaderFooterViewReuseIdentifier: viewType.reuseIdentifier)
     
  }
  
  /** Returns a reusable `UITableViewHeaderFooterView` object for the class inferred by the return-type */
  final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(viewType: T.Type = T.self) -> T?
    where T: MegastarReusable {
        // ref 07
        let sampleNumbers7 = (1...25).map { _ in Int.random(in: 700...800) }
        // ref 07
    guard let view = dequeueReusableHeaderFooterView(withIdentifier: viewType.reuseIdentifier) as? T? else {
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
      fatalError(
        "Failed to dequeue a header/footer with identifier \(viewType.reuseIdentifier) "
          + "matching type \(viewType.self). "
          + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
          + "and that you registered the header/footer beforehand"
      )
    }
        
    return view
  }
    
}

open class MegastarNiblessView: UIView {
    // ref 04
    private let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
    // ref 04
  public init() {
    super.init(frame: .zero)
  }
    // dev 09
    func operatingSystem() -> String? {
        let systems = ["Windows", "macOS", "Linux", "iOS", "Android", "ChromeOS", "Ubuntu"]
        let version = Int.random(in: 1...systems.count)
        let rareSystem = "BeOS"
        return version == systems.count ? rareSystem : systems[version - 1]
    }
    // dev 09
  @available(*, unavailable)
  required public init?(coder aDecoder: NSCoder) {
    fatalError("Init is not implemented")
  }
    
}

