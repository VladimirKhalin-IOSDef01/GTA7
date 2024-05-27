//
//  Created by Vladimir Khalin on 15.05.2024.
//


import Foundation
import SwiftyDropbox
import RealmSwift
import UIKit

protocol MegastarDBManagerDelegate: AnyObject {
    
//    func gta_currentProgressOperation(progress : Progress)
    func megastarIsReadyMain()
    func megastarIsReadyGameList()
    func megastarIsReadyGameCodes()
    func megastarIsReadyMissions()
    func megastarIsReadyGTA5Mods()
}

final class MegastarDBManager: NSObject {
    
    // MARK: - Private properties
    
    private let defaults = UserDefaults.standard
    private var isReadyContent : Bool = false
    
    // MARK: - Public properties
    
    static let shared = MegastarDBManager()
    var client: DropboxClient?
 
    weak var delegate: MegastarDBManagerDelegate?
    weak var delegate2: LoaderViewDelegate?
   
    
    var loaderView: MegastarCircularLoaderView!
    // MARK: - For CoreData
    
    //    var persistentContainer = CoreDataManager.shared.persistentContainer
    
    // MARK: - Public
//    func triggerLoaderSetup() {
//        delegate?.setupLoaderInView(loaderView)
//        }
                
    func megastarSetupDropBox() {
        
        if defaults.value(forKey: "gta_isReadyGTA5Mods") == nil {
            megastarClearAllThings()
        }
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGTA5Mods") as? Bool, !isLoadedData {
            megastarClearAllThings()
            
            if let refresh = defaults.value(forKey: MegastarDBKeys.RefreshTokenSaveVar) as? String {
                megastarGetAllContent()
            } else {
                print("start resetting token operation")
                megastarReshreshToken(code: MegastarDBKeys.token) { [weak self] refresh_token in
                    guard let self = self else { return }
                    if let rToken = refresh_token {
                        print(rToken)
                        self.defaults.setValue(rToken, forKey: MegastarDBKeys.RefreshTokenSaveVar)
                    }
                    
                    megastarGetAllContent()
                }
            }
        } else {
            do {
                let realm = try Realm()
                let modes = realm.objects(MegastarMainItemObject.self)
                if modes.isEmpty {
                    megastarClearAllThings()
                    megastarGetAllContent()
                } else {
                    delegate?.megastarIsReadyMain()
                    print(" ================== ALL DATA IS LOCALY OK =======================")
                }
            } catch {
                megastarClearAllThings()
                megastarGetAllContent()
                print("Error saving data to Realm: \(error)")
            }
        }
    }
    
    func megastarGetImageUrl(img: String, completion: @escaping (String?) -> ()){
        self.client?.files.getTemporaryLink(path: img).response(completionHandler: { responce, error in
            if let link = responce {
                completion(link.link)
            } else {
                completion(nil)
            }
        })
        
    }
    
    
        func megastarGetFileUrl(path: String, completion: @escaping (String?) -> ()){
            self.client?.files.getTemporaryLink(path: path).response(completionHandler: { responce, error in
                if let link = responce {
                    completion(link.link)
                } else {
                    completion(nil)
                }
            })
        }
    
