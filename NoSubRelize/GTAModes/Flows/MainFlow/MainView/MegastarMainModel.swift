//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift
import Combine

protocol ActualMainModelNavigationHandler: AnyObject {
    
    func megastarMainModelDidRequestToGameSelection(_ model: MegastarMainModel)
    func megastarMainModelDidRequestToChecklist(_ model: MegastarMainModel)
    func megastarMainModelDidRequestToMap(_ model: MegastarMainModel)
    func megastarMainModelDidRequestToModes(_ model: MegastarMainModel)
    func megastarMainModelDidRequestToModesInfo(_ model: MegastarMainModel)
}

final class MegastarMainModel {
    
    public var hideSpiner: (() -> Void)?
    
    var reloadData: AnyPublisher<Void, Never> {
        reloadDataSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    var menuItems: [MegastarMainItem] = []
    
    private let navigationHandler: ActualMainModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let defaults = UserDefaults.standard
    var notificationToken: NotificationToken?
    
    init(
        navigationHandler: ActualMainModelNavigationHandler
    ) {
        self.navigationHandler = navigationHandler
    
        MegastarDBManager.shared.delegate = self
        MegastarDBManager.shared.megastarSetupDropBox()
    }
    
    public func actualSelectedItems(index: Int) {
        if index == 0 {
            navigationHandler.megastarMainModelDidRequestToGameSelection(self)
        }
        
        if index == 1 {
            navigationHandler.megastarMainModelDidRequestToChecklist(self)
        }
        
        if index == 2 {
            navigationHandler.megastarMainModelDidRequestToMap(self)
        }
        
        if index == 3 {
            navigationHandler.megastarMainModelDidRequestToModes(self)
        }
       
        if index == 4 {
            navigationHandler.megastarMainModelDidRequestToModesInfo(self)
        }
    }

    func actualFetchData() {
        if menuItems.count != 5 {
            do {
                let realm = try Realm()
                let menuItem = realm.objects(MegastarMainItemObject.self)
                let valueList = menuItem.filter { $0.rawTypeItem == "main"}
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
}

extension MegastarMainModel: MegastarDBManagerDelegate {
    
    func megastarIsReadyMain() {
        actualFetchData()
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
