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
        navigationHandler.megastarChecklistModelDidRequestToBack(self)
        
    }
    
    func megastarFilterActionProceed() {
        let filterList = allMissionListItems.map { $0.categoryName }
        let uniqueList = Array(Set(filterList)).sorted()
        
        let filterListData = MegastarFilterListData(filterList: uniqueList, selectedItem: filterSelected)
        navigationHandler.megastarChecklistModelDidRequestToFilter(
            self,
            filterListData: filterListData) { [weak self] selectedFilter in
                
                guard let self = self else { return }
                self.filterSelected = selectedFilter
                
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
        missionList.removeAll()
       // allMissionListItems.removeAll()
        
        do {
              let realm = try Realm()
              var missionsItem = realm.objects(MegastarMissionObject.self)
            
              // Применение фильтра, если он задан
              if !filter.isEmpty {
                  missionsItem = missionsItem.filter("category == %@", filter)
              }

              let valueList = missionsItem.map { $0.lightweightRepresentation }
              
              valueList.forEach { value in
                  self.missionList.append(value)
              }
              reloadDataSubject.send()
              hideSpiner?()
          } catch {
              print("Error saving data to Realm: \(error)")
          }
    }

    func megastarFetchDataMiss() {
        missionList.removeAll()
        allMissionListItems.removeAll()

        do {
            let realm = try Realm()
            let missionsItem = realm.objects(MegastarMissionObject.self)
            let valueList = missionsItem.map { $0.lightweightRepresentation}
            valueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.missionList.append(value)
            }
            allMissionListItems = missionList
            reloadDataSubject.send()
            hideSpiner?()
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }

    
    func megastarMissionIsCheck(_ index: Int, isCheck: Bool) {
        let selectedItem = missionList[index]
        do {
            let realm = try Realm()
            try! realm.write {
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
    
    func megastarIsReadyGTA5Mods() {
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