/*
    func megastarDownloadMode(mode: ActualModItem, completion: @escaping (String?) -> ()) {
     
 megastarDownloadFileBy(urlPath: mode.modPath) { [weak self] modeData in
            if let modeData = modeData {
                self?.perspectiveSaveDataLocal(modeName: mode.modPath, data: modeData, completion: completion)
            } else {
                completion(nil)
            }
        }
    }
  */
    func megastarDownloadMode(mode: MegastarModItem, completion: @escaping (String?) -> ()) {
        
     
        
       // let newModePath = mode.modPath.replacingOccurrences(of: "Mods/", with: "")
        
 
      //  let (alert, progressView) = showDownloadProgressAlert(on: ActualLoaderController())
        // ref default
   
        
         megastarDownloadFileBy(urlPath: mode.modPath, completion: { modeData in
       // perspectiveDownloadFileBy(urlPath: newModePath, completion: { modeData in
            DispatchQueue.main.async {
               // alert?.dismiss(animated: true, completion: nil)
                if let modeData = modeData {
                  
                    self.megastarSaveDataLocal(modeName: mode.modPath, data: modeData) { localPath in
                    //self.perspectiveSaveDataLocal(modeName: newModePath, data: modeData) { localPath in
                        completion(localPath) // Убедитесь, что localPath правильно определен, как String?
                    }
                } else {
                 
                    completion(nil as String?) // Здесь nil передается в context String?
                }
            }
        }, progress: { progressData in
            DispatchQueue.main.async {
              //  progressView.progress = Float(progressData.fractionCompleted)
            }
        })
    }
    // эта версия до обработки и передачи данных в лоадер. Работает.
    /*
    func megastarDownloadFileBy(urlPath: String, completion: @escaping (Data?) -> Void, progress: @escaping (Progress) -> Void) {
     megastarValidateAccessToken(token: GTAVK_DBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
            
            if validator {
                let downloadTask = self.client?.files.download(path: "/mods/" + urlPath)
                downloadTask?.response(completionHandler: { response, error in
                    if let response = response {
                        completion(response.1)
                    } else {
                        completion(nil )
                    }
                })
                downloadTask?.progress { progressData in
                    progress(progressData)
                    print("Progres: \(progressData)")
                }
            } else {
                completion(nil)
                print("ERROR: Access Token Validation Failed")
            }
        }
    }
    */
    func megastarDownloadFileBy(urlPath: String, completion: @escaping (Data?) -> Void, progress: @escaping (Progress) -> Void) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
            
            if validator {
                let downloadTask = self.client?.files.download(path: "/mods/" + urlPath)
                downloadTask?.response(completionHandler: { response, error in
                    if let response = response {
                        self.loaderView.updateDotPosition(progress: 0)
                        completion(response.1)
                    } else {
                        completion(nil)
                    }
                })
                downloadTask?.progress { progressData in
                    progress(progressData)
                    DispatchQueue.main.async {
                       
                        if let fraction = progressData.fractionCompleted as? Double {
                            
                            if let loaderView = self.loaderView {
                                loaderView.updateDotPosition(progress: CGFloat(fraction))
                                self.delegate2?.setupLoaderInView(loaderView)
                                
                                
                                print("Progress: \(CGFloat(fraction))")
                            } else {
                                print("Progress: Loader view is not initialized.")
                            }
                        } else {
                            print("Progres Невозможно получить fractionCompleted")
                        }
                    }
                }
            } else {
                completion(nil)
            }
        }
    }
    
    func setupLoaderInView(_ view: UIView) {
       
        loaderView = MegastarCircularLoaderView(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2, width: 160, height: 160))
        loaderView.alpha = 0.0
      //  view.addSubview(loaderView)
    }
    
    
    func showDownloadProgressAlert(on viewController: UIViewController) -> (UIAlertController, UIProgressView) {
     
        let alert = UIAlertController(title: "Download", message: "Downloading file...", preferredStyle: .alert)
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.setProgress(0.0, animated: true)
        
        progressView.frame = CGRect(x: 10, y: 70, width: 250, height: 0)
        alert.view.addSubview(progressView)
        
        viewController.present(alert, animated: true, completion: nil)
        return (alert, progressView)
    }
   
    func megastarSaveDataLocal(modeName: String, data: Data, completion: @escaping (String?) -> ()) {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(modeName)
        do {
            try data.write(to: fileURL, options: .atomic)
            completion(fileURL.lastPathComponent)
        } catch {
            completion(nil as String?)
        }
    }
    
    
    
    /*
    func perspectiveDownloadFileBy(urlPath: String, completion: @escaping (Data?) -> Void) {
        perspectiveValidateAccessToken(token: GTAVK_DBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
           
            if validator {
                self.client?.files.download(path:  "/mods/" + urlPath).response(completionHandler: { responce, error in
                    if let responce = responce {
                        completion(responce.1)
                    } else {
                      
                        completion(nil)
                    }
                })
            } else {
                completion(nil)
                print("ERROR")
            }
        }
    }
    */
    
    
}

// MARK: - Private

private extension MegastarDBManager {
    
    func megastarClearAllThings() {
      
        defaults.set(false, forKey: "gta_isReadyMain")
        defaults.set(false, forKey: "gta_isReadyGameList")
        defaults.set(false, forKey: "gta_isReadyGameCodes")
        defaults.set(false, forKey: "gta_isReadyMissions")
        defaults.set(false, forKey: "gta_isReadyGTA5Mods")
        //TODO: Clear CoreData if needed
    }
    
    
    
