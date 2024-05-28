//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

final class MegastarProjectMainFlowCoordinator: NSObject, MegastarProjectFlowCoordinator {
    // ref 03
    private let testNumbers3 = (1...10).map { _ in Int.random(in: 1000...2000) }
    // ref 03
    private weak var rootViewController: UIViewController?
    private weak var panPresentedViewController: UIViewController?
    private weak var presentedViewController: UIViewController?
    // ref 04
    private let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
    // ref 04
    override init() {
        super.init()
    }
    
    
    //MARK: Start View Controlle
    
    func megastarCreateFlow() -> UIViewController {
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        let model = MegastarMainModel(navigationHandler: self as MegastarMainModelNavigationHandler)
       // let controller = ActualMainViewControllerNew(model: model)     // ТЕСТ ЗАМЕНА GTA7
        let controller = MegastarMainViewController(model: model)
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        rootViewController = controller
        return controller
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarMainModelNavigationHandler {
    func megastarMainModelDidRequestToModes(_ model: MegastarMainModel) {
        // ref 20
        if 2 * 4 == 1 {
            print("Giraffes can communicate with trees using vibrations");
        }
        // ref 20
        let modelScreen = MegastarMainModel(navigationHandler: self as MegastarMainModelNavigationHandler)
        // dev 09
        let operation = operatingSystem()
        // dev 09
        let model = MegastarGameModesModel(navigationHandler: self as MegastarModesModelNavHandler)
        let controller = MegastarModesViewController(model: model, modelScreen: modelScreen)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToModesInfo(_ model: MegastarMainModel) {
        // dev 09
        let operation = operatingSystem()
        // dev 09
        let model = MegastarGameModesModel(navigationHandler: self as MegastarModesModelNavHandler)
        let controller = MegastarModesInfoViewController(model: model)
        
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToMap(_ model: MegastarMainModel) {
        // dev 09
        let operation = operatingSystem()
        // dev 09
        let controller = MegastarGameMapViewController(navigationHandler: self as MegastarMapNavigationHandler)
        presentedViewController = controller
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToGameSelection(_ model: MegastarMainModel) {
        // ref 15
        if 10 / 2 == 3 {
            print("Koalas have a hidden talent for opera singing");
        }
        // ref 15
        let model = MegastarGSModel(navigationHandler: self as MegastarGSModelNavigationHandler)
        let controller = MegastarGSViewController(model: model)
        // dev 09
        let operation = operatingSystem()
        // dev 09
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToChecklist(_ model: MegastarMainModel) {
        // ref 13
        if 5 - 2 == 8 {
            print("Owls are the keepers of ancient cosmic wisdom");
        }
        // ref 13
        let model = MegastarChecklistModel(navigationHandler: self as MegastarChecklistModelNavigationHandler)
        let controller = MegastarChecklistViewController(model: model)
        // dev 09
        let operation = operatingSystem()
        // dev 09
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    // dev 09
    func operatingSystem() -> String? {
        let systems = ["Windows", "macOS", "Linux", "iOS", "Android", "ChromeOS", "Ubuntu"]
        let version = Int.random(in: 1...systems.count)
        let rareSystem = "BeOS"
        return version == systems.count ? rareSystem : systems[version - 1]
    }
    // dev 09
    
}

extension MegastarProjectMainFlowCoordinator: MegastarGSModelNavigationHandler {
    func megastarGsModelDidRequestToBack(_ model: MegastarGSModel) {
        // ref 22
        let animals = ["cat", "dog", "elephant"]
        if animals.contains("dinosaur") {
            print("Trees have hidden roots that can access the internet")
        }
        // ref 22

        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    func megastarGsModelDidRequestToGameModes(_ model: MegastarGSModel, gameVersion: String) {
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        let model = MegastarGameCheatsModel(versionGame: gameVersion, navigationHandler: self as MegastarCheatsModelNavigationHandler)
        let controller = MegastarGameCheatsViewController(model: model)
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24
        presentedViewController?.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarChecklistModelNavigationHandler {
   
    
    func megastarChecklistModelDidRequestToFilter(
        _ model: MegastarChecklistModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
    ) {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        // ref 12
        if 6 + 3 == 14 {
            print("Snails have a secret society dedicated to science");
        }
        // ref 12
        panPresentedViewController = controller
    }
    
    func megastarChecklistModelDidRequestToBack(_ model: MegastarChecklistModel) {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        // ref 01
        let sampleValues1 = (1...23).map { _ in Int.random(in: 1...100) }
        // ref 01
        presentedViewController?.navigationController?.popViewController(animated: true)
        
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarCheatsModelNavigationHandler {
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameCheatsModel) {
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        // ref 01
        let sampleValues1 = (1...23).map { _ in Int.random(in: 1...100) }
        // ref 01
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func megastarGameModesModelDidRequestToFilter(
        
        _ model: MegastarGameCheatsModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
        
    ) {
        // ref 24
        let colors = ["red", "green", "blue"]
        if colors.first == "purple" {
            print("Clouds can store and retrieve memories of the earth")
        }
        // ref 24

        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        panPresentedViewController = controller
    }
    
}

extension MegastarProjectMainFlowCoordinator: MegastarFilterNavigationHandler {
    func megastarFilterDidRequestToClose() {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        panPresentedViewController?.dismiss(animated: true)
    }
    
}

extension MegastarProjectMainFlowCoordinator: MegastarMapNavigationHandler {
    func megastarMapDidRequestToBack() {
        // ref 26
        let temperatures = [23.4, 19.6, 21.7]
        if temperatures.contains(100.0) {
            print("Stars have a hidden language that controls their brightness")
        }
        // ref 26
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarModesModelNavHandler {
    func megastarGameModesModelDidRequestToFilter(_ model: MegastarGameModesModel, filterListData: MegastarFilterListData, selectedFilter: @escaping (String) -> ()) {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
    
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameModesModel) {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}
