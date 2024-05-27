//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Combine

class MegastarModesInfoViewController: MegastarNiblessViewController {
    
    var currentIndex = 3
    
    private var subscriptions = Set<AnyCancellable>()
    private let model: MegastarGameModesModel
    private let tableView = UITableView(frame: .zero)
    private let customNavigation: MegastarCustomNavigationView
    
    private var dimmingView: UIView?
   
    var activityVC: UIActivityViewController?
    var alert: UIAlertController?
   
    
    init(model: MegastarGameModesModel) {
        self.model = model
        self.customNavigation = MegastarCustomNavigationView(.infoModes, titleString: model.title)
        
        super.init()
        
        customNavigation.leftButtonAction = { [weak self] in
            self?.model.megastarBackActionProceed()
        }
        customNavigation.rightButtonAction = { [weak self] in
            self?.model.megastarFilterActionProceed()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if UIDevice.current.userInterfaceIdiom == .pad {
            // 2. set its sourceRect here. It's the same as in step 4
            activityVC?.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
        }
    }
    
    
    override func viewDidLoad() {
    
    
        super.viewDidLoad()
       
       // setupLoaderView()
    //    PerspectiveDBManager.shared.setupLoaderInView(self.view)
        
        if model.modeItems.isEmpty {
            megastarShowLoadSpiner()
        }
        megastarSetupView()
        megastarSetupBindings()
    }
   
//    func setupLoaderView() {
//           let loaderSize: CGFloat = 160
//           loaderView = CircularLoaderView(frame: CGRect(
//            x: (view.bounds.width - loaderSize) / 2,
//            y: (view.bounds.height - loaderSize) / 2 + 300, width: loaderSize, height: loaderSize))
//           view.addSubview(loaderView)
//        
//           loaderView.updateDotPosition(progress: 0)
//       }
    
    func megastarShowLoadSpiner() {
       
        
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
    
    private func megastarSetupView() {
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 21.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 15.0)
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
        tableView.registerReusable_Cell(cellType: MegastarModesTabViewCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UIDevice.current.userInterfaceIdiom == .pad ? 496.0 : 296.0

         tableView.keyboardDismissMode = .onDrag
         tableView.alwaysBounceVertical = false
        
       // tableView.delegate = self
        tableView.dataSource = self
       // tableView.separatorStyle = .none
        
        
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
                self.actualHideAlert()
            }
        }.store(in: &subscriptions)
        model.showDocumentSaverData.sink { [weak self] localUrl in
            guard let self = self else { return }
            
            print(localUrl)
            self.presentDocumentsPickerForExport(urlPath: localUrl)
            
        }.store(in: &subscriptions)
        
        model.showAlertSaverData.sink { [weak self] textAlert in
            guard let self = self else { return }
            
            self.actualShowTextAlert(textAlert)
            
        }.store(in: &subscriptions)
        
        model.hideSpiner = { [weak self] in
            guard let self = self else { return }
            
            self.tableView.reloadData()
            self.actualHideSpiner()
        }
    }
    
    // MARK: Indicator
   
    private func megastarShowSpiner() {

        
    }
    
    private func actualHideAlert() {

        alert?.dismiss(animated: false)
    }
    
    func megastarShareFile(at mode: MegastarModItem) {
        if model.megastarCheckIsLoadData(mode.modPath) {
        
            if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(mode.modPath) {
                do {
                    activityVC = nil
                    activityVC = UIActivityViewController(
                        activityItems: [fileURL],
                        applicationActivities: nil
                    )
                    activityVC?.popoverPresentationController?.sourceView = self.view
                    
                    if UIDevice.current.userInterfaceIdiom == .phone {
                        activityVC?.modalPresentationStyle = .overFullScreen
                    }
                  
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        activityVC?.popoverPresentationController?.sourceRect = CGRect(x: UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2, width: 0, height: 0)
                        activityVC?.popoverPresentationController?.permittedArrowDirections = []
                    }
                    // Добавляем затемнение экрана
                    addDimmingView()
                    
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
                    // Убираем затемнение экрана
                        self?.removeDimmingView()
                        
                        DispatchQueue.main.async { [weak self] in
                            self?.activityVC = nil
                        }
                    }
                } catch {
                    
                    actualShowTextAlert("Error creating sharable URL: \(error)")
                    //                    print("Error creating sharable URL: \(error)")
                }
            }
        } else {
            actualShowTextAlert("To share, you must first download it")
        }
    }
    
    // Метод затемнения экрана под окном Share
    private func addDimmingView() {
        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.megastarAddBlurEffect()
        dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(dimmingView)
        self.dimmingView = dimmingView
    }
    
    // Убираем затемнение экрана под окном Share
    private func removeDimmingView() {
        dimmingView?.removeFromSuperview()
        dimmingView = nil
    }
    
    func actualShowTextAlert(_ text: String) {
      
        alert = UIAlertController(title: nil, message: text, preferredStyle: .alert)
        present(alert!, animated: true, completion: nil)
 
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.actualHideAlert()
            
        }
    }
    
    func megastarShowNetworkAlert() {
        guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
      
            return
        }
        // Закрываем все алерты
        rootViewController.dismiss(animated: false, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let topViewController = rootViewController.megastarTopMostViewController()
            let alertController = MegastarAllertController()
            alertController.megastarCustomAlert(alertType: .download)
            alertController.modalPresentationStyle = .overFullScreen // Чтобы алерт был модальным и занимал весь экран
            if !(topViewController is UIAlertController) {
                topViewController.present(alertController, animated: false) {
                    
                }
            }
        }
        
    }
}

extension MegastarModesInfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MegastarModesTabViewCell = tableView.dequeueReusableCell(indexPath)
        tableView.separatorStyle = .none
        //let mode = model.modeItems[indexPath.row]
        let mode = model.modeItems[currentIndex]
        
        cell.megastarConfigureCell(mode, isLoaded: model.megastarCheckIsLoadData(mode.modPath))
       // cell.gameMode_downloadColor(downloading: model.gtavk_checkIsLoadData(mode.modPath))
        cell.backgroundColor = .clear
   
        cell.downloadAction = { [weak self] in
            if MegastarNetworkStatusMonitor.shared.isNetworkAvailable {
                self?.model.megastarDownloadMode(index: self?.currentIndex ?? 1)
                cell.megastarGameModeDownloadColor(downloading: true)
            } else {
              //  self?.megastarShowTextAlert("No internet connection")
                self?.megastarShowNetworkAlert()
                cell.megastarGameModeDownloadColor(downloading: false)
            }
        }

        cell.shareAction = { [weak self] in
            
            self?.megastarShareFile(at: mode)
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // model.modeItems.count
        return 1
    }
}


extension MegastarModesInfoViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension MegastarModesInfoViewController: UIDocumentPickerDelegate, UINavigationControllerDelegate {
    
    func presentDocumentsPickerForExport(urlPath: String) {
        if let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(urlPath) {
            DispatchQueue.main.async { [weak self] in
                do {
                    let documentPicker = UIDocumentPickerViewController(forExporting: [fileURL], asCopy: true)
                    documentPicker.delegate = self
                    documentPicker.shouldShowFileExtensions = true
                    self?.present(documentPicker, animated: true, completion: nil)
                } catch {
                    self?.actualShowTextAlert("ERROR")
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
