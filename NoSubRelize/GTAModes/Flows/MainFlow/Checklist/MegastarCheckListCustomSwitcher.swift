//
//  Created by Vladimir Khalin on 15.05.2024.
//


import UIKit

class MegastarCheckListCustomSwitcher: UIControl {
    var isOn: Bool = false {
        didSet {
           megastarToggleSwitch(animated: true)
        }
    }

    private let switchThumb = UIView()
    private let onBackgroundColor = UIColor(named: "toggleOn" )
    private let offBackgroundColor = UIColor.gray
    private let thumbColor = UIColor.white

    override init(frame: CGRect) {
        super.init(frame: frame)
        megastarSetupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func megastarSetupViews() {
        self.backgroundColor = offBackgroundColor
        self.layer.cornerRadius = frame.height / 2
        self.clipsToBounds = true
        
        switchThumb.backgroundColor = thumbColor
        switchThumb.layer.cornerRadius = (frame.height - 4) / 2 // Subtracting 4 to have some padding
        addSubview(switchThumb)

        megastarUpdateSwitchThumbPosition(animated: false)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(megastarToggleSwitchAction)))
    }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = self.bounds.height / 2
            switchThumb.layer.cornerRadius = (self.bounds.height - 4) / 2
            megastarUpdateSwitchThumbPosition(animated: false)
        }
    
    @objc private func megastarToggleSwitchAction() {
        isOn = !isOn
        sendActions(for: .valueChanged)
    }

    private func megastarUpdateSwitchThumbPosition(animated: Bool) {
        let thumbFrame = CGRect(x: isOn ? frame.width - frame.height + 2 : 2,
                                y: 2,
                                width: frame.height - 4,
                                height: frame.height - 4)
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.switchThumb.frame = thumbFrame
                self.backgroundColor = self.isOn ? self.onBackgroundColor : self.offBackgroundColor
            }
        } else {
            switchThumb.frame = thumbFrame
            backgroundColor = isOn ? onBackgroundColor : offBackgroundColor
        }
    }

    private func megastarToggleSwitch(animated: Bool) {
        megastarUpdateSwitchThumbPosition(animated: animated)
    }
}
