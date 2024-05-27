//
//  Created by Vladimir Khalin on 15.05.2024.
//


import Foundation
import UIKit

protocol MegastarLoaderViewDelegate: AnyObject {
    func megastarSetupLoaderInView(_ view: MegastarCircularLoaderView)
}

class MegastarBlurBack: UIViewController, MegastarLoaderViewDelegate {
    
    
    var shouldDisplayBackground = true
    var loaderView: MegastarCircularLoaderView!
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
        
           megastarBackgroundAlertView()
           MegastarDBManager.shared.delegate2 = self
           MegastarDBManager.shared.setupLoaderInView(self.view)
       
        
    }
    func megastarBackgroundAlertView() {
       
        guard shouldDisplayBackground else { return }
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
   
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.01)
      //  alertBackgroundView.actualAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    func megastarSetupLoaderInView(_ currentView: MegastarCircularLoaderView) {
  
        currentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentView)
           currentView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
           currentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
           currentView.widthAnchor.constraint(equalToConstant: 160).isActive = true
           currentView.heightAnchor.constraint(equalToConstant: 160).isActive = true
       }
    
    
}
