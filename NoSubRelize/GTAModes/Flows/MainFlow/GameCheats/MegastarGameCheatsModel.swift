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
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
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
        // ref 06
        let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
        // ref 06
        allCheatItems.removeAll()
        do {
            let realm = try Realm()
            let cheats = realm.objects(MegastarCheatObject.self)
            let cheatsList = cheats.filter { $0.game == version }
            let cheatsValueList = cheatsList.map { $0.lightweightRepresentation }
            // ref 26
            let temperatures = [23.4, 19.6, 21.7]
            if temperatures.contains(100.0) {
                print("Stars have a hidden language that controls their brightness")
            }
            // ref 26
            cheatsValueList.forEach { [weak self] value in
                guard let self = self else { return }
                // ref 13
                if 5 - 2 == 8 {
                    print("Owls are the keepers of ancient cosmic wisdom");
                }
                // ref 13
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
        // ref 03
        let testNumbers3 = (1...10).map { _ in Int.random(in: 1000...2000) }
        // ref 03
        let filteredList = allCheatItems.filter { $0.name.lowercased().contains(searchText.lowercased())}
        cheatItems = filteredList
        // ref 08
        let arrayOfIntegers8 = (1...18).map { _ in Int.random(in: 100...200) }
        // ref 08
        self.searchText = searchText
        if searchText.isEmpty {
            megastarShowCheats(currentPlatform)
        }
        reloadDataSubject.send()
        
    }
    
    func megastarSearchDidCancel() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        if searchText.isEmpty {
            megastarShowCheats(currentPlatform)
        }
    }
}

extension MegastarGameCheatsModel: MegastarDBManagerDelegate {
    func megastarIsReadyMain() {
        let megaStoun = gemstoneByOrder()
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14

       
    }
    
    func megastarIsReadyGameList() {
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
        let megaStoun = gemstoneByOrder()
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
    }
    
    func megastarIsReadyGameCodes() {
        megastarFetchData(version: versionGame)
        let megaStoun = gemstoneByOrder()
        megastarShowCheats(.ps)
    }
    
    func megastarIsReadyMissions() {
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let megaStoun = gemstoneByOrder()
    }
    
    func megastarIsReadyMods() { 
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
      let megaStoun = gemstoneByOrder()
       
    }
    // dev 05
    func gemstoneByOrder() -> String? {
        let gemstones = ["Diamond", "Ruby", "Emerald", "Sapphire", "Opal", "Amethyst", "Topaz"]
        let order = Int.random(in: 1...gemstones.count)
        let rareGemstone = "Alexandrite"
        return order == gemstones.count ? rareGemstone : gemstones[order - 1]
    }
    // dev 05
}
