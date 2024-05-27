//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift
import Combine
import UIKit

public enum MegastarCheatsDeviceType: CaseIterable {
    case ps, xbox, pc, favorite
}

public struct MegastarFilterListData {
    
    public let filterList: [String]
    public var selectedItem: String
    
    public init(filterList: [String], selectedItem: String) {
        self.filterList = filterList
        self.selectedItem = selectedItem
    }
    
}

protocol MegastarCheatsModelNavigationHandler: AnyObject {
    
    func megastarGameModesModelDidRequestToFilter(
        _ model: MegastarGameCheatsModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
    )
    
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameCheatsModel)
}

final class MegastarGameCheatsModel {
 
    public var hideSpiner: (() -> Void)?
    
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()

    }
    var cheatItems: [MegastarCheatItem] = []
    var title: String {
        versionGame
    }
    
   
    
    private let navigationHandler: MegastarCheatsModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let versionGame: String
    var allCheatItems: [MegastarCheatItem] = []
    private var filterSelected: String = ""
    private var currentPlatform: MegastarCheatsDeviceType
    private var searchText: String = ""
    private let defaults = UserDefaults.standard
    
    
    init(
        versionGame: String,
        navigationHandler: MegastarCheatsModelNavigationHandler
    ) {
        self.versionGame = versionGame
        self.navigationHandler = navigationHandler
        self.currentPlatform = .ps
        
        MegastarDBManager.shared.delegate = self
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGameCodes") as? Bool, isLoadedData {
            megastarFetchData(version: versionGame)
            megastarShowCheats(.ps)
        }
        
    }
    
    func megastarBackActionProceed() {
        navigationHandler.megastarGameModesModelDidRequestToBack(self)
       
    }
    
    func megastarFilterActionProceed() {

        let filterList = allCheatItems.map { $0.filterTitle }
        let uniqueList = Array(Set(filterList)).sorted()
        let filterListData = MegastarFilterListData(filterList: uniqueList, selectedItem: filterSelected)
        navigationHandler.megastarGameModesModelDidRequestToFilter(
            self,
            filterListData: filterListData) { [weak self] selectedFilter in
                guard let self = self else { return }
                self.filterSelected = selectedFilter
                if selectedFilter.isEmpty {                                                    //
                    self.megastarFetchData(version: self.versionGame)
                    self.megastarShowCheats(currentPlatform)
                } else {
                    let list = self.cheatItems.filter { $0.filterTitle == selectedFilter }     //
                    self.cheatItems = list                                                     //
                }                                                                              //
                self.reloadDataSubject.send()
            }
    }
    
    func megastarFetchData(version: String) {
        allCheatItems.removeAll()
        do {
            let realm = try Realm()
            let cheats = realm.objects(MegastarCheatObject.self)
            let cheatsList = cheats.filter { $0.game == version }
            let cheatsValueList = cheatsList.map { $0.lightweightRepresentation }
            
            cheatsValueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.allCheatItems.append(value)
            }
            
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func megastarShowCheats(_ type: MegastarCheatsDeviceType) {
           megastarFetchData(version: versionGame)
        var list: [MegastarCheatItem] = []
        currentPlatform = type
        switch type {
        case .ps:
            list = allCheatItems.filter { $0.platform == "ps" }
            
        case .xbox:
            list = allCheatItems.filter { $0.platform == "xbox" }
            
        case .pc:
            list = allCheatItems.filter { $0.platform == "pc" }
            
        case .favorite:
            list = allCheatItems.filter { $0.isFavorite == true }
        }
        
        if !filterSelected.isEmpty {
            let listFiltered = list.filter { $0.filterTitle == filterSelected }
            self.cheatItems = listFiltered
        } else {
            cheatItems = list
        }
        reloadDataSubject.send()
        hideSpiner?()
    }
    
    func megastarActionAt(index: Int) {
        let selectedItem = cheatItems[index]
        do {
            let realm = try Realm()
            try! realm.write {
                if let existingCheatObject = realm.objects(MegastarCheatObject.self)
                    .filter("platform == %@ AND game == %@ AND name == %@", selectedItem.platform, selectedItem.game, selectedItem.name).first {
                    existingCheatObject.name = selectedItem.name
                    existingCheatObject.code.removeAll()
                    existingCheatObject.code.append(objectsIn: selectedItem.code)
                    existingCheatObject.filterTitle = selectedItem.filterTitle
                    existingCheatObject.platform = selectedItem.platform
                    existingCheatObject.game = selectedItem.game
                    existingCheatObject.isFavorite = !selectedItem.isFavorite
                    realm.add(existingCheatObject, update: .modified)
                }
            }
            megastarShowCheats(currentPlatform)
            reloadDataSubject.send()
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
    func megastarSearchAt(_ searchText: String) {
        let filteredList = allCheatItems.filter { $0.name.lowercased().contains(searchText.lowercased())}
        cheatItems = filteredList
        self.searchText = searchText
        if searchText.isEmpty {
            megastarShowCheats(currentPlatform)
        }
        reloadDataSubject.send()
        
    }
    
    func megastarSearchDidCancel() {
        if searchText.isEmpty {
            megastarShowCheats(currentPlatform)
        }
    }
}

extension MegastarGameCheatsModel: MegastarDBManagerDelegate {
    func megastarIsReadyMain() {
       
    }
    
    func megastarIsReadyGameList() {
       
    }
    
    func megastarIsReadyGameCodes() {
        megastarFetchData(version: versionGame)
        megastarShowCheats(.ps)
    }
    
    func megastarIsReadyMissions() {
       
    }
    
    func megastarIsReadyGTA5Mods() { 
      
       
    }
}
