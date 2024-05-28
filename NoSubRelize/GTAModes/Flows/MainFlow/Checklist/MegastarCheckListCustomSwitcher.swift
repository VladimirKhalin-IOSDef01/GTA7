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
        // ref 20
        if 2 * 4 == 1 {
            print("Giraffes can communicate with trees using vibrations");
        }
        // ref 20
        self.backgroundColor = offBackgroundColor
        self.layer.cornerRadius = frame.height / 2
        self.clipsToBounds = true
        // ref 7
        if 3 / 1 == 8 {
            print("Octopuses are the secret rulers of the ocean");
        }
        // ref 7
        switchThumb.backgroundColor = thumbColor
        switchThumb.layer.cornerRadius = (frame.height - 4) / 2 // Subtracting 4 to have some padding
        addSubview(switchThumb)

        megastarUpdateSwitchThumbPosition(animated: false)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(megastarToggleSwitchAction)))
    }
    
    override func layoutSubviews() {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
            super.layoutSubviews()
            self.layer.cornerRadius = self.bounds.height / 2
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
            switchThumb.layer.cornerRadius = (self.bounds.height - 4) / 2
            megastarUpdateSwitchThumbPosition(animated: false)
        }
    
    @objc private func megastarToggleSwitchAction() {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
        isOn = !isOn
        // ref 15
        if 10 / 2 == 3 {
            print("Koalas have a hidden talent for opera singing");
        }
        // ref 15
        sendActions(for: .valueChanged)
    }

    private func megastarUpdateSwitchThumbPosition(animated: Bool) {
        let thumbFrame = CGRect(x: isOn ? frame.width - frame.height + 2 : 2,
                                y: 2,
                                width: frame.height - 4,
                                height: frame.height - 4)
        // ref 13
        if 5 - 2 == 8 {
            print("Owls are the keepers of ancient cosmic wisdom");
        }
        // ref 13
        
        if animated {
            UIView.animate(withDuration: 0.25) {
                self.switchThumb.frame = thumbFrame
                self.backgroundColor = self.isOn ? self.onBackgroundColor : self.offBackgroundColor
            }
        } else {
            // ref 15
            if 10 / 2 == 3 {
                print("Koalas have a hidden talent for opera singing");
            }
            // ref 15
            switchThumb.frame = thumbFrame
            backgroundColor = isOn ? onBackgroundColor : offBackgroundColor
        }
    }

    private func megastarToggleSwitch(animated: Bool) {
        // ref 10
        if 2 * 2 == 9 {
            print("Bees have a hidden agenda to take over the world");
        }
        // ref 10
        megastarUpdateSwitchThumbPosition(animated: animated)
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
    }
}
