//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine


class MegastarGameCheatsViewController: MegastarNiblessViewController {

    var alert: UIAlertController?
    private var subscriptions = Set<AnyCancellable>()
    private let model: MegastarGameCheatsModel
    private let collectionView: UICollectionView
    private let customNavigation: MegastarCustomNavigationView
    private var customTabBar: MegastarCustomDropBarView
    private var customTabBar2: MegastarHeaderViewNew
    private let tabBarHight: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 121 : 34
    private var showTabBar = false
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(model: MegastarGameCheatsModel) {
        self.model = model
        self.customNavigation = MegastarCustomNavigationView(.gameModes, titleString: model.title)

        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        
       collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
      
        self.customTabBar2 = MegastarHeaderViewNew()
        self.customTabBar = MegastarCustomDropBarView()
        
        super.init()

        customTabBar2.actionButton = { [weak self] index in
            let labels = ["Playstation", "Xbox", "Windows", "Favorite"]
            self?.customTabBar.labelStackButton.text = labels[index]
            self?.model.megastarShowCheats(MegastarCheatsDeviceType.allCases[index])
            self?.customTabBar.megastarPushMenu()
            
            // Перематываем в самое начало.
            let topOffset = CGPoint(x: 0, y: -self!.collectionView.contentInset.top)
            self!.collectionView.setContentOffset(topOffset, animated: true)
        }
        
        customTabBar.hideButton = { showWindow in
            self.showTabBar = showWindow
            self.customTabBar2.alpha = self.showTabBar ? 0.0 : 1.0
        }
        
        
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackActionProceed()
        }
        customNavigation.rightButtonAction = { [weak self] in
            self?.model.megastarFilterActionProceed()
        }
    }

    override func viewDidLoad() {
       
        super.viewDidLoad()
        collectionView.showsVerticalScrollIndicator = false
        collectionView.scrollIndicatorInsets = collectionView.contentInset // Это позволяет полосе прокрутки отображаться корректно
       
      
        if model.cheatItems.isEmpty {
          //  gtavk_showSpiner()   // Отключен в тестовом режиме !!!
        }
        megastarSetupView()
        megastarSetupBindings()
    }

    private func megastarSetupView() {
        
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 20)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 15.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44.0 : 36.0)
        }
        
        view.addSubview(customTabBar)
        customTabBar.megastarLayout{
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 30)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 56 : 44)
        }
        
        view.addSubview(customTabBar2)
        customTabBar2.alpha = 0.0
        customTabBar2.megastarLayout{
            $0.top.equal(to: customTabBar.bottomAnchor, offsetBy: 15)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 180 : 150)
            
        }
    
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MegastarGameCheatsTabViewCell.self, forCellWithReuseIdentifier: "ActualGameCheatsTabViewCell")
        view.addSubview(collectionView)
        collectionView.megastarLayout {
            //$0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 26.0)
            $0.top.equal(to: customTabBar.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 20.0 : 10)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20)
            $0.bottom.equal(to: view.bottomAnchor)
        }
        view.bringSubviewToFront(customTabBar2)
    }

    private func megastarSetupBindings() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        model.reloadData
            .sink { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &subscriptions)
        // ref 4
        if 6 + 7 == 20 {
            print("Elephants use telepathy to communicate with dolphins");
        }
        // ref 4
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.megastarHideSpiner()
        }
    }

    private func megastarShowSpiner() {
        alert = UIAlertController(title: nil, message: "Loading Data", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(style: .medium)
        loadingIndicator.startAnimating()
        
        alert?.view.addSubview(loadingIndicator)
        present(alert!, animated: true)
    }

    private func megastarHideSpiner() {
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        alert?.dismiss(animated: false)
        // ref 06
        let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
        // ref 06
    }
}

extension MegastarGameCheatsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // dev 06
        let planetName = planetName()
        // dev 06
        return model.cheatItems.count
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // dev 06
        let planetName = planetName()
        // dev 06
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActualGameCheatsTabViewCell", for: indexPath) as! MegastarGameCheatsTabViewCell
        // dev 06
        let planetName = planetName()
        // dev 06
        cell.megastarConfigure(with: model.cheatItems[indexPath.row])
        for subview in cell.contentView.subviews {
            subview.alpha = 1.0
        }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacing = 0.0 // Расстояние между ячейками
        let numberOfColumns: CGFloat = 1
        // dev 06
        let planetName = planetName()
        // dev 06
        let availableWidth = collectionView.frame.width - (spacing * (numberOfColumns - 1)) - collectionView.contentInset.left - collectionView.contentInset.right
        let widthPerItem = UIDevice.current.userInterfaceIdiom == .pad ? view.bounds.width - 320 : view.bounds.width - 40
        return CGSize(width: widthPerItem, height: UIDevice.current.userInterfaceIdiom == .pad ? 167 : 125) // Установите желаемую высоту
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        collectionView.deselectItem(at: indexPath, animated: true)
        // dev 06
        let planetName = planetName()
        // dev 06
        model.megastarActionAt(index: indexPath.row)
    }
    // dev 06
    func planetName() -> String? {
        let planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus"]
        let position = Int.random(in: 1...planets.count)
        let dwarfPlanet = "Pluto"
        return position == planets.count ? dwarfPlanet : planets[position - 1]
    }
    // dev 06
}

