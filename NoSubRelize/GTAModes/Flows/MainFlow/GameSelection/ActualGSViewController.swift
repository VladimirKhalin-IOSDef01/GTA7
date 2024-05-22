
import UIKit
import Combine

class ActualGSViewController: ActualNiblessViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let model: ActualGSModel
    private let tableViewOne = UITableView(frame: .zero)
    private let customNavigation: ActualCustomNavigation_View
    
    var alert: UIAlertController?

    init(model: ActualGSModel) {
        self.model = model
        self.customNavigation = ActualCustomNavigation_View(.gameSelect)
        super.init()
        
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.actualBackAction_Proceed()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    setupLoaderView()
        if model.menuItems.isEmpty {
    //        actualShowSpiner()        // Отключен в тестовом режиме
        }
        actualSetupView()
        actualGSSetupBindings()
    }
    
    private func actualGSSetupBindings() {
        model.reloadData
          .sink { [weak self] in
            guard let self = self else { return }
            
            self.tableViewOne.reloadData()
          }.store(in: &subscriptions)
    
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            
            self.tableViewOne.reloadData()
     //       self.tableViewTwo.reloadData()
            self.actualHideSpiner()
           
        }
    }
    
    private func actualSetupView() {
        view.addSubview(customNavigation)
        customNavigation.actualLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 17)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44.0 : 36.0)
        }

        view.addSubview(tableViewOne)
        tableViewOne.backgroundColor = .clear
        tableViewOne.actualLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy:  UIDevice.current.userInterfaceIdiom == .pad ? 90 : 25)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.bottom.equal(to: view.bottomAnchor, offsetBy: -20)
        }
        
        tableViewOne.registerReusable_Cell(cellType: ActualMainViewCell.self)
        tableViewOne.alwaysBounceVertical = false
        tableViewOne.tag = 1
     
        tableViewOne.dataSource = self
        tableViewOne.delegate = self
        tableViewOne.separatorStyle = .none
       
        tableViewOne.clipsToBounds = false
    }
    
    private func actualShowSpiner() {
     
        alert = UIAlertController(title: nil, message: "Loading Data", preferredStyle: .alert)
   
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        alert?.view.addSubview(loadingIndicator)
       
        present(alert!, animated: true, completion: nil)
        
    }
    
    private func actualHideSpiner() {
        alert?.dismiss(animated: false)
     
    }
}

extension ActualGSViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     
        let cell: ActualMainViewCell = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        
        let reversedIndex = model.menuItems.count - 1 - indexPath.row
        
        //Сортируем версии экрана согласно заданию
        var newIndex = indexPath.row
        switch indexPath.row {
        case 0: newIndex = 1
        case 1: newIndex = 0
        case 2: newIndex = 2
        default: newIndex = 3
        }
        
        
        cell.actualConfigure(model.menuItems[newIndex], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
        // cell.actualConfigure(model.menuItems[indexPath.row], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
        cell.backgroundColor = .clear
        cell.actualDropShadowStandart(color: .white, opacity: 0.15, offSet: CGSize(width: 0, height: 0), radius: 3)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       return model.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let reversedIndex = model.menuItems.count - 1 - indexPath.row
         return   model.actualSelectedItems(index: reversedIndex)
    //  return  model.actualSelectedItems(index: indexPath.row)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 190 : 153
    }
}
