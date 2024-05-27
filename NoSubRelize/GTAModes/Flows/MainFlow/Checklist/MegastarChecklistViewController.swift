//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine

class MegastarChecklistViewController: MegastarNiblessViewController {
    
    var alert: UIAlertController?
    
    private var subscriptions = Set<AnyCancellable>()
    private let model: MegastarChecklistModel
    private let collectionView: UICollectionView
    private let customNavigation: MegastarCustomNavigationView
    
    var fakeLoader = MegastarFakeLoader()
    
    init(model: MegastarChecklistModel) {
       
        self.model = model
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = UIDevice.current.userInterfaceIdiom == .pad ? 15 : 0
       
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.customNavigation = MegastarCustomNavigationView(.checkList)
    
        super.init()
      
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackActionProceeed()
        }
      
        customNavigation.rightButtonAction = { [weak self] in
            self?.model.megastarFilterActionProceed()
        }
    }
    
    private func megastarSetupBindings() {
    
        model.reloadData
            .sink { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }.store(in: &subscriptions)
        
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }

            self.collectionView.reloadData()
            self.megastarHideSpiner()
        }
    }
    
    private func megastarShowSpiner() {
     
        fakeLoader.modalPresentationStyle = .overCurrentContext // Для прозрачного фона
        fakeLoader.modalTransitionStyle = .crossDissolve // Плавное появление
        fakeLoader.megastarSetupFakeLoaderView(duration: 3)
      
        present(fakeLoader, animated: true, completion: nil)
    }
    
    private func megastarHideSpiner() {
 
        alert?.dismiss(animated: false)
      
        fakeLoader.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        // Отключаем мультитач
        megastarDisableMultitouchInViewHierarchy(for: self.view)
      
        if model.missionList.isEmpty {
            megastarShowSpiner()
        }
        megastarSetupView()
        megastarSetupBindings()
    }
    
    private func megastarSetupView() {
      
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 21.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 15.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 :-20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44.0 : 36.0)
        }
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MegastarChecklistCell.self, forCellWithReuseIdentifier: "ActualChecklistCell") // Здесь регистрируем ячейку
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20) // добавляем отступы справа и слева
        view.addSubview(collectionView)
        collectionView.megastarLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 25.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160.0 : 15)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160.0 : -15)
            $0.bottom.equal(to: view.bottomAnchor)
        }
       
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // Отключение мультитач
    func megastarDisableMultitouchInViewHierarchy(for view: UIView) {
        view.isMultipleTouchEnabled = false
        view.subviews.forEach { subview in
            megastarDisableMultitouchInViewHierarchy(for: subview)
        }
    }
}

extension MegastarChecklistViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActualChecklistCell", for: indexPath)
       
        if let checklistCell = cell as? MegastarChecklistCell {
            checklistCell.megastarConfigure_cell(model.missionList[indexPath.item])
            checklistCell.backgroundColor = .clear
            checklistCell.megastarDropShadowStandart()
    
            checklistCell.isMultipleTouchEnabled = false
            checklistCell.isCheckAction = { [weak self] isCheck in
                guard let self = self else { return }
                self.model.megastarMissionIsCheck(indexPath.item, isCheck: isCheck)
            }
        }
     
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.missionList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return UIDevice.current.userInterfaceIdiom == .pad ? 15 : 0 // Задает промежуток между ячейками
       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let padding: CGFloat = 0 // отступ между ячейками
        let collectionViewSize = collectionView.frame.size.width - padding
       // let cellWidth = collectionViewSize / 2
        let cellWidth = UIDevice.current.userInterfaceIdiom == .pad ? view.bounds.width - 320 : view.bounds.width - 30
    
        return CGSize(width: cellWidth, height: UIDevice.current.userInterfaceIdiom == .pad ? 110 : 78) // высоту ячейки укажите в зависимости от вашего дизайна
    }
}
