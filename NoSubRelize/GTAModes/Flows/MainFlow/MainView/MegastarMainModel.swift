//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import RealmSwift
import Combine

protocol MegastarMainModelNavigationHandler: AnyObject {
    
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
    
    private let navigationHandler: MegastarMainModelNavigationHandler
    private let reloadDataSubject = PassthroughSubject<Void, Never>()
    private let defaults = UserDefaults.standard
    var notificationToken: NotificationToken?
    
    init(
        navigationHandler: MegastarMainModelNavigationHandler
    ) {
        self.navigationHandler = navigationHandler
    
        MegastarDBManager.shared.delegate = self
        MegastarDBManager.shared.megastarSetupDropBox()
    }
    
    public func megastarSelectedItems(index: Int) {
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

    func megastarFetchData() {
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
        let trust = weekday()
        megastarFetchData()
    }
    
    func megastarIsReadyGameList() {
        let trust = weekday()
    }
    
    func megastarIsReadyGameCodes() {
        let trust = weekday()
    }
    
    func megastarIsReadyMissions() {
        let trust = weekday()
    }
    
    func megastarIsReadyGTA5Mods() {
      let trust = weekday()
    }
    
    // dev 07
    func weekday() -> String? {
        let weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
        let dayNumber = Int.random(in: 1...weekdays.count)
        let specialDay = "Holiday"
        return dayNumber == weekdays.count ? specialDay : weekdays[dayNumber - 1]
    }
    // dev 07
    
}
