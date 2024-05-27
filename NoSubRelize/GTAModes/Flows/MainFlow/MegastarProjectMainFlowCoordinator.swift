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
        let model = MegastarMainModel(navigationHandler: self as MegastarMainModelNavigationHandler)
       // let controller = ActualMainViewControllerNew(model: model)     // ТЕСТ ЗАМЕНА GTA7
        let controller = MegastarMainViewController(model: model)
        rootViewController = controller
        return controller
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarMainModelNavigationHandler {
    func megastarMainModelDidRequestToModes(_ model: MegastarMainModel) {
    
        let modelScreen = MegastarMainModel(navigationHandler: self as MegastarMainModelNavigationHandler)
        let model = MegastarGameModesModel(navigationHandler: self as MegastarModesModelNavHandler)
        let controller = MegastarModesViewController(model: model, modelScreen: modelScreen)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToModesInfo(_ model: MegastarMainModel) {
        let model = MegastarGameModesModel(navigationHandler: self as MegastarModesModelNavHandler)
        let controller = MegastarModesInfoViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToMap(_ model: MegastarMainModel) {
        let controller = MegastarGameMapViewController(navigationHandler: self as MegastarMapNavigationHandler)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToGameSelection(_ model: MegastarMainModel) {
        let model = MegastarGSModel(navigationHandler: self as MegastarGSModelNavigationHandler)
        let controller = MegastarGSViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
    func megastarMainModelDidRequestToChecklist(_ model: MegastarMainModel) {
        let model = MegastarChecklistModel(navigationHandler: self as MegastarChecklistModelNavigationHandler)
        let controller = MegastarChecklistViewController(model: model)
        presentedViewController = controller
        rootViewController?.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension MegastarProjectMainFlowCoordinator: MegastarGSModelNavigationHandler {
    func megastarGsModelDidRequestToBack(_ model: MegastarGSModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    func megastarGsModelDidRequestToGameModes(_ model: MegastarGSModel, gameVersion: String) {
        let model = MegastarGameCheatsModel(versionGame: gameVersion, navigationHandler: self as MegastarCheatsModelNavigationHandler)
        let controller = MegastarGameCheatsViewController(model: model)
        presentedViewController?.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarChecklistModelNavigationHandler {
    func megastarChecklistModelDidRequestToFilter(
        _ model: MegastarChecklistModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
    ) {

        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func megastarChecklistModelDidRequestToBack(_ model: MegastarChecklistModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarCheatsModelNavigationHandler {
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameCheatsModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func megastarGameModesModelDidRequestToFilter(
        _ model: MegastarGameCheatsModel,
        filterListData: MegastarFilterListData,
        selectedFilter: @escaping (String) -> ()
        
    ) {
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
}

extension MegastarProjectMainFlowCoordinator: MegastarFilterNavigationHandler {
    func megastarFilterDidRequestToClose() {
        panPresentedViewController?.dismiss(animated: true)
    }
    
}

extension MegastarProjectMainFlowCoordinator: MegastarMapNavigationHandler {
    func megastarMapDidRequestToBack() {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarModesModelNavHandler {
    func megastarGameModesModelDidRequestToFilter(_ model: MegastarGameModesModel, filterListData: MegastarFilterListData, selectedFilter: @escaping (String) -> ()) {
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as MegastarFilterNavigationHandler
        )
    
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameModesModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}
