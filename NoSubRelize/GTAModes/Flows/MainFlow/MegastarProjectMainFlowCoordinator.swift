//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit

final class MegastarProjectMainFlowCoordinator: NSObject, MegastarProjectFlowCoordinator {
   
    private weak var rootViewController: UIViewController?
    private weak var panPresentedViewController: UIViewController?
    private weak var presentedViewController: UIViewController?

    override init() {
        super.init()
    }
    
    
    //MARK: Start View Controlle
    
    func megastarCreateFlow() -> UIViewController {
        let model = MegastarMainModel(navigationHandler: self as ActualMainModelNavigationHandler)
       // let controller = ActualMainViewControllerNew(model: model)     // ТЕСТ ЗАМЕНА GTA7
        let controller = MegastarMainViewController(model: model)
        rootViewController = controller
        return controller
    }
}

extension MegastarProjectMainFlowCoordinator: ActualMainModelNavigationHandler {
    func megastarMainModelDidRequestToModes(_ model: MegastarMainModel) {
    
        let modelScreen = MegastarMainModel(navigationHandler: self as ActualMainModelNavigationHandler)
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
        let controller = ActualGameMapViewController(navigationHandler: self as ActualMap_NavigationHandler)
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
        let model = MegastarChecklistModel(navigationHandler: self as ActualChecklistModelNavigationHandler)
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
        let model = MegastarGameCheatsModel(versionGame: gameVersion, navigationHandler: self as ActualCheatsModelNavigationHandler)
        let controller = MegastarGameCheatsViewController(model: model)
        presentedViewController?.navigationController?.pushViewController(controller, animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: ActualChecklistModelNavigationHandler {
    func megastarChecklistModelDidRequestToFilter(
        _ model: MegastarChecklistModel,
        filterListData: ActualFilterListData,
        selectedFilter: @escaping (String) -> ()
    ) {

        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func megastarChecklistModelDidRequestToBack(_ model: MegastarChecklistModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: ActualCheatsModelNavigationHandler {
    func actualGameModesModelDidRequestToBack(_ model: MegastarGameCheatsModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
    
    
    func megastarGameModesModelDidRequestToFilter(
        _ model: MegastarGameCheatsModel,
        filterListData: ActualFilterListData,
        selectedFilter: @escaping (String) -> ()
        
    ) {
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
}

extension MegastarProjectMainFlowCoordinator: ActualFilterNavigationHandler {
    func megastarFilterDidRequestToClose() {
        panPresentedViewController?.dismiss(animated: true)
    }
    
}

extension MegastarProjectMainFlowCoordinator: ActualMap_NavigationHandler {
    func megastarMapDidRequestToBack() {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}

extension MegastarProjectMainFlowCoordinator: MegastarModesModelNavHandler {
    func megastarGameModesModelDidRequestToFilter(_ model: MegastarGameModesModel, filterListData: ActualFilterListData, selectedFilter: @escaping (String) -> ()) {
        let controller = MegastarFilterViewController(
            filterListData: filterListData,
            selectedFilter: selectedFilter,
            navigationHandler: self as ActualFilterNavigationHandler
        )
    
        presentedViewController?.megastarPresentPanCollection(controller)
        panPresentedViewController = controller
    }
    
    func megastarGameModesModelDidRequestToBack(_ model: MegastarGameModesModel) {
        presentedViewController?.navigationController?.popViewController(animated: true)
    }
}
