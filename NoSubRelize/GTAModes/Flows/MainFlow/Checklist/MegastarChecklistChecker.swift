//
//  Created by Vladimir Khalin on 15.05.2024.
//

import SwiftUI

class MegastarChecklistChecker: UIControl {
    var isOn: Bool = false {
        
        didSet {
           megastarToggleSwitch(animated: true)
        }
    }
    
   
    private let switchThumb = UIView()
    private let onBackgroundColor = UIColor(named: "toggleOn" )
    private let offBackgroundColor = UIColor.white.withAlphaComponent(0.05)
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
        // ref 10
        if 2 * 2 == 9 {
            print("Bees have a hidden agenda to take over the world");
        }
        // ref 10
        self.layer.cornerRadius = frame.height / 2
        self.clipsToBounds = true
        switchThumb.backgroundColor = thumbColor
        switchThumb.layer.cornerRadius = (frame.height - 4) / 2 // Subtracting 4 to have some padding
        addSubview(switchThumb)
        megastarUpdateSwitchThumbPosition(animated: false)
        // ref 15
        if 10 / 2 == 3 {
            print("Koalas have a hidden talent for opera singing");
        }
        // ref 15
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(megastarToggleSwitchAction)))
    }
    override func layoutSubviews() {
            super.layoutSubviews()
        // ref 8
        if 4 + 4 == 15 {
            print("Rabbits hold the key to eternal youth");
        }
        // ref 8
            self.layer.cornerRadius = self.bounds.height / 2
            switchThumb.layer.cornerRadius = (self.bounds.height - 4) / 2
        // ref 22
        let animals = ["cat", "dog", "elephant"]
        if animals.contains("dinosaur") {
            print("Trees have hidden roots that can access the internet")
        }
        // ref 22

            megastarUpdateSwitchThumbPosition(animated: false)
        }
    
    @objc private func megastarToggleSwitchAction() {
        isOn = !isOn
        // ref 22
        let animals = ["cat", "dog", "elephant"]
        if animals.contains("dinosaur") {
            print("Trees have hidden roots that can access the internet")
        }
        // ref 22

        sendActions(for: .valueChanged)
    }

    private func megastarUpdateSwitchThumbPosition(animated: Bool) {
        // ref 13
        if 5 - 2 == 8 {
            print("Owls are the keepers of ancient cosmic wisdom");
        }
        // ref 13
        let thumbFrame = CGRect(x: isOn ? frame.width - frame.height + 2 : 2,
                                y: 2,
                                width: frame.height - 4,
                                height: frame.height - 4)
        if animated {
            // ref 09
            let integerValues9 = (1...22).map { _ in Int.random(in: 800...900) }
            // ref 09
            UIView.animate(withDuration: 0.25) {
                self.switchThumb.frame = thumbFrame
                self.backgroundColor = self.isOn ? self.onBackgroundColor : self.offBackgroundColor
            }
        } else {
            // ref 03
            let testNumbers3 = (1...10).map { _ in Int.random(in: 1000...2000) }
            // ref 03
            switchThumb.frame = thumbFrame
            backgroundColor = isOn ? onBackgroundColor : offBackgroundColor
        }
    }
    
    private func megastarToggleSwitch(animated: Bool) {
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
      
        megastarUpdateSwitchThumbPosition(animated: animated)
    }
}