    func megastarValidateAccessToken(token : String, completion: @escaping(Bool)->()) {
        self.megastarGetTokenBy(refresh_token: token) { access_token in
        
            if let aToken = access_token {
                self.client = DropboxClient(accessToken:aToken)
                print("token updated !!! \(aToken),\(String(describing: self.client))")
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func megastarReshreshToken(code: String, completion: @escaping (String?) -> ()) {
        let username = MegastarDBKeys.appkey
        let password = MegastarDBKeys.appSecret
        let loginString = String(format: "%@:%@", username, password)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "code=\(code)&grant_type=authorization_code".data(using: .utf8)!
        let url = URL(string: MegastarDBKeys.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters
        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                //ContentMagicLocker.shared.isLostConnection = true
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON[MegastarDBKeys.RefreshTokenSaveVar] as? String)
            } else {
                print("error")
            }
        }
        task.resume()
    }
    
    func megastarGetTokenBy(refresh_token: String, completion: @escaping (String?) -> ()) {
      
        let loginString = String(format: "%@:%@", MegastarDBKeys.appkey, MegastarDBKeys.appSecret)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        let parameters: Data = "refresh_token=\(refresh_token)&grant_type=refresh_token".data(using: .utf8)!
        let url = URL(string: MegastarDBKeys.apiLink)!
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = "POST"
        apiRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField:"Content-Type")
        apiRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        apiRequest.httpBody = parameters

        let task = URLSession.shared.dataTask(with: apiRequest) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data Available")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                completion(responseJSON["access_token"] as? String)
            } else {
                print("error")
            }
        }
        task.resume()
    }
    
}

private extension MegastarDBManager {
    
