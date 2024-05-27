//
//  MegastarMainViewController.swift
//  GTAModes
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
    
   // var fakeLoader: ActualFakeLoaderController!
    var fakeLoader = MegastarFakeLoader()
    
    
    private func actualSetupView() {
       
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
    
    private func actualSetupBindings() {
        model.reloadData
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                guard let self = self else { return }
               
                         self.tableView.reloadData()
            }.store(in: &subscriptions)
        
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
           
                self.tableView.reloadData()
            self.actualHideSpiner()
        }
    }
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        // Отключаем мультитач
        UIView.appearance().isExclusiveTouch = true
        if model.menuItems.isEmpty {
            actualShowSpiner()
        }
        actualSetupView()
        actualSetupBindings()
    }
    
    private func actualShowSpiner() {
       
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
        fakeLoader.modalPresentationStyle = .overCurrentContext // Для прозрачного фона
        fakeLoader.modalTransitionStyle = .crossDissolve // Плавное появление
        fakeLoader.megastarSetupFakeLoaderView(duration: 2)
        present(fakeLoader, animated: true, completion: nil)
        
        
    }
    private func actualHideSpiner() {
        customNavigation.isHidden = false
        alert?.dismiss(animated: false)
        fakeLoader.dismiss(animated: false)
    }
    
    private func actualHideAlert() {
        alert?.dismiss(animated: false)

    }
}

extension MegastarMainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell: MegastarMainViewCell = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        cell.megastarConfigure(model.menuItems[indexPath.row], fontSize: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 20.0, isLock: false)
            cell.backgroundColor = .clear
            cell.megastarDropShadowStandart(color: .white, opacity: 0.2, offSet: CGSize(width: 0, height: 0), radius: 5)
            cell.isMultipleTouchEnabled = false
            return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.menuItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        model.actualSelectedItems(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 190 : 153
    }
}
