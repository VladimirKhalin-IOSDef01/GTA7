

import Foundation
import UIKit

final class ActualChecklistCell: UICollectionViewCell, ActualReusable {
    
    public var isCheckAction: ((Bool) -> ())?
    
    private let containerView = UIView()
    private let buttonView = UIView()
    private let titleLabel = UILabel()
    private let buttonLabel = UILabel()
    private let switcher = ActualChecklistButton()
    
    override func prepareForReuse() {
     
        super.prepareForReuse()
     
        switcher.isOn = false
        isCheckAction = nil   // Сброс обработчика действий
    }
    
    override init(frame: CGRect) {
    
        super.init(frame: frame)
      
        actualSetupLayout()
    }
    
    required init?(coder: NSCoder) {
      
        fatalError("init(coder:) has not been implemented")
    }
    
    public func actualConfigure_cell(_ value: ActualMissionItem) {
       
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 28.0 : 20.0)
        titleLabel.textColor = .white
        titleLabel.text = value.missionName
        switcher.isOn = value.isCheck
    }
    
    private func actualSetupLayout() {
      
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.actualLayout {
            $0.top.equal(to: contentView.topAnchor, offsetBy: 7.0)
            $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: -7.0)
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: 0.0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy: 0.0)
          //  $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 650 : 350)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 74 : 74)
            $0.centerX.equal(to: containerView.centerXAnchor)
        }
        containerView.withCornerRadius(20.0)
        containerView.layer.borderWidth = 4
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.actualDropShadowStandart()
        containerView.backgroundColor = UIColor(named: "MegastarPurp")
      
        containerView.addSubview(titleLabel)
        titleLabel.actualLayout {
            $0.top.equal(to: containerView.topAnchor, offsetBy: 5.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 15.0)
          //  $0.trailing.lessThanOrEqual(to: containerView.trailingAnchor, offsetBy: -20.0)
            $0.centerY.equal(to: containerView.centerYAnchor)
        }
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
      
        containerView.addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.clipsToBounds = true
        switcher.contentMode = .scaleAspectFit
        switcher.actualLayout {
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -30 : -13.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 13.0)
            $0.centerY.equal(to: containerView.centerYAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 48 : 36.0)
        }
        
        switcher.addTarget(self, action: #selector(actualSwitchValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func actualSwitchValueChanged(_ sender: ActualChecklistButton) {
        isCheckAction?(sender.isOn)
    }
}