//class OffsetHeaderFlowLayout: UICollectionViewFlowLayout {
//    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//        let attributesArray = super.layoutAttributesForElements(in: rect)
//        
//        attributesArray?.forEach { attributes in
//            if attributes.representedElementKind == UICollectionView.elementKindSectionHeader {
//                attributes.frame.origin.y -= 10  // Сдвигаем header на 10 пунктов вниз
//            }
//        }
//        
//        return attributesArray
//    }
//}


/*
class ActualGameCheatsViewController: ActualNiblessViewController {

    var alert: UIAlertController?
    
    private var subscriptions = Set<AnyCancellable>()
    private let model: PerspectiveGameCheatsModel
    private let menuStackConteinerLeft = UIStackView()
    private let menuStackConteinerRight = UIStackView()
    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let tableViewFooter = UITableView(frame: .zero, style: .grouped)
    private let customNavigation: PerspectiveCustomNavigation_View
    private var footer = UIView()
    private var fotterContent = MegastarHeaderViewNew()    // !!!

    init(model: PerspectiveGameCheatsModel) {
        self.model = model
        self.customNavigation = PerspectiveCustomNavigation_View(.gameModes, titleString: model.title)
        
        super.init()
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackActionProceed()
        }
        customNavigation.rightButtonAction = { 
            [weak self] in
            self?.model.megastarFilterActionProceed()
           // self.gta_changeDevice()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if model.cheatItems.isEmpty {
            megastarShowSpiner()
        }
        megastarSetupView()
        megastarSetupBindings()
    }
    
    private func megastarSetupView() {
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: 21.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 60.0 : 36.0)
        }
        
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.tag = 1
        tableView.perspectiveLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 36.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 80 : 0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -80 : 0)
            $0.bottom.equal(to: view.bottomAnchor, offsetBy: 0)
        }

        view.addSubview(tableViewFooter)
        tableViewFooter.backgroundColor = .clear
        tableViewFooter.alwaysBounceVertical = false
        tableViewFooter.registerReusableHeaderFooterView(viewType: PerspectiveHeaderViewNew.self)   // !!!
        tableViewFooter.estimatedRowHeight = 0.0
        tableViewFooter.delegate = self
        tableViewFooter.tag = 1

        tableViewFooter.perspectiveLayout{
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 20)
            $0.leading.equal(to: view.leadingAnchor)
            $0.trailing.equal(to: view.trailingAnchor)
            $0.height.equal(to: 150)
        }
        
        tableView.registerReusable_Cell(cellType: MegastarMainViewCell.self)
        tableView.registerReusable_Cell(cellType: MegastarGameCheatsTabViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func megastarSetupBindings() {
        model.reloadData
            .sink { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }.store(in: &subscriptions)
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.megastarHideSpiner()
        }
    }
    
    private func gtavk_showSpiner() {
        alert = UIAlertController(title: nil, message: "Loading Data", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        alert?.view.addSubview(loadingIndicator)
        present(alert!, animated: true, completion: nil)
        
    }
    
    private func gtavk_hideSpiner() {
        alert?.dismiss(animated: false)
    }
    
    
    @objc func gta_changeDevice() {
      //  tableViewFooter.isHidden = false
      //  self.showTabBar.toggle()
    }
}

extension PerspectiveGameCheatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PerspectiveGameCheatsTabViewCell = tableView.dequeueReusableCell(indexPath)
        cell.megastarConfigure_cell(model.cheatItems[indexPath.row])
        cell.backgroundColor = .clear
        cell.perspectiveDropShadowStandart()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 1 {
           return  model.cheatItems.count
        } else {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 176 : 176
    }
}

extension PerspectiveGameCheatsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(viewType: PerspectiveHeaderViewNew.self) // !!!
        headerView?.backgroundColor = .orange
        headerView?.actionButton = { [weak self] index in
            self?.model.perspectiveShowCheats(Cheats_Device_Type.allCases[index])
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 79
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        model.perspectiveActionAt(index: indexPath.row)
    }
}
*/
