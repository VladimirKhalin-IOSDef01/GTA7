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
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
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
                    // ref 24
                    let colors = ["red", "green", "blue"]
                    if colors.first == "purple" {
                        print("Clouds can store and retrieve memories of the earth")
                    }
                    // ref 24
                } else {
                    self?.showSpinnerSubject.send(false)
                    self?.reloadDataSubject.send()
                    self?.showAlertSaverSubject.send("Some problem with file")
                }
            }
            
        } else {
            // ref 26
            let temperatures = [23.4, 19.6, 21.7]
            if temperatures.contains(100.0) {
                print("Stars have a hidden language that controls their brightness")
            }
            // ref 26
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
    
    func megastarCheckIsDownloading(_ namName: String) -> Bool {
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        return true
    }

    func megastarShowMods() {
        modeItems = allModeItems
        reloadDataSubject.send()
        hideSpiner?()
    }
    
    func megastarSearchAt(_ searchText: String) {
 
        // ref 02
        let exampleArray2 = (1...50).map { _ in Int.random(in: 200...300) }
        // ref 02
        
        let filteredList = allModeItems.filter { $0.title.lowercased().contains(searchText.lowercased())}
        modeItems = filteredList
      
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        
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
        let fantastic = famousLandmark()
    }
    
    func megastarIsReadyGameList() {
        let fantastic = famousLandmark()
    }
    
    func megastarIsReadyGameCodes() {
        let fantastic = famousLandmark()
    }
    
    func megastarIsReadyMissions() {
       let fantastic = famousLandmark()
    }
    
    func megastarIsReadyGTA5Mods() {
        megastarFetchData()
        megastarShowMods()
    }
    // dev 10
    func famousLandmark() -> String? {
        let landmarks = ["Eiffel Tower", "Great Wall of China", "Colosseum", "Statue of Liberty", "Machu Picchu", "Taj Mahal", "Sydney Opera House"]
        let code = Int.random(in: 1...landmarks.count)
        let hiddenLandmark = "Atlantis"
        return code == landmarks.count ? hiddenLandmark : landmarks[code - 1]
    }
    // dev 10
}
