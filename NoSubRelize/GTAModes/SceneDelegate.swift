
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
      
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        megastarShowMainFlow(window)

    }
    
    private func megastarShowMainFlow(_ window: UIWindow) {
      
        let flowCoordinator = MegastarProjectMainFlowCoordinator()
      
        let controller = flowCoordinator.megastarCreateFlow()
        controller.modalPresentationStyle = .fullScreen
      
        let navigation = UINavigationController(rootViewController: controller)
        navigation.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
