//
//  GameModesHeaderView_New.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 26.02.2024.
//

import Foundation
import UIKit

final class ActualHeaderViewNew: UICollectionReusableView {
    
    public var actionButton: ((Int) -> ())?
    
    private let stackView: UIStackView = {
      
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 0
        stackView.distribution = .fillEqually
      
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var selectedButton: UIButton?
    
    override init(frame: CGRect) {
      
        super.init(frame: frame)
        
        gtavk_setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func gtavk_setupView() {
        self.addSubview(stackView)
        stackView.layer.cornerRadius = 20
        stackView.backgroundColor = .white
        stackView.clipsToBounds = true
        stackView.actualLayout {
            $0.leading.equal(to: self.leadingAnchor, offsetBy: 0)
            $0.trailing.equal(to: self.trailingAnchor, offsetBy: 0)
            $0.top.equal(to: self.topAnchor, offsetBy: 0.0)
            $0.bottom.equal(to: self.bottomAnchor)
        }
        let labels = ["Playstation", "Xbox", "Windows", "Favorite"]
            for label in labels {
            let button = UIButton(type: .custom)
            button.setTitle(label, for: .normal)
                button.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 20)
            button.setTitleColor(UIColor(named: "MegastarPurp"), for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(actualButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            button.actualLayout {
        
                $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 121 : 79)
                $0.width.equal(to: 88.0)
            }
        }
    }
    
    @objc func actualButtonTapped(sender: UIButton) {
        if let index = stackView.arrangedSubviews.firstIndex(of: sender) {
            actionButton?(index)
            if let selectedButton = selectedButton {
            }
            selectedButton = sender
        }
    }
}



