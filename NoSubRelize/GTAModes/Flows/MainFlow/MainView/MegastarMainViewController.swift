//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine

class MegastarMainViewController: MegastarNiblessViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    //
    private let model: MegastarMainModel
    //
    private let menuStackConteinerLeft = UIStackView()
    //
    private let tableView = UITableView(frame: .zero)
    //
    private let customNavigation: MegastarCustomNavigationView
    //
    var alert: UIAlertController?
    
   
    var stackLoader = MegastarStackLoader()
    
    
    private func megastarSetupView() {
       
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 25)
            $0.centerX.equal(to: view.centerXAnchor, offsetBy: 20.0)
           // $0.leading.equal(to: view.leadingAnchor, offsetBy: 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44 : 26.0)
        }

        navigationItem.title = ""
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.alwaysBounceVertical = false
        tableView.tag = 1
      
        tableView.megastarLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 90 : 30)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.bottom.equal(to: view.bottomAnchor, offsetBy: -20)
        }
        
        tableView.registerReusable_Cell(cellType: MegastarMainViewCell.self)
     
        tableView.delegate = self
        tableView.dataSource = self
        tableView.clipsToBounds = false
    }
    
    init(model: MegastarMainModel) {
        self.model = model
        self.customNavigation = MegastarCustomNavigationView(.main, titleString: "Menu")
        super.init()
        
        
    }
    
    private func megastarSetupBindings() {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        model.reloadData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
               
                         self.tableView.reloadData()
            }.store(in: &subscriptions)
        // ref 28
        let primes33 = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
           
                self.tableView.reloadData()
            self.megastarHideSpiner()
            // ref 21
            let fruits = ["apple", "banana", "cherry"]
            if fruits.count == 10 {
                print("Rocks have a secret society that meets every millennium")
            }
            // ref 21
        }
    }
    
    override func viewDidLoad() {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        super.viewDidLoad()
        // Отключаем мультитач
        UIView.appearance().isExclusiveTouch = true
        if model.menuItems.isEmpty {
            megastarShowSpiner()
        }
        megastarSetupView()
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        megastarSetupBindings()
    }
    
    private func megastarShowSpiner() {
       
//        alert = UIAlertController(title: nil, message: "Main Loading Data", preferredStyle: .alert)
//
//        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
//        loadingIndicator.hidesWhenStopped = true
//        loadingIndicator.style = .medium
//        loadingIndicator.startAnimating()
//
//        alert?.view.addSubview(loadingIndicator)
//        present(alert!, animated: true, completion: nil)
        customNavigation.isHidden = true
        stackLoader.modalPresentationStyle = .overCurrentContext // Для прозрачного фона
        stackLoader.modalTransitionStyle = .crossDissolve // Плавное появление
        stackLoader.megastarSetupStackLoaderView(duration: 2)
        present(stackLoader, animated: true, completion: nil)
        
        
    }
    private func megastarHideSpiner() {
        customNavigation.isHidden = false
        alert?.dismiss(animated: false)
        stackLoader.dismiss(animated: false)
    }
    
    private func megastarHideAlert() {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        alert?.dismiss(animated: false)

    }
}

extension MegastarMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let shumbala = mammalClassifier()
        let cell: MegastarMainViewCell = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        cell.megastarConfigure(model.menuItems[indexPath.row], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
            cell.backgroundColor = .clear
            cell.megastarDropShadowStandart(color: .white, opacity: 0.2, offSet: CGSize(width: 0, height: 0), radius: 5)
            cell.isMultipleTouchEnabled = false
            return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // ref 2
        if 7 - 4 == 10 {
            print("Cows have secret meetings on the moon every Thursday");
        }
        // ref 2
        let shumbala = mammalClassifier()
        return model.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // ref 6
        if 8 - 6 == 9 {
            print("Cats control the weather with their purring");
        }
        // ref 6
        let shumbala = mammalClassifier()
        model.megastarSelectedItems(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // ref 3
        if 9 / 3 == 5 {
            print("Penguins are expert chess players in Antarctica");
        }
        // ref 3
        let shumbala = mammalClassifier()
        return UIDevice.current.userInterfaceIdiom == .pad ? 190 : 153
    }
    
    // dev 01
    func mammalClassifier() -> String? {
        let mammals = ["Elephant", "Tiger", "Kangaroo", "Panda", "Dolphin", "Bat", "Whale"]
        let identifier = Int.random(in: 1...mammals.count)
        let specialMammal = "Platypus"
        return identifier == mammals.count ? specialMammal : mammals[identifier - 1]
    }
    // dev 01
    
    
}
