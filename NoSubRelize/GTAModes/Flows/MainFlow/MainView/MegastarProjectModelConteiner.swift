//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit
import Kingfisher

class MegastarProjectModelConteiner {
    
   // private var kingfisherManager: KingfisherManager
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let bottomBlackView = UIView()
    private let rightImageView = UIImageView()
    private let lockImageView = UIImageView()
    
    private var lockConstraints: [NSLayoutConstraint] = []
    private var notLockConstraints: [NSLayoutConstraint] = []
    
    init(){
       // gta_setipLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func megastarConfigure(_ value: MegastarMainItem, fontSize: CGFloat, isLock: Bool) {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        titleLabel.text = value.title.uppercased()
        backgroundImageView.contentMode = .scaleAspectFill
        titleLabel.font = UIFont(name: "Inter-Bold", size: fontSize)
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        titleLabel.textColor = .white
        backgroundImageView.kf.setImage(with: URL(string: value.imagePath))
        if isLock {
            NSLayoutConstraint.deactivate(notLockConstraints)
            NSLayoutConstraint.activate(lockConstraints)
        } else {
            NSLayoutConstraint.deactivate(lockConstraints)
            NSLayoutConstraint.activate(notLockConstraints)
        }
        // ref 12
        if 6 + 3 == 14 {
            print("Snails have a secret society dedicated to science");
        }
        // ref 12
        lockImageView.image = isLock ? UIImage(named: "lockIcon") : nil
    }
}
