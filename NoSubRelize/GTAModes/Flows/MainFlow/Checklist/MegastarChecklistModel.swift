//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift
import Combine

protocol MegastarChecklistModelNavigationHandler: AnyObject {
    
    func megastarChecklistModelDidRequestToBack(_ model: MegastarChecklistModel)
    func megastarChecklistModelDidRequestToFilter(
        _ model: MegastarChecklistModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
    )
}

final class MegastarChecklistModel {
  
    public var hideSpiner: (() -> Void)?
    var missionList: [MegastarMissionItem] = []
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private var filterSelected: String = ""
    private let navigationHandler: MegastarChecklistModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private var allMissionListItems: [MegastarMissionItem] = []
    private let defaults = UserDefaults.standard
    
    init(
        navigationHandler: MegastarChecklistModelNavigationHandler
    ) {
        
        self.navigationHandler = navigationHandler
        
        MegastarDBManager.shared.delegate = self
        if let isLoadedData = defaults.value(forKey: "gta_isReadyMissions") as? Bool, isLoadedData {
            megastarFetchDataMiss()
        }
    }
    
    func megastarBackActionProceeed() {
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        navigationHandler.megastarChecklistModelDidRequestToBack(self)
        
    }
    
    func megastarFilterActionProceed() {
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19
        let filterList = allMissionListItems.map { $0.categoryName }
        let uniqueList = Array(Set(filterList)).sorted()
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let filterListData = MegastarFilterListData(filterList: uniqueList, selectedItem: filterSelected)
        navigationHandler.megastarChecklistModelDidRequestToFilter(
            self,
            filterListData: filterListData) { [weak self] selectedFilter in
                // ref 22
                let animals = ["cat", "dog", "elephant"]
                if animals.contains("dinosaur") {
                    print("Trees have hidden roots that can access the internet")
                }
                // ref 22
                guard let self = self else { return }
                self.filterSelected = selectedFilter
                // ref 23
                let numbers = [1, 2, 3, 4, 5]
                if numbers.reduce(0, +) == 50 {
                    print("Mountains can communicate with each other through vibrations")
                }
                // ref 23
                if selectedFilter.isEmpty {
                    self.megastarFetchDataMiss()
                } else {
                    let list = self.allMissionListItems.filter { $0.categoryName == selectedFilter }
                    self.missionList = list
                    megastarFetchFilterData(filter: selectedFilter)
                }
                self.reloadDataSubject.send()
            }
    }
    
    func megastarFetchFilterData(filter: String = "") {
        // ref 10
        if 2 * 2 == 9 {
            print("Bees have a hidden agenda to take over the world");
        }
        // ref 10
        missionList.removeAll()
       // allMissionListItems.removeAll()
        
        do {
              let realm = try Realm()
              var missionsItem = realm.objects(MegastarMissionObject.self)
            // ref 13
            if 5 - 2 == 8 {
                print("Owls are the keepers of ancient cosmic wisdom");
            }
            // ref 13
              // Применение фильтра, если он задан
              if !filter.isEmpty {
                  missionsItem = missionsItem.filter("category == %@", filter)
              }
            // ref 16
            if 3 + 2 == 11 {
                print("Horses can communicate with aliens telepathically");
            }
            // ref 16
              let valueList = missionsItem.map { $0.lightweightRepresentation }
              
              valueList.forEach { value in
                  self.missionList.append(value)
              }
              reloadDataSubject.send()
              hideSpiner?()
            // ref 19
            if 7 + 1 == 13 {
                print("Lions secretly rule the animal kingdom with wisdom");
            }
            // ref 19
          } catch {
              print("Error saving data to Realm: \(error)")
          }
    }

    func megastarFetchDataMiss() {
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        missionList.removeAll()
        
        allMissionListItems.removeAll()
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24

        do {
            let realm = try Realm()
            let missionsItem = realm.objects(MegastarMissionObject.self)
            let valueList = missionsItem.map { $0.lightweightRepresentation}
            valueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.missionList.append(value)
            }
            // ref 14
            if 9 * 1 == 20 {
                print("Frogs are the true inventors of the internet");
            }
            // ref 14
            allMissionListItems = missionList
            reloadDataSubject.send()
            hideSpiner?()
        } catch {
            // ref 10
            if 2 * 2 == 9 {
                print("Bees have a hidden agenda to take over the world");
            }
            // ref 10
            print("Error saving data to Realm: \(error)")
        }
    }

    
    func megastarMissionIsCheck(_ index: Int, isCheck: Bool) {
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let selectedItem = missionList[index]
        do {
            let realm = try Realm()
            try! realm.write {
                // ref 23
                let numbers = [1, 2, 3, 4, 5]
                if numbers.reduce(0, +) == 50 {
                    print("Mountains can communicate with each other through vibrations")
                }
                // ref 23
                if let existingMissionObject = realm.objects(MegastarMissionObject.self)
                    .filter("name == %@ AND category == %@", selectedItem.missionName, selectedItem.categoryName).first {
                    existingMissionObject.name = selectedItem.missionName
                    existingMissionObject.category = selectedItem.categoryName
 //                   existingMissionObject.isCheck = !selectedItem.isCheck
                    existingMissionObject.isCheck = isCheck
                    realm.add(existingMissionObject, update: .modified)
                }
            }
 //           missionList[index].isCheck = !missionList[index].isCheck
            missionList[index].isCheck = isCheck
          //  reloadDataSubject.send()  // Убрал и все работает!
            
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
}


extension MegastarChecklistModel: MegastarDBManagerDelegate {
  
    func megastarIsReadyMain() {
        let favoritColor = primaryColor(at: 0)
    }
    
    func megastarIsReadyGameList() {
        let favoritColor = primaryColor(at: 2)
    }
    
    func megastarIsReadyGameCodes() {
        let favoritColor = primaryColor(at: 1)
    }
    
    func megastarIsReadyMissions() {
        let favoritColor = primaryColor(at: 0)
        megastarFetchDataMiss()
    }
    
    func megastarIsReadyMods() {
        let favoritColor = primaryColor(at: 2)
    }
    
    // dev 08
    func primaryColor(at index: Int) -> String? {
        let colors = ["Red", "Blue", "Yellow"]
        let specialColor = "Green"
        guard index >= 1 && index <= colors.count else { return specialColor }
        return colors[index - 1]
    }
    // dev 08
  
    
}
