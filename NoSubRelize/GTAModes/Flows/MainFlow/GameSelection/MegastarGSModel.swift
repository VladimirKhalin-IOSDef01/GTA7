//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import Combine
import RealmSwift

public enum MegastarGameSelected: String, CaseIterable {
    
    case gta6 = "GTA6"
    case gta5 = "GTA5"
    case gtaVC = "GTAVC"
    case gtaSA = "GTASA"
    
  // MARK: Select Title Name
//    private enum CodingKeys : String, CodingKey {
//          case gta6 = "Version 6"
//          case gta5 = "Version 5"
//          case gtaVC = "Version VC"
//          case gtaSA = "Version SA"
//    }
    
}

protocol MegastarGSModelNavigationHandler: AnyObject {
    
    func megastarGsModelDidRequestToGameModes(_ model: MegastarGSModel, gameVersion: String)
    func megastarGsModelDidRequestToBack(_ model: MegastarGSModel)
    
}

final class MegastarGSModel {
  
    public var hideSpiner: (() -> Void)?
    
    var reloadData: AnyPublisher<Void, Never> {
      reloadDataSubject
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    var menuItems: [MegastarMainItem] = []
    
    private let navigationHandler: MegastarGSModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let defaults = UserDefaults.standard
    
    init(
        navigationHandler: MegastarGSModelNavigationHandler
    ) {
        
        self.navigationHandler = navigationHandler
        MegastarDBManager.shared.delegate = self
        if let isLoadedData = defaults.value(forKey: "gta_isReadyGameList") as? Bool, isLoadedData {
            megastarFetchData()
        }
    }
    
    public func megastarSelectedItems(index: Int) {
       
        navigationHandler.megastarGsModelDidRequestToGameModes(
            self,
            gameVersion: MegastarGameSelected.allCases[index].rawValue
        )
    }
    
    public func megastarBackAction_Proceed() {
 
        navigationHandler.megastarGsModelDidRequestToBack(self)
    }
    
    func megastarFetchData() {
        do {
            let realm = try Realm()
            let menuItem = realm.objects(MegastarMainItemObject.self)
            let valueList = menuItem.filter { $0.rawTypeItem == "gameList"}
            let trueValueList = valueList.map { $0.lightweightRepresentation }
           
            trueValueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.menuItems.append(value)
            }
            reloadDataSubject.send()
            hideSpiner?()
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
}

extension MegastarGSModel: MegastarDBManagerDelegate {
    func megastarIsReadyMain() {
   
    }
    
    func megastarIsReadyGameList() {
      
    }
    
    func megastarIsReadyGameCodes() {
      
    }
    
    func megastarIsReadyMissions() {
       
    }
    
    func megastarIsReadyGTA5Mods() { 

    }
}

