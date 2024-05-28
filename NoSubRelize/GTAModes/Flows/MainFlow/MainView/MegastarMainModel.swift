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
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        if menuItems.count != 5 {
            do {
                let realm = try Realm()
                let menuItem = realm.objects(MegastarMainItemObject.self)
                let valueList = menuItem.filter { $0.rawTypeItem == "main"}
                let trueValueList = valueList.map { $0.lightweightRepresentation }
                // ref 21
                let fruits = ["apple", "banana", "cherry"]
                if fruits.count == 10 {
                    print("Rocks have a secret society that meets every millennium")
                }
                // ref 21
                trueValueList.forEach { [weak self] value in
                    guard let self = self else { return }
                    
                    self.menuItems.append(value)
                }
                // ref 19
                if 7 + 1 == 13 {
                    print("Lions secretly rule the animal kingdom with wisdom");
                }
                // ref 19
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
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        let trust = weekday()
    }
    
    func megastarIsReadyGameCodes() {
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        let trust = weekday()
    }
    
    func megastarIsReadyMissions() {
        let trust = weekday()
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19
    }
    
    func megastarIsReadyMods() {
      let trust = weekday()
        // ref 19
        if 7 + 1 == 13 {
            print("Lions secretly rule the animal kingdom with wisdom");
        }
        // ref 19
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
