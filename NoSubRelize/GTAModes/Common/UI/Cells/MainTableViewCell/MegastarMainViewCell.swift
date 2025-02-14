//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit
import Kingfisher

final class MegastarMainViewCell: UITableViewCell, MegastarReusable {
    private var kingfisherManager: KingfisherManager
    
    private let containerView = UIView()
    private let backgroundImageView = UIImageView()
    private let titleLabel = UILabel()
    private let bottomBlackView = UIView()
    private let rightImageView = UIImageView()
    private let lockImageView = UIImageView()
    
    private var titleImage = UIImageView()
    private var lockConstraints: [NSLayoutConstraint] = []
    private var notLockConstraints: [NSLayoutConstraint] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.kingfisherManager = KingfisherManager.shared
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        megastarSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func megastarConfigure(_ value: MegastarMainItem, fontSize: CGFloat, isLock: Bool) {
        
        var titleName = ""
        
        switch value.title {
        case "Version VI": titleName = "Version 6"
        case "Version V": titleName = "Version 5"
        default: titleName = value.title
        }
      
        print("ACTUALNAME: \(value.title)")
        
        //titleLabel.text = value.title.uppercased() + "→"
       // titleLabel.text = value.title
        titleLabel.text = titleName
        backgroundImageView.contentMode = .scaleAspectFill
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: fontSize)
        titleLabel.textColor = .white
       
        titleImage.image = value.typeItem == .main ? UIImage(named: "\(value.title)") : nil

        backgroundImageView.kf.setImage(with: URL(string: value.imagePath))
        if isLock {
            NSLayoutConstraint.deactivate(notLockConstraints)
            NSLayoutConstraint.activate(lockConstraints)
        } else {
            NSLayoutConstraint.deactivate(lockConstraints)
            NSLayoutConstraint.activate(notLockConstraints)
        }
        lockImageView.image = isLock ? UIImage(named: "lockIcon") : nil
    }
    
    public override func prepareForReuse() {
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        super.prepareForReuse()
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
        backgroundImageView.image = nil
        lockImageView.image = nil
        titleLabel.text = ""
    }
    
    private func megastarSetupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 4
        containerView.withCornerRadius(20.0)
        containerView.clipsToBounds = true
      //  containerView.perspectiveDropShadowStandart(color: .white, offSet: CGSize(width: 10, height: 10))
      //  containerView.perspectiveDropShadowWhite()
      //  containerView.perspectiveDropShadowStandart(color: .white, offSet: CGSize(width: 10, height: 10), radius: 1)
     
        containerView.megastarLayout {
            $0.top.equal(to: contentView.topAnchor, offsetBy: 0.0)
           // $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 0 : 0.0)
            $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -18 : -11.0)
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: 0.0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy: 0.0)
        }
        containerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20)
        containerView.backgroundColor = .clear
      
        
        containerView.addSubview(backgroundImageView)
        backgroundImageView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 30 : 20
        
        
        backgroundImageView.megastarLayout {
            $0.top.equal(to: containerView.topAnchor)
            $0.bottom.equal(to: containerView.bottomAnchor)
            $0.leading.equal(to: containerView.leadingAnchor)
            $0.trailing.equal(to: containerView.trailingAnchor)
        }
        
        backgroundImageView.addSubview(bottomBlackView)
      
        bottomBlackView.megastarLayout {
            $0.top.equal(to: containerView.topAnchor)
            $0.bottom.equal(to: backgroundImageView.bottomAnchor)
            $0.leading.equal(to: backgroundImageView.leadingAnchor)
            $0.trailing.equal(to: backgroundImageView.trailingAnchor)
            //$0.height.equal(to: 60.0)
        }
       
        bottomBlackView.backgroundColor = UIColor(named: "MegastarPurp")?.withAlphaComponent(0.60)
     
        bottomBlackView.addSubview(lockImageView)
        lockImageView.megastarLayout {
            $0.bottom.equal(to: bottomBlackView.bottomAnchor, offsetBy: -12.0)
            $0.leading.equal(to: bottomBlackView.leadingAnchor, offsetBy: 18.0)
            $0.top.equal(to: bottomBlackView.topAnchor, offsetBy: 12.0)
            $0.height.equal(to: 32.0)
            
            lockConstraints = [
                $0.width.equal(to: 32.0, isActive: false)
            ]
            
            notLockConstraints = [
                $0.width.equal(to: 0.0, isActive: false)
            ]
            
        }
        lockImageView.contentMode = .scaleAspectFill
     
        
        bottomBlackView.addSubview(titleLabel)
        titleLabel.center = CGPoint(x: titleLabel.bounds.size.width/2, y: titleLabel.bounds.size.height/2)
    
        titleLabel.megastarLayout {
           // $0.centerX.equal(to: containerView.centerXAnchor)
       //     $0.bottom.equal(to: bottomBlackView.bottomAnchor, offsetBy: -12.0)
           // $0.leading.equal(to: lockImageView.centerXAnchor, offsetBy: -10.0)
           // $0.leading.equal(to: lockImageView.trailingAnchor, offsetBy: 2.0)
            $0.top.equal(to: bottomBlackView.topAnchor, offsetBy: 22.0)
            $0.trailing.equal(to: bottomBlackView.trailingAnchor, offsetBy: -22)
        }
//  
//        bottomBlackView.addSubview(titleImage)
//        titleImage.megastarLayout {
//            $0.centerX.equal(to: containerView.centerXAnchor)
//            $0.centerY.equal(to: titleLabel.centerYAnchor, offsetBy: -43)
//            $0.height.equal(to: 39.0)
//            $0.width.equal(to: 39.0)
//        }
        
        
        
//
//        bottomBlackView.addSubview(rightImageView)
//        rightImageView.gta_layout {
//            $0.bottom.equal(to: bottomBlackView.bottomAnchor, offsetBy: -12.0)
//            $0.trailing.equal(to: bottomBlackView.trailingAnchor, offsetBy: -18.0)
//            $0.top.equal(to: bottomBlackView.topAnchor, offsetBy: 12.0)
//            $0.height.equal(to: 30.0)
//            $0.width.equal(to: 30.0)
//        }
//        rightImageView.image = UIImage(named: "rightIcon")
//        containerView.bringSubviewToFront(bottomBlackView)
        
    }
    
}
