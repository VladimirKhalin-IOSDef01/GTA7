//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

final class MegastarFilterTabViewCell: UITableViewCell, MegastarReusable {
   
    weak var delegate: MegastarFilterTabViewCellDelegate?
    var indexPath: IndexPath?
    var tableView: UITableView? // Добавлено свойство tableView
    
    public var isCheckAction: ((Bool) -> ())?
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let checkImage = UIImageView()
    let borderLineView = UIView()
    private let blockView = UIView()
    let switcher = UISwitch()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        switcher.isOn = false
        switcher.removeTarget(nil, action: nil, for: .allEvents)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        megastarSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func megastarConfigure_cell(_ value: MegastarFilterData) {
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 18)
        titleLabel.textColor = UIColor(named: "MegastarPurp")
        titleLabel.text = value.title.capitalized(with: .autoupdatingCurrent)
        switcher.isOn = value.isCheck // Установите состояние переключателя
     //   checkImage.isHidden = !value.isCheck // Управление видимостью галочки
        checkImage.image = UIImage(systemName: !value.isCheck ? "square.fill" : "checkmark.square.fill")
    }
    
    private func megastarSetupLayout() {
        // contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        // containerView.backgroundColor = .clear
        
        containerView.megastarLayout {
            $0.top.equal(to: contentView.topAnchor)
            $0.bottom.equal(to: contentView.bottomAnchor)
            $0.leading.equal(to: contentView.leadingAnchor)
            $0.trailing.equal(to: contentView.trailingAnchor)
        }
        containerView.addSubview(checkImage)
        checkImage.megastarLayout {
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -16.0)
            $0.centerY.equal(to: containerView.centerYAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 30)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 30)
        }
        checkImage.image = UIImage(systemName: "square.fill")
        checkImage.tintColor = UIColor(named: "MegastarPurp")
        containerView.addSubview(titleLabel)
        titleLabel.megastarLayout {
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 16.0)
            $0.trailing.equal(to: checkImage.leadingAnchor, offsetBy: -4.0)
            $0.centerY.equal(to: containerView.centerYAnchor)
        }
       /*
        containerView.addSubview(borderLineView)
        borderLineView.megastarLayout {
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -20)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 20.0)
            $0.bottom.equal(to: containerView.bottomAnchor)
            $0.height.equal(to: 1.5)
        }
        borderLineView.backgroundColor = .gray.withAlphaComponent(0.5)
       */
        /*
        containerView.addSubview(switcher)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.megastarLayout {
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -60.0 : -17)
            $0.centerY.equal(to: containerView.centerYAnchor)
            $0.height.equal(to: 40.0)
            $0.width.equal(to: 63.0)
        }
        switcher.onTintColor = .init(named: "ActualPink")
        // switcher.addTarget(self, action: #selector(perspectiveSwitchValueChanged(_:)), for: .valueChanged)
        switcher.addTarget(self, action: #selector(toggleTapped(_:)), for: .valueChanged)
        
            containerView.addSubview(blockView)
            blockView.backgroundColor = .clear
            blockView.megastarLayout{
                $0.trailing.equal(to: containerView.trailingAnchor, offsetBy:  UIDevice.current.userInterfaceIdiom == .pad ? -60.0 : -17)
                $0.centerY.equal(to: containerView.centerYAnchor)
                $0.height.equal(to: 40.0)
                $0.width.equal(to: 63.0)
            }
        */
    }
    
    @objc func toggleTapped(_ sender: UISwitch) {
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19
           delegate?.toggleTapped(self)
    }
}
    
    
    
    
    
    
    
    // Обработчик изменения состояния переключателя
//        @objc private func switchValueChanged(_ sender: UISwitch) {
//            let isChecked = sender.isOn
//            checkImage.isHidden = !isChecked
//            // Получите индекс ячейки
//            guard let indexPath = self.indexPath else { return }
//            // Уведомите делегата о изменении состояния переключателя
//            delegate?.switchValueChanged(at: indexPath, isOn: isChecked)
//        
// }
//}


