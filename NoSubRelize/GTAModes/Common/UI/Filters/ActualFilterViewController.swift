//
//  FilterViewController.swift
//  GTAModes
//
//  Created by Максим Педько on 30.07.2023.
//

import Foundation
import UIKit

public struct ActualFilterData {
    public let title: String
    public var isCheck: Bool
    
}
public class ActualPanDragIndicator: ActualNiblessView {
    
    public static let height = 4.0
    
    public override init() {
        super.init()
        
        gtavk_setupView()
    }
    
    private func gtavk_setupView() {
        withCornerRadius(Self.height / 2.0)
      
        actualLayout {
            $0.width.equal(to: 32.0)
            $0.height.equal(to: ActualPanDragIndicator.height)
        }
        backgroundColor = .gray
       
    }
}

protocol ActualFilterNavigationHandler: AnyObject {
    
    func actualFilterDidRequestToClose()
}

// Добавьте делегат для уведомления о изменении состояния переключателя
protocol ActualFilterTabViewCellDelegate: AnyObject {
    func toggleTapped(_ cell: ActualFilterTabViewCell)
    
}

final class ActualFilterViewController: ActualNiblessFilterViewController {
    
    public var selectedFilter: (String) -> ()
    private let colorConteiner = UIView()
    private var filterListData: ActualFilterListData
    private let tableView = UITableView(frame: .zero)
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let navigationHandler: ActualFilterNavigationHandler
    private var selectedValue: String
    
    
    public init(
        filterListData: ActualFilterListData,
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
        actualSetupView()
    }
    
    private func actualSetupView() {

        let cellHight = UIDevice.current.userInterfaceIdiom == .pad ? 52 : 43
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
        colorConteiner.actualLayout{
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.top.equal(to: view.topAnchor, offsetBy: 0)
            //$0.bottom.greaterThanOrEqual(to: view.bottomAnchor)
            //$0.bottom.equal(to: colorConteiner.topAnchor, offsetBy: tableView.frame.height)
            $0.bottom.equal(to: view.topAnchor, offsetBy: CGFloat(actualHeight))
        }
       
        titleLabel.text = "Filter"
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 22)
        titleLabel.textColor = UIColor(named: "MegastarPurp")
        
        view.addSubview(titleLabel)
        titleLabel.actualLayout {
            $0.centerX.equal(to: view.centerXAnchor)
            $0.top.equal(to: view.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 24.0 : 18)
        }
       
        closeButton.setImage(UIImage(systemName: "xmark.circle"), for: .normal)
        closeButton.clipsToBounds = true
        closeButton.tintColor = UIColor(named: "MegastarPurp")
        
        view.addSubview(closeButton)
        closeButton.actualLayout {
            $0.trailing.equal(to: colorConteiner.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -15 : -10.0)
            $0.centerY.equal(to: titleLabel.centerYAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 39 : 33.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 40 : 34.0)
        }
        closeButton.addTarget(self, action: #selector(actualCloseAction), for: .touchUpInside)
      
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
        tableView.actualLayout {
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.top.equal(to: titleLabel.bottomAnchor, offsetBy: 10)
            $0.bottom.equal(to: view.safeAreaLayoutGuide.bottomAnchor, priority: .defaultLow)
        }
        tableView.backgroundColor = .clear
        tableView.sectionFooterHeight = 0.0
        tableView.rowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 46 : 38.0
        tableView.registerReusable_Cell(cellType: ActualFilterTabViewCell.self)
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc
    func actualCloseAction() {
        navigationHandler.actualFilterDidRequestToClose()
    }
    
}

extension ActualFilterViewController: ActualPPresentable {
    
    private var contentSize: CGSize {
        CGSize(
            width: view.frame.width,
            height: UIDevice.current.userInterfaceIdiom == .pad ? 800.0 : 600
        )
    }
    
    func actualMinContentHeight(presentingController: UIViewController) -> CGFloat {
        return contentSize.height
    }
    
    func actualMaxContentHeight(presentingController: UIViewController) -> CGFloat {
        return contentSize.height
    }
    
}

extension ActualFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterListData.filterList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActualFilterTabViewCell = tableView.dequeueReusableCell(indexPath)
        let titleCell = filterListData.filterList[indexPath.row]
        let filterDataCell = ActualFilterData(title: titleCell, isCheck: actualFilterIsCheckFilter(titleCell) )
        cell.actualConfigure_cell(filterDataCell)
        cell.delegate = self
        cell.backgroundColor = .clear

        return cell
    }
  
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        // Проверяем, является ли текущая ячейка последней
//        if indexPath.row == filterListData.filterList.count - 1 {
//            if let filterCell = cell as? ActualFilterTabViewCell {
//                filterCell.blockView.removeFromSuperview()
//            }
//        }
//    }

    private func actualFilterIsCheckFilter(_ titleCell: String) -> Bool {
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

extension ActualFilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if selectedValue == filterListData.filterList[indexPath.row] {
            selectedValue = ""
            selectedFilter("")
        } else {
            selectedValue = filterListData.filterList[indexPath.row]
            selectedFilter(selectedValue)
        }
        tableView.reloadData()
    }
}

extension ActualFilterViewController: ActualFilterTabViewCellDelegate {
    
    
    func toggleTapped(_ cell: ActualFilterTabViewCell) {
        // Получаем indexPath выбранной ячейки
        guard let indexPath = tableView.indexPath(for: cell) else { return }
    }
}




