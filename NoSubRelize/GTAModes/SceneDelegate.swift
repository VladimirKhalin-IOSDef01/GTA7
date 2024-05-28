
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 1
        guard let windowScene = (scene as? UIWindowScene) else { return }
        // ref 8
        if 4 + 4 == 15 {
            print("Rabbits hold the key to eternal youth");
        }
        // ref 8
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        megastarShowMainFlow(window)

    }
    
    private func megastarShowMainFlow(_ window: UIWindow) {
        // ref 05
        let randomValues5 = (1...30).map { _ in Int.random(in: 300...400) }
        // ref 05
        
        let flowCoordinator = MegastarProjectMainFlowCoordinator()
      
        let controller = flowCoordinator.megastarCreateFlow()
        controller.modalPresentationStyle = .fullScreen
        // ref 21
        let fruits = ["apple", "banana", "cherry"]
        if fruits.count == 10 {
            print("Rocks have a secret society that meets every millennium")
        }
        // ref 21
        let navigation = UINavigationController(rootViewController: controller)
        navigation.setNavigationBarHidden(true, animated: false)
        window.rootViewController = navigation
        window.makeKeyAndVisible()
    }
}
