//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import Network

typealias MegastarTestNetworkExtension = UIViewController
extension MegastarTestNetworkExtension {
    func megastarTopMostViewController() -> UIViewController {
        if let presented = self.presentedViewController {
            return presented.megastarTopMostViewController()
        }
    
        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.megastarTopMostViewController() ?? navigation
        }
    
        if let tab = self as? UITabBarController {
            return tab.selectedViewController?.megastarTopMostViewController() ?? tab
        }
        return self
    }
}
class MegastarNetworkStatusMonitor {
    
    static let shared = MegastarNetworkStatusMonitor()
    private let queue = DispatchQueue.global()
    private let nwMonitor: NWPathMonitor
    
    private var alertPresented = false
    private var previousNetworkAvailable: Bool?
    
    public private(set) var isNetworkAvailable: Bool = false {
        didSet {
           
            if previousNetworkAvailable != isNetworkAvailable {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, !self.alertPresented else { return }

                    if !isNetworkAvailable {
                        showCustomAlert()
                    }
                    let message = self.isNetworkAvailable ? "Internet connection is active." : "No internet connection."
                    print(message)
                }
            }
            previousNetworkAvailable = isNetworkAvailable
        }
    }
    
    private init() {
        nwMonitor = NWPathMonitor()
        nwMonitor.pathUpdateHandler = { [weak self] path in
            let isNetworkAvailable = path.status == .satisfied
           
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                print("Network status changed. Is network available? \(isNetworkAvailable)") // Для диагностики
                self?.isNetworkAvailable = isNetworkAvailable
            }
        }
    }
    
    func megastarStartMonitoring() {
        nwMonitor.start(queue: queue)
    }
    
    func megastarStopMonitoring() {
        nwMonitor.cancel()
    }
   
    func showCustomAlert() {
        guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return
        }
        // Закрываем все алерты
        rootViewController.dismiss(animated: false, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let topViewController = rootViewController.megastarTopMostViewController()
            let alertController = MegastarAllertController()
            alertController.megastarCustomAlert(alertType: .internet)
            alertController.modalPresentationStyle = .overFullScreen // Чтобы алерт был модальным и занимал весь экран
            if !(topViewController is UIAlertController) {
                topViewController.present(alertController, animated: false) {
                    //  alertController.dismiss(animated: true, completion: nil)
                    //   self.alertPresented = false
                    
                }
            }
        }
    }
}



/*
class PerspectiveNetworkStatusMonitor {
    static let shared = PerspectiveNetworkStatusMonitor()
    private let queue = DispatchQueue.global()
    private let nwMonitor: NWPathMonitor
    
    private var alertPresented = false
    private var previousNetworkAvailable: Bool?
    
    public private(set) var isNetworkAvailable: Bool = false {
        didSet {
            if previousNetworkAvailable != isNetworkAvailable {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self, !self.alertPresented else { return }
                    
                 //   ActualAlertManager.shared.actualShowAlert()
                    
                    let message = self.isNetworkAvailable ? "Internet connection is active." : "No internet connection."
                    self.showAlert(message: message)
                    print(message)
                }
            }
            previousNetworkAvailable = isNetworkAvailable
        }
    }
    
    private init() {
        nwMonitor = NWPathMonitor()
        nwMonitor.pathUpdateHandler = { [weak self] path in
            let isNetworkAvailable = path.status == .satisfied
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                
                print("Network status changed. Is network available? \(isNetworkAvailable)") // Для диагностики
                self?.isNetworkAvailable = isNetworkAvailable
            }
        }
    }
    
    func megastarStartMonitoring() {
        nwMonitor.start(queue: queue)
    }
    
    func megastarStopMonitoring() {
        nwMonitor.cancel()
    }
   
    private func showAlert(message: String) {
       // if message == "Internet connection is active." { return }
        guard let rootViewController = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController else {
            return
        }
        let topViewController = rootViewController.topMostViewController()
        let alert = UIAlertController(title: "Network Status", message: message, preferredStyle: .alert)
       
        if !(topViewController is UIAlertController) {
            topViewController.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    alert.dismiss(animated: true, completion: nil)
                    self.alertPresented = false
                }
            }
        }
    }
}
*/


/*
 didSet {
     // Проверка на изменение состояния сети и на необходимость показа алерта
     if let previous = previousNetworkAvailable, previous != isNetworkAvailable {
         showNetworkChangeAlertIfNeeded()
     } else if previousNetworkAvailable == nil && !isNetworkAvailable {
         // Случай, когда при первой проверке сеть недоступна
         showNetworkChangeAlertIfNeeded()
     }
     previousNetworkAvailable = isNetworkAvailable
 }
 */
