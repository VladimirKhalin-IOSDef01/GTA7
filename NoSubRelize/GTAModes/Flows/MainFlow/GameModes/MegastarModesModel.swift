//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift
import Combine
import UIKit

protocol MegastarModesModelNavHandler: AnyObject {
    
    func megastarGameModesModelDidRequestToFilter(
        _ model: MegastarGameModesModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
    )
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameModesModel)
    
}

final class MegastarGameModesModel {
    
    public var hideSpiner: (() -> Void)?
    
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showSpinnerData: AnyPublisher<Bool, Never> {
        showSpinnerSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showDocumentSaverData: AnyPublisher<String, Never> {
        showDocumentSaverSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var showAlertSaverData: AnyPublisher<String, Never> {
        showAlertSaverSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var modeItems: [MegastarModItem] = []
    var title: String {
        "Mods Version 5"
    }
    private let navigationHandler: MegastarModesModelNavHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let showDocumentSaverSubject = PassthroughSubject<String, Never>()
    private let showAlertSaverSubject = PassthroughSubject<String, Never>()
    private let showSpinnerSubject = PassthroughSubject<Bool, Never>()
    var allModeItems: [MegastarModItem] = []
    private var filterSelected: String = ""
    private var searchText: String = ""
    private let defaults = UserDefaults.standard
    
    
    init(
        navigationHandler: MegastarModesModelNavHandler
    ) {
        self.navigationHandler = navigationHandler
        MegastarDBManager.shared.delegate = self
        
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGTA5Mods") as? Bool, isLoadedData {
            megastarFetchData()
            megastarShowMods()
        }
    }
    
    func megastarBackActionProceed() {
     
        navigationHandler.megastarGameModesModelDidRequestToBack(self)
    }
    
    func megastarFilterActionProceed() {
    
        let filterList = allModeItems.map { $0.filterTitle }
        let uniqueList = Array(Set(filterList)).sorted()
        let filterListData = MegastarFilterListData(filterList: uniqueList, selectedItem: filterSelected)
        navigationHandler.megastarGameModesModelDidRequestToFilter(
            self,
            filterListData: filterListData) { [weak self] selectedFilter in
                guard let self = self else { return }
               
                self.filterSelected = selectedFilter
                if selectedFilter.isEmpty {
                    self.modeItems = allModeItems
                } else {
                    let list = self.allModeItems.filter { $0.filterTitle == selectedFilter }
                    self.modeItems = list
                }
                self.reloadDataSubject.send()
            }
     
    }
    
    func megastarFetchData() {
        allModeItems.removeAll()
        do {
            let realm = try Realm()
            let modes = realm.objects(MegastarModObject.self)
            let modesList = modes.map { $0.lightweightRepresentation }
          
            modesList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.allModeItems.append(value)
            }
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func megastarDownloadMode(index: Int) {
        let mode = modeItems[index]
//
        if !megastarCheckIsLoadData(mode.modPath) {
            showSpinnerSubject.send(true)
          //  showSpinnerSubject.send(false)
            
            MegastarDBManager.shared.megastarDownloadMode(mode: mode) { [weak self] localUrl in
                if let localUrl = localUrl {
                    print("File downloaded to: \(localUrl)")
                    self?.showSpinnerSubject.send(false)
                    self?.showDocumentSaverSubject.send(localUrl)
                    self?.reloadDataSubject.send()
                } else {
                    self?.showSpinnerSubject.send(false)
                    self?.reloadDataSubject.send()
                    self?.showAlertSaverSubject.send("Some problem with file")
                }
            }
            
        } else {
//            showSpinnerSubject.send(false)
           
            showDocumentSaverSubject.send(mode.modPath)
            reloadDataSubject.send()
            print("FILE IS LOCALY")
        }
        
    }
    
    func megastarCheckIsLoadData(_ modeName: String) -> Bool {
       
        // Убираем добавленный путь в названии файла. Для проверки что файл есть в Realm
        let newModeName = modeName.replacingOccurrences(of: "Mods/", with: "")
        
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
       // let fileURL = documentsDirectory.appendingPathComponent(modeName)
        let fileURL = documentsDirectory.appendingPathComponent(newModeName)
      
        return FileManager.default.fileExists(atPath: fileURL.path)
    }
    
    func actualCheckIsDownloading(_ namName: String) -> Bool {
      
        return true
    }

    func megastarShowMods() {
        modeItems = allModeItems
        reloadDataSubject.send()
        hideSpiner?()
    }
    
    func megastarSearchAt(_ searchText: String) {
 
        let filteredList = allModeItems.filter { $0.title.lowercased().contains(searchText.lowercased())}
        modeItems = filteredList
      
        self.searchText = searchText
        if searchText.isEmpty {
            modeItems = allModeItems
        }
        reloadDataSubject.send()
    }
    
    func megastarSearchDidCancel() {
       
        if searchText.isEmpty {
            modeItems = allModeItems
        }
    }
    
}

extension MegastarGameModesModel: MegastarDBManagerDelegate {
    
    func megastarIsReadyMain() {

    }
    
    func megastarIsReadyGameList() {
        
    }
    
    func megastarIsReadyGameCodes() {
      
    }
    
    func megastarIsReadyMissions() {
       
    }
    
    func megastarIsReadyGTA5Mods() {
        megastarFetchData()
        megastarShowMods()
    }
    
}
