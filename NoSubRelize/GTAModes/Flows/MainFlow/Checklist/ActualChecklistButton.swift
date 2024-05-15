//
//  ActualChecklistButton.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 27.04.2024.
//

import SwiftUI

class ActualChecklistButton: UIControl {
    
    private let label = UILabel()
    private let checkmarkImageView = UIImageView()
    
    var isOn: Bool = false {
        didSet {
            actualUpdateAppearance()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(checkmarkImageView)
        
        // Настройки для галочки
        checkmarkImageView.contentMode = .scaleAspectFit
        checkmarkImageView.image = UIImage(systemName: "square.fill")
        checkmarkImageView.tintColor = .white
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapToggleButton))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        checkmarkImageView.frame = CGRect(x: bounds.width - 30, y: 2, width: 30, height: bounds.height - 3)
    }
    
    @objc private func didTapToggleButton() {
        isOn = !isOn
        sendActions(for: .valueChanged)
    }
    
    private func actualUpdateAppearance() {
        
        UIView.animate(withDuration: 0.2) {
            self.checkmarkImageView.image = UIImage(systemName:  self.isOn ? "checkmark.square.fill" : "square.fill")
        }
    }
}
