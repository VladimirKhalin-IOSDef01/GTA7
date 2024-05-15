//
//  MegastarCustomDropBarView.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

final class MegastarCustomDropBarView: UICollectionReusableView {
    
    public var hideButton: ((Bool) -> ())?
  
    private var openImage = UIImageView()
    var labelStackButton = UILabel()
    var isMenuOpen = false
   
    // Стек кнопки модального окна
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        stackView.distribution = .fillEqually
      
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var selectedButton: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        megastarSetupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func megastarSetupView() {
        
        self.addSubview(stackView)
        stackView.layer.cornerRadius = 20
        stackView.backgroundColor = UIColor.white
        stackView.clipsToBounds = true
        stackView.actualLayout {
            $0.leading.equal(to: self.leadingAnchor)
            $0.trailing.equal(to: self.trailingAnchor)
            $0.top.equal(to: self.topAnchor)
            $0.bottom.equal(to: self.bottomAnchor)
        }
        
        let stackButton = UIButton(type: .custom)
        stackButton.addTarget(self, action: #selector(megastarPushMenu), for: .touchUpInside)
        stackView.addArrangedSubview(stackButton)

        stackButton.addSubviews(openImage)
        openImage.image = UIImage(named: "MegastarDown")
        openImage.clipsToBounds = true
        openImage.actualLayout {
            $0.trailing.equal(to: stackButton.trailingAnchor, offsetBy: -10)
            $0.centerY.equal(to: stackButton.centerYAnchor)
            $0.width.equal(to: 24)
            $0.height.equal(to: 24)
        }
        
        stackButton.addSubviews(labelStackButton)
        labelStackButton.text = "Playstation"
        labelStackButton.font = UIFont(name: "OpenSans-SemiBold", size: 20)
        labelStackButton.textColor = UIColor(named: "MegastarPurp")
        labelStackButton.actualLayout {
            $0.centerX.equal(to: stackButton.centerXAnchor)
            $0.centerY.equal(to: stackButton.centerYAnchor)
        }
    }
    
    @objc func megastarPushMenu() {
        hideButton?(isMenuOpen)
        isMenuOpen.toggle()
        if isMenuOpen {
            openImage.image = UIImage(named: "MegastarUp")
        } else {
            openImage.image = UIImage(named: "MegastarDown")
        }
    }
}