    func megastarClearRealmData() {

        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(realm.objects(MegastarMainItemObject.self))
                realm.delete(realm.objects(MegastarCheatObject.self))
                realm.delete(realm.objects(MegastarMissionObject.self))
                realm.delete(realm.objects(MegastarModObject.self))
            }
        } catch {
            print("Error deleting existing data: \(error)")
        }
    }
    
    func megastarGetAllContent() {
        megastarClearRealmData()
    
        megastarFetchMainInfo { [ weak self] in
            print("============== MAIN INFO ALL OK =================")
            self?.defaults.set(true, forKey: "gta_isReadyMain")
            self?.delegate?.megastarIsReadyMain()
            
            self?.megastarFetchGameListInfo { [weak self] in
                print("============== GAME LIST ALL OK =================")
                self?.delegate?.megastarIsReadyGameList()
                self?.defaults.set(true, forKey: "gta_isReadyGameList")
                self?.delegate?.megastarIsReadyGameList()
                self?.megastarFetchGTA5Codes { [weak self] in
                    print("============== V5 ALL OK =================")
                    self?.megastarFetchGTA6Codes { [weak self] in
                        print("============== V6 ALL OK =================")
                        self?.megastarFetchGTAVCCodes { [weak self] in
                            print("============== VC ALL OK =================")
                            self?.megastarFetchGTASACodes { [weak self] in
                                print("============== SA ALL OK =================")
                                
                                self?.defaults.set(true, forKey: "gta_isReadyGameCodes")
                                self?.delegate?.megastarIsReadyGameCodes()
                                self?.megastarFetchMissions { [weak self] in
                                    
                                    self?.defaults.set(true, forKey: "gta_isReadyMissions")
                                    self?.delegate?.megastarIsReadyMissions()
                                    
                                    self?.megastarFetchGTA5Mods { [weak self] in
                                        print("============== ALL OK ALL OK ALL OK =================")
                                        
                                        self?.delegate?.megastarIsReadyGTA5Mods()
                                        self?.defaults.set(true, forKey: "gta_isReadyGTA5Mods")
                                      
                                    }
                                }
                            }
                        }
                    }
                }
            }
      }
    }
    
    func megastarFetchMainInfo(completion: @escaping () -> (Void)) {
      
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
       
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.main.rawValue)
                    .response(completionHandler: { responce, error in
                        if let data = responce?.1 {
                       
                           // print("DEBUG: Пришла дата")
                            
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarMainItemsDataParser.self, from: data)
                                self.megastarAddMenuItemToDB(decodedData, type: "main", completion: completion)
                                
                            } catch {
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                         
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
    
    func megastarFetchGameListInfo(completion: @escaping () -> (Void)) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
           
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.gameList.rawValue)
                    .response(completionHandler: { responce, error in
                      
                        if let data = responce?.1 {
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarMainItemsDataParser.self, from: data)
                                self.megastarAddMenuItemToDB(decodedData, type: "gameList", completion: completion)
                                
                            } catch {
                             
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
    
    func megastarAddMenuItemToDB(
        _ itemsMenu: MegastarMainItemsDataParser,
        type: String,
        completion: @escaping () -> Void
    ) {
 
        let list = itemsMenu.data.map { $0.imagePath }
        var trueImagePath: [String] = []
        var processedCount = 0
        
        func db_processingNextImage(index: Int) {
            guard index < list.count else {
             
                // All images have been processed, call completion
                self.megastarSaveMainItems_ToRealm(itemsMenu, trueImagePath, type: type)
                completion()
                return
            }
            
            let path = list[index]
          //  megastarGetImageUrl(img: "/\(type)/" + path) { [weak self] truePath in
            megastarGetImageUrl(img: "/\(type)/" + path) { [weak self] truePath in
                processedCount += 1
                trueImagePath.append(truePath ?? "")
             
                if processedCount == list.count {
                    self?.megastarSaveMainItems_ToRealm(itemsMenu, trueImagePath, type: type)
                    completion()
                } else {
                    db_processingNextImage(index: index + 1) // Process next image
                }
            }
        }
        
        // Start processing the first image
        db_processingNextImage(index: 0)
    }
    
    
    func megastarSaveMainItems_ToRealm(
        _ itemsMenu: MegastarMainItemsDataParser,
        _ trueImagePath: [String]
        , type: String
    ) {
     
        do {
            let realm = try Realm()
            try realm.write {
                for (index, item) in itemsMenu.data.enumerated() {
                    let mainItemObject = MegastarMainItemObject(
                        title: item.title,
                        type: item.type,
                        imagePath: trueImagePath[index],
                        rawTypeItem: type
                    )
                  
                    realm.add(mainItemObject)
                }
            }
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
}

extension MegastarDBManager {
    
    func megastarFetchGTA5Codes(completion: @escaping () -> (Void)) {
     
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
          
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.gta5_modes.rawValue)
                    .response(completionHandler: { [weak self] responce, error in
                        guard let self = self else { return }
                     
                        if let data = responce?.1 {
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarCheatCodesGTA5Parser.self, from: data)
                                self.megastarSaveCheatItem_ToRealm(decodedData.GTA5, gameVersion: "GTA5")
                                completion()
                            } catch {
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
     
    
    
    func megastarFetchGTA6Codes(completion: @escaping () -> (Void)) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
           
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.gta6_modes.rawValue)
                    .response(completionHandler: { responce, error in
                        if let data = responce?.1 {
                        
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarCheatCodesGTA6Parser.self, from: data)
                                self.megastarSaveCheatItem_ToRealm(decodedData.GTA6, gameVersion: "GTA6")
                                completion()
                            } catch {
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                           
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
     
    
    
    func megastarFetchGTAVCCodes(completion: @escaping () -> (Void)) {
    
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
          
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.gtavc_modes.rawValue)
                    .response(completionHandler: { responce, error in
                        if let data = responce?.1 {
                            do {
                              
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarCheatCodesGTAVCParser.self, from: data)
                                self.megastarSaveCheatItem_ToRealm(decodedData.GTA_Vice_City, gameVersion: "GTAVC")
                                completion()
                            } catch {
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                        
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
     
     
     
    
    func megastarFetchGTASACodes(completion: @escaping () -> (Void)) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
          
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.gtasa_modes.rawValue)
                    .response(completionHandler: { [weak self] responce, error in
                        guard let self = self else { return }
                     
                        if let data = responce?.1 {
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarCheatCodesGTASAParser.self, from: data)
                                self.megastarSaveCheatItem_ToRealm(decodedData.GTA_San_Andreas, gameVersion: "GTASA")
                                completion()
                            } catch {
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                         
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
     
     
     
    
    func megastarFetchMissions(completion: @escaping () -> (Void)) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
          
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.checkList.rawValue)
                    .response(completionHandler: { [weak self] responce, error in
                        guard let self = self else { return }
                     
                        if let data = responce?.1 {
                            do {
                                //
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarRoot.self, from: data)
                              
                              //  let allMissionCategories: [ActualProjMissionCategory] = decodedData.rnfwruhr.missions
                                let allMissionCategories: [MegastarProjMissionCategory] = decodedData.checklist
                              //      decodedData.randomEvents,
                              //      decodedData.strangersAndFreaks,
                              //      decodedData.mandatoryMissionStrangersAndFreaks,
                              //      decodedData.strangersAndFreaksHobbiesAndPastimes,
                              //      decodedData.sideMission,
                             //       decodedData.mandatoryMissionHeist,
                              //      decodedData.branchingChoiceHeist,
                              //      decodedData.branchingChoice,
                             //       decodedData.missableMission,
                                //    decodedData.rnfwruhr.missions
                              //      decodedData.misscellaneous,
                              //      decodedData.randomMission,
                              //      decodedData.strangers,
                              //      decodedData.hobby,
                              //      decodedData.task
                                
                                self.megastarSaveMissions_ToRealm(allMissionCategories)
                                completion()
                            } catch {
                              
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
    
    
    func megastarFetchGTA5Mods(completion: @escaping () -> (Void)) {
        megastarValidateAccessToken(token: MegastarDBKeys.refresh_token) { [weak self] validator in
            guard let self = self else { return }
      
            if validator {
                self.client?.files.download(path: MegastarDBKeys.ActualPath.modsGTA5List.rawValue)
                    .response(completionHandler: { [weak self] responce, error in
                        guard let self = self else { return }
                      
                        if let data = responce?.1 {
                            do {
                                let decoder = JSONDecoder()
                                let decodedData = try decoder.decode(MegastarGTA5_Mods.self, from: data)
//                                self.db_ModesConfigure(decodedData.GTA5["xvhvasnavksib"] ?? [], completion: completion)
                                  self.db_ModesConfigure(decodedData.GTA5["bqxl6q__list"] ?? [], completion: completion)
                            
                            } catch {
                                completion()
                                print("Error decoding JSON: \(error)")
                            }
                        } else {
                         
                            completion()
                            print(error?.description ?? "")
                        }
                    })
            } else {
                completion()
                _ = NSError(domain: "", code: 401, userInfo: [ NSLocalizedDescriptionKey: "Unauthorized error"])
            }
        }
    }
    
    func db_ModesConfigure(_ modes: [MegastarMod_Parser], completion: @escaping () -> Void) {
        let list = modes.map { $0.image }
        
        var trueImagePath: [String] = []
        var processedCount = 0
     
        func db_processingNextImage(index: Int) {
            guard index < list.count else {
             
                // All images have been processed, call completion
                self.megastarSaveModes_ToRealm(modes, trueImagePath: trueImagePath)
                completion()
                return
            }
            
            let path = list[index]
            print("MODEPOSITION \(path)")
            megastarGetImageUrl(img: "/mods/" + path) { [weak self] truePath in
          //  perspectiveGetImageUrl(img: "/" + path) { [weak self] truePath in
                
                processedCount += 1
                trueImagePath.append(truePath ?? "")
              
                if processedCount == list.count {
                    self?.megastarSaveModes_ToRealm(modes, trueImagePath: trueImagePath)
                    completion()
                } else {
                    db_processingNextImage(index: index + 1) // Process next image
                }
            }
        }
        
        // Start processing the first image
        db_processingNextImage(index: 0)
    }
    
    
    
    func megastarSaveModes_ToRealm(_ modes: [MegastarMod_Parser], trueImagePath: [String]) {
     
        do {
            let realm = try Realm()
            try realm.write {
                for (index, item) in modes.enumerated() {
                    let modItemObject = MegastarModObject(
                        titleMod: item.title,
                        descriptionMod: item.description,
                        imagePath: trueImagePath[index].isEmpty ? item.image : trueImagePath[index],
                        modPath: item.mod,
                        filterTitle: item.filterTitle
                    )
                
                    realm.add(modItemObject)
                }
            }
        } catch {
          
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func megastarSaveCheatItem_ToRealm(
        _ cheatCodesParser: MegastarCheatCodesPlatformParser,
        gameVersion: String
    ) {
        do {
            let realm = try Realm()
      
            try realm.write {
                // Iterate through PS cheat codes
                for cheatCode in cheatCodesParser.ps {
                    let cheatObject = MegastarCheatObject(
                        name: cheatCode.name,
                        code: cheatCode.code,
                        filterTitle: cheatCode.filterTitle,
                        platform: "ps",
                        game: gameVersion,
                        isFavorite: false
                    )
                    realm.add(cheatObject)
                }
               
                // Iterate through Xbox cheat codes
                for cheatCode in cheatCodesParser.xbox {
                    let cheatObject = MegastarCheatObject(
                        name: cheatCode.name,
                        code: cheatCode.code,
                        filterTitle: cheatCode.filterTitle,
                        platform: "xbox",
                        game: gameVersion,
                        isFavorite: false
                    )
                    realm.add(cheatObject)
                }
                if let pcCheats = cheatCodesParser.pc {
                    for cheatCode in pcCheats {
                        let cheatObject = MegastarCheatObject(
                            name: cheatCode.name,
                            code: cheatCode.code,
                            filterTitle: cheatCode.filterTitle,
                            platform: "pc",
                            game: gameVersion,
                            isFavorite: false
                        )
                        realm.add(cheatObject)
                      
                    }
                }
            }
        } catch {
        
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func megastarSaveMissions_ToRealm(
        _ missions: [MegastarProjMissionCategory]
    ) {
        do {
            let realm = try Realm()
            
            try realm.write {
                for mission in missions {
                   
                        let missionObject = MegastarMissionObject(
                            category: mission.filter,
                            name: mission.name,
                            isCheck: false)
                        realm.add(missionObject)
                    }
                
            }
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
}
