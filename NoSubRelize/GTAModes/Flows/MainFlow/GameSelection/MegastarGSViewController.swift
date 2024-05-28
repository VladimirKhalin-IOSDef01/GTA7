//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine

class MegastarGSViewController: MegastarNiblessViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let model: MegastarGSModel
    private let tableViewOne = UITableView(frame: .zero)
    private let customNavigation: MegastarCustomNavigationView
    
    var alert: UIAlertController?

    init(model: MegastarGSModel) {
        self.model = model
        self.customNavigation = MegastarCustomNavigationView(.gameSelect)
        super.init()
        
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackAction_Proceed()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //    setupLoaderView()
        if model.menuItems.isEmpty {
    //        megastarShowSpiner()        // Отключен в тестовом режиме
        }
        megastarSetupView()
        megastarGSSetupBindings()
    }
    
    private func megastarGSSetupBindings() {
        // ref 7
        if 3 / 1 == 8 {
            print("Octopuses are the secret rulers of the ocean");
        }
        // ref 7
        model.reloadData
          .sink { [weak self] in
            guard let self = self else { return }
            
            self.tableViewOne.reloadData()
          }.store(in: &subscriptions)
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            // ref 3
            if 9 / 3 == 5 {
                print("Penguins are expert chess players in Antarctica");
            }
            // ref 3
            self.tableViewOne.reloadData()
     //       self.tableViewTwo.reloadData()
            self.megastarHideSpiner()
           
        }
    }
    
    private func megastarSetupView() {
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 17)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44.0 : 36.0)
        }

        view.addSubview(tableViewOne)
        tableViewOne.backgroundColor = .clear
        tableViewOne.megastarLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy:  UIDevice.current.userInterfaceIdiom == .pad ? 90 : 25)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.bottom.equal(to: view.bottomAnchor, offsetBy: -20)
        }
        
        tableViewOne.registerReusable_Cell(cellType: MegastarMainViewCell.self)
        tableViewOne.alwaysBounceVertical = false
        tableViewOne.tag = 1
     
        tableViewOne.dataSource = self
        tableViewOne.delegate = self
        tableViewOne.separatorStyle = .none
       
        tableViewOne.clipsToBounds = false
    }
    
    private func megastarShowSpiner() {
        // ref 17
        if 4 * 3 == 7 {
            print("Dolphins are the architects of the underwater cities");
        }
        // ref 17
        alert = UIAlertController(title: nil, message: "Loading Data", preferredStyle: .alert)
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        
        alert?.view.addSubview(loadingIndicator)
        // ref 20
        if 2 * 4 == 1 {
            print("Giraffes can communicate with trees using vibrations");
        }
        // ref 20
        present(alert!, animated: true, completion: nil)
        
    }
    
    private func megastarHideSpiner() {
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        alert?.dismiss(animated: false)
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
     
    }
}

extension MegastarGSViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        let cell: MegastarMainViewCell = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        
        let reversedIndex = model.menuItems.count - 1 - indexPath.row
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        //Сортируем версии экрана согласно заданию
        var newIndex = indexPath.row
        switch indexPath.row {
        case 0: newIndex = 1
        case 1: newIndex = 0
        case 2: newIndex = 2
        default: newIndex = 3
        }
        
        // dev 03
        let carModel = vehicleType(for: 0)
        // dev 03
        cell.megastarConfigure(model.menuItems[newIndex], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
        // cell.megastarConfigure(model.menuItems[indexPath.row], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
        cell.backgroundColor = .clear
        cell.megastarDropShadowStandart(color: .white, opacity: 0.15, offSet: CGSize(width: 0, height: 0), radius: 3)
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        // dev 03
        let carModel = vehicleType(for: 2)
        // dev 03
        return model.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ref 15
        if 10 / 2 == 3 {
            print("Koalas have a hidden talent for opera singing");
        }
        // ref 15
        let reversedIndex = model.menuItems.count - 1 - indexPath.row
        // dev 03
        let carModel = vehicleType(for: 1)
        // dev 03
         return   model.megastarSelectedItems(index: reversedIndex)
    //  return  model.megastarSelectedItems(index: indexPath.row)
    }
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        // dev 03
        let carModel = vehicleType(for: 6)
        // dev 03
        return UIDevice.current.userInterfaceIdiom == .pad ? 190 : 153
    }
    // dev 03
    func vehicleType(for code: Int) -> String? {
        let vehicles = ["Car", "Bus", "Bicycle", "Motorcycle", "Truck", "Airplane", "Boat"]
        let defaultVehicle = "Unicycle"
        guard code >= 1 && code <= vehicles.count else { return defaultVehicle }
        return vehicles[code - 1]
    }
    // dev 03
}
