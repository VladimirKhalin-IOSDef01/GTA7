//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

final class MegastarHeaderView: UITableViewHeaderFooterView, MegastarReusable {
    
    public var actionButton: ((Int) -> ())?
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var selectedButton: UIButton?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        megastarSetupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func megastarSetupView() {
        contentView.addSubview(stackView)
        stackView.megastarLayout {
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: 0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy: 0)
            $0.top.equal(to: contentView.topAnchor, offsetBy: 0)
            $0.bottom.equal(to: contentView.bottomAnchor)
            
        }
        
        let titles = ["Playstation", "Xbox", "Microsoft", "Favorites"]
        
        for titleName in titles {
            let button = UIButton(type: .custom)
            button.setTitle(titleName, for: .normal)
            button.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 15)
            button.withCornerRadius(10.0)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.addTarget(self, action: #selector(megastarButtonTapped), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            if titleName == "Playstation" {
                button.backgroundColor = UIColor(named: "ButtonPressed")?.withAlphaComponent(1.0)
                selectedButton = button
            } else {
                button.backgroundColor = UIColor(named: "ButtonColor")?.withAlphaComponent(1.0)
            }
           
            button.megastarLayout {
                $0.height.equal(to: 25.0)
                switch titleName {
                case "Playstation": $0.width.equal(to: 95.0)
                case "Xbox": $0.width.equal(to: 54.0)
                case "Microsoft": $0.width.equal(to: 82.0)
                default: $0.width.equal(to: 81.0)
                }
            }
        }
    }
    
    @objc func megastarButtonTapped(sender: UIButton) {
        if let index = stackView.arrangedSubviews.firstIndex(of: sender) {
            actionButton?(index)
            if let selectedButton = selectedButton {
                selectedButton.backgroundColor = UIColor(named: "ButtonColor")?.withAlphaComponent(1.0)
            }
            selectedButton = sender
            sender.backgroundColor = UIColor(named: "ButtonPressed")?.withAlphaComponent(1.0)
        }
    }
}

