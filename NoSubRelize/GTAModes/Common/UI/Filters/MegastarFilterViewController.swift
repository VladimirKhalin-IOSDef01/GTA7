//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

public struct MegastarFilterData {
    public let title: String
    public var isCheck: Bool
    
}
public class MegastarPanDragIndicator: MegastarNiblessView {
    
    public static let height = 4.0
    
    public override init() {
        super.init()
        
        megastarSetupView()
    }
    
    private func megastarSetupView() {
        withCornerRadius(Self.height / 2.0)
      
        megastarLayout {
            $0.width.equal(to: 32.0)
            $0.height.equal(to: MegastarPanDragIndicator.height)
        }
        backgroundColor = .gray
    }
}

protocol ActualFilterNavigationHandler: AnyObject {
    
    func megastarFilterDidRequestToClose()
}

// Добавьте делегат для уведомления о изменении состояния переключателя
protocol MegastarFilterTabViewCellDelegate: AnyObject {
    func toggleTapped(_ cell: MegastarFilterTabViewCell)
    
}

final class MegastarFilterViewController: ActualNiblessFilterViewController {
    
    public var selectedFilter: (String) -> ()
    private let colorConteiner = UIView()
    private var filterListData: MegastarFilterListData
    private let tableView = UITableView(frame: .zero)
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let navigationHandler: ActualFilterNavigationHandler
    private var selectedValue: String
    
    
    public init(
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> (),
        navigationHandler: ActualFilterNavigationHandler
    ) {
        self.filterListData = filterListData
        self.selectedFilter = selectedFilter
        self.selectedValue = filterListData.selectedItem
        self.navigationHandler = navigationHandler
        super.init()
    }
    
    public override func viewDidLoad() {
    
        super.viewDidLoad()
        tableView.isScrollEnabled = false
        megastarSetupView()
    }
    
    private func megastarSetupView() {

        let cellHight = UIDevice.current.userInterfaceIdiom == .pad ? 56 : 46
        let actualHeight = (filterListData.filterList.count + 1) * cellHight
        view.withCornerRadius()
       // view.alpha = 0.75
      //  view.backgroundColor = UIColor(named: "modalColor")?.withAlphaComponent(0.7)
        view.backgroundColor = .clear
        view.isOpaque = false

        view.addSubviews(colorConteiner)
        colorConteiner.backgroundColor = .white
      //  colorConteiner.withBorder(width: 1, color: UIColor(named: "ActualPink")!.withAlphaComponent(0.5))
        colorConteiner.withCornerRadius(20)
        colorConteiner.megastarLayout{
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 15)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -15)
            $0.top.equal(to: view.topAnchor, offsetBy: 0)
            //$0.bottom.greaterThanOrEqual(to: view.bottomAnchor)
            //$0.bottom.equal(to: colorConteiner.topAnchor, offsetBy: tableView.frame.height)
            $0.bottom.equal(to: view.topAnchor, offsetBy: CGFloat(actualHeight))
        }
       
        titleLabel.text = "Filter"
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 23)
        titleLabel.textColor = UIColor(named: "MegastarPurp")
        
        view.addSubview(titleLabel)
        titleLabel.megastarLayout {
            $0.centerX.equal(to: view.centerXAnchor)
            $0.top.equal(to: view.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 24.0 : 18)
        }
       
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.clipsToBounds = true
        closeButton.tintColor = UIColor(named: "MegastarPurp")
        
        view.addSubview(closeButton)
        closeButton.megastarLayout {
            $0.trailing.equal(to: colorConteiner.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -16 : -20.0)
            $0.centerY.equal(to: titleLabel.centerYAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 39 : 33.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 34.0)
        }
        closeButton.addTarget(self, action: #selector(megastarCloseAction), for: .touchUpInside)
      
        if let originalImage = UIImage(systemName: "xmark.circle") {
            let targetSize = UIDevice.current.userInterfaceIdiom == .pad ? CGSize(width: 36, height: 36) : CGSize(width: 24, height: 23)
            let renderer = UIGraphicsImageRenderer(size: targetSize)
            let scaledImage = renderer.image { _ in
                originalImage.draw(in: CGRect(origin: .zero, size: targetSize))
            }
            closeButton.setImage(scaledImage.withRenderingMode(.alwaysTemplate), for: .normal)
            closeButton.tintColor = UIColor.black
        }
      
        tableView.accessibilityIdentifier = "tableView"
        view.addSubview(tableView)
        tableView.megastarLayout {
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.top.equal(to: titleLabel.bottomAnchor, offsetBy: 10)
            $0.bottom.equal(to: view.safeAreaLayoutGuide.bottomAnchor, priority: .defaultLow)
        }
        tableView.backgroundColor = .clear
        tableView.sectionFooterHeight = 0.0
        tableView.rowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 46 : 38.0
        tableView.registerReusable_Cell(cellType: MegastarFilterTabViewCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc
    func megastarCloseAction() {
        navigationHandler.megastarFilterDidRequestToClose()
    }
    
}

extension MegastarFilterViewController: MegastarPPresentable {
    
    private var contentSize: CGSize {
        CGSize(
            width: view.frame.width,
            height: UIDevice.current.userInterfaceIdiom == .pad ? 940.0 : 695
        )
        
    }
    
    func megastarMinContentHeight(presentingController: UIViewController) -> CGFloat {
        return contentSize.height
    }
    
    func megastarMaxContentHeight(presentingController: UIViewController) -> CGFloat {
       // print("TESTDEBUG: \(contentSize.height)")
        return contentSize.height
    }
    
}

extension MegastarFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterListData.filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MegastarFilterTabViewCell = tableView.dequeueReusableCell(indexPath)
        let titleCell = filterListData.filterList[indexPath.row]
        let filterDataCell = MegastarFilterData(title: titleCell, isCheck: megastarFilterIsCheckFilter(titleCell) )
        cell.megastarConfigure_cell(filterDataCell)
        cell.delegate = self
        cell.backgroundColor = .clear

        return cell
    }
  
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // Проверяем, является ли текущая ячейка последней
//        if indexPath.row == filterListData.filterList.count - 1 {
//            if let filterCell = cell as? MegastarFilterTabViewCell {
//                filterCell.blockView.removeFromSuperview()
//            }
//        }
//    }

    private func megastarFilterIsCheckFilter(_ titleCell: String) -> Bool {
        if titleCell == filterListData.selectedItem, titleCell == selectedValue {
            return true
        }
        
        if titleCell == filterListData.selectedItem, titleCell != selectedValue {
            return false
        }
        
        if titleCell != filterListData.selectedItem, titleCell == selectedValue {
            return true
        }
        return false
    }
    
}

extension MegastarFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedValue == filterListData.filterList[indexPath.row] {
            selectedValue = ""
            selectedFilter("")
        } else {
            selectedFilter("")
            selectedValue = filterListData.filterList[indexPath.row]
            selectedFilter(selectedValue)
        }
        tableView.reloadData()
    }
}

extension MegastarFilterViewController: MegastarFilterTabViewCellDelegate {
    
    
    func toggleTapped(_ cell: MegastarFilterTabViewCell) {
        // Получаем indexPath выбранной ячейки
        guard let indexPath = tableView.indexPath(for: cell) else { return }
    }
}




