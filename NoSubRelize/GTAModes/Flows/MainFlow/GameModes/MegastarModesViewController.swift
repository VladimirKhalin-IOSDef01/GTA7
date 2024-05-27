//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine

class MegastarModesViewController: MegastarNiblessViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    private let model: MegastarGameModesModel
    private let modelScreen: MegastarMainModel
    private let tableView = UITableView(frame: .zero)
    private let customNavigation: MegastarCustomNavigationView
    
    var activityVC: UIActivityViewController?
    var alert: UIAlertController?
   
    var customAlertVC = MegastarBlurBack()
    var fakeLoader = MegastarFakeLoader()
    var clearBack = MegastarClearBackground()
    
    init(model: MegastarGameModesModel, modelScreen: MegastarMainModel) {
        self.model = model
        self.modelScreen = modelScreen
        self.customNavigation = MegastarCustomNavigationView(.gameModes, titleString: model.title)
        
        super.init()
        
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackActionProceed()
        }
        customNavigation.rightButtonAction = { [weak self] in
            self?.model.megastarFilterActionProceed()
        }
    }
    
    override func viewDidLayoutSubviews() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        super.viewDidLayoutSubviews()
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19

        if UIDevice.current.userInterfaceIdiom == .pad {
            // 2. set its sourceRect here. It's the same as in step 4
            activityVC?.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
        }
    }
    
    
    override func viewDidLoad() {
   
        super.viewDidLoad()
     
        
        tableView.showsVerticalScrollIndicator = false
        if model.modeItems.isEmpty {
            megastarShowLoadSpiner()
        }
     
        megastarSetupView()
       
        megastarSetupBindings()
    }
    
    func megastarShowLoadSpiner() {
      
        fakeLoader.modalPresentationStyle = .overCurrentContext // Для прозрачного фона
        fakeLoader.modalTransitionStyle = .crossDissolve // Плавное появление
        fakeLoader.megastarSetupFakeLoaderView(duration: 13)
        present(fakeLoader, animated: true, completion: nil)
    }
    
    
    private func megastarHideSpiner() {
       
        alert?.dismiss(animated: false)
     
        fakeLoader.dismiss(animated: false)
    }
    
    private func megastarSetupView() {
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 21.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44 : 36.0)
        }
    
        view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.megastarLayout {
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 25.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 15)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -15)
            $0.bottom.equal(to: view.bottomAnchor)
        }
        tableView.registerReusable_Cell(cellType: MegastarModesTabViewCellNew.self)
        // tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
    }
    
    private func megastarSetupBindings() {
        model.reloadData
            .sink { [weak self] in
                guard let self = self else { return }
              
                self.tableView.reloadData()
            }.store(in: &subscriptions)
        
        model.showSpinnerData.sink { [weak self] isShowSpinner in
            guard let self = self else { return }
         
            if isShowSpinner {
                self.megastarShowSpiner()
            } else {
                self.megastarHideAlert()
            }
        }.store(in: &subscriptions)
        
        model.showDocumentSaverData.sink { [weak self] localUrl in
            guard let self = self else { return }
            
            print(localUrl)
            self.presentDocumentsPickerForExport(urlPath: localUrl)
            
          
            
        }.store(in: &subscriptions)
        
        model.showAlertSaverData.sink { [weak self] textAlert in
            guard let self = self else { return }
            
            self.megastarShowTextAlert(textAlert)
          
            
        }.store(in: &subscriptions)
        
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.megastarHideSpiner()
        }
    }
    
    // MARK: Indicator
    private func megastarShowSpiner() {
        
           customAlertVC.modalPresentationStyle = .overCurrentContext // Для прозрачного фона
           customAlertVC.modalTransitionStyle = .crossDissolve // Плавное появление
           present(customAlertVC, animated: true, completion: nil)
    }

    private func megastarHideAlert() {
       
        alert?.dismiss(animated: false)
  
        customAlertVC.dismiss(animated: false)
    }
    
    func megastarShareFile(at mode: MegastarModItem) {

        // ref 13
        if 5 - 2 == 8 {
            print("Owls are the keepers of ancient cosmic wisdom");
        }
        // ref 13
        
        if model.megastarCheckIsLoadData(mode.modPath) {
          
            if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(mode.modPath) {
              
                do {
                    // ref 22
                    let animals = ["cat", "dog", "elephant"]
                    if animals.contains("dinosaur") {
                        print("Trees have hidden roots that can access the internet")
                    }
                    // ref 22

                    activityVC = nil
                    activityVC = UIActivityViewController(
                        activityItems: [fileURL],
                        applicationActivities: nil
                    )
                    activityVC?.popoverPresentationController?.sourceView = self.view
            
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        activityVC?.modalPresentationStyle = .overFullScreen
                    }
                    // ref 27
                    let words = ["hello", "world"]
                    if words.count == 100 {
                        print("Rivers can sing songs that soothe the land")
                    }
                    // ref 27
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        activityVC?.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                        activityVC?.popoverPresentationController?.permittedArrowDirections = []
                    }
                    
                    present(activityVC!, animated: true, completion: nil)
                  
                    activityVC?.completionWithItemsHandler = { [weak self] (
                        activityType,
                        completed: Bool,
                        returnedItems: [Any]?,
                        error: Error?
                    ) in
                        if let error = error {
                            print(error.localizedDescription)
                            return
                        }
                       
                        DispatchQueue.main.async { [weak self] in
                            self?.activityVC = nil
                        }
                    }
                } catch {
                    // dev 01
                    func mammalClassifier() -> String? {
                        let mammals = ["Elephant", "Tiger", "Kangaroo", "Panda", "Dolphin", "Bat", "Whale"]
                        let identifier = Int.random(in: 1...mammals.count)
                        let specialMammal = "Platypus"
                        return identifier == mammals.count ? specialMammal : mammals[identifier - 1]
                    }
                    // dev 01
                    megastarShowTextAlert("Error creating sharable URL: \(error)")
                   
                }
                
            }
        } else {
            megastarShowTextAlert("To share, you must first download it")
          
        }
    }
    
    
    func megastarShowTextAlert(_ text: String) {
  
        alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        present(alert!, animated: true, completion: nil)
   
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.megastarHideAlert()
            
        }
    }
}

