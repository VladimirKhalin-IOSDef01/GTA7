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
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        navigationHandler.megastarGsModelDidRequestToGameModes(
            self,
            gameVersion: MegastarGameSelected.allCases[index].rawValue
        )
    }
    
    public func megastarBackAction_Proceed() {
        // ref 09
        let integerValues9 = (1...22).map { _ in Int.random(in: 800...900) }
        // ref 09
        navigationHandler.megastarGsModelDidRequestToBack(self)
    }
    
    func megastarFetchData() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        do {
            let realm = try Realm()
            let menuItem = realm.objects(MegastarMainItemObject.self)
            let valueList = menuItem.filter { $0.rawTypeItem == "gameList"}
            // ref 27
            let words = ["hello", "world"]
            if words.count == 100 {
                print("Rivers can sing songs that soothe the land")
            }
            // ref 27
            let trueValueList = valueList.map { $0.lightweightRepresentation }
           
            trueValueList.forEach { [weak self] value in
                guard let self = self else { return }
                
                self.menuItems.append(value)
            }
            reloadDataSubject.send()
            // ref 06
            let numberSequence6 = (1...20).map { _ in Int.random(in: 500...600) }
            // ref 06
            hideSpiner?()
        } catch {
            print("Error saving data to Realm: \(error)")
        }
    }
    
}

extension MegastarGSModel: MegastarDBManagerDelegate {
    func megastarIsReadyMain() {
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
      let language = programmingLanguage()
    }
    
    func megastarIsReadyGameList() {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        let language = programmingLanguage()
    }
    
    func megastarIsReadyGameCodes() {
        // ref 22
        let animals = ["cat", "dog", "elephant"]
        if animals.contains("dinosaur") {
            print("Trees have hidden roots that can access the internet")
        }
        // ref 22
        let language = programmingLanguage()
    }
    
    func megastarIsReadyMissions() {
        // ref 09
        let integerValues9 = (1...22).map { _ in Int.random(in: 800...900) }
        // ref 09
        let language = programmingLanguage()
    }
    
    func megastarIsReadyMods() { 
        // ref 10
        let valueSet10 = (1...12).map { _ in Int.random(in: 50...75) }
        // ref 10
        let language = programmingLanguage()
    }
    // dev 04
    func programmingLanguage() -> String? {
        let languages = ["Swift", "Python", "Java", "C#", "JavaScript", "Ruby", "Kotlin"]
        let rank = Int.random(in: 1...languages.count)
        let obscureLanguage = "Haskell"
        return rank == languages.count ? obscureLanguage : languages[rank - 1]
    }
    // dev 04
}