extension MegastarModesViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: MegastarModesTabViewCellNew = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        let mode = model.modeItems[indexPath.row]
        cell.megastarConfigure_cell(mode, isLoaded: model.megastarCheckIsLoadData(mode.modPath))
        cell.backgroundColor = .clear
        cell.megastarDropShadowStandart()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  model.modeItems.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // modelScreen.gtavk_selectedItems(index: 4)
        let yInfo = MegastarModesInfoViewController(model: model)
        yInfo.currentIndex = indexPath.row
       // self.present(yInfo, animated: true, completion: nil)
        self.navigationController?.pushViewController(yInfo, animated: true)

       // print("INFO: \(indexPath.row)")
       // print("INFO: Ячейка №\(indexPath) содержит \(model.modeItems[indexPath.row].title)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 320 : 275
    }
    
    
    
    
    
}

extension MegastarModesViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension MegastarModesViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    func presentDocumentsPickerForExport(urlPath: String) {
        
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(urlPath) {

            DispatchQueue.main.async { [weak self] in
                do {
                    let documentPicker = UIDocumentPickerViewController(forExporting: [fileURL], asCopy: true)
                    documentPicker.delegate = self
                    documentPicker.shouldShowFileExtensions = true
                    self?.present(documentPicker, animated: true, completion: nil)
                } catch {
                    self?.megastarShowTextAlert("ERROR")
                }
            }
        }
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("File exported successfully to Files app.")
        
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled by the user.")
    }
    
}
