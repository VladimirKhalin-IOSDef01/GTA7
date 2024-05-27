//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

open class MegastarNiblessViewController: UIViewController {
   
    private lazy var waterBackground: UIImageView = {
        let waterBack = UIImageView()
        if  UIDevice.current.userInterfaceIdiom == .pad {
            waterBack.image = UIImage(named: "MegastarBGbig")
        } else {
            waterBack.image = UIImage(named: "MegastarBGsmall")
        }
        waterBack.contentMode = .scaleToFill
        waterBack.translatesAutoresizingMaskIntoConstraints = false
        waterBack.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        waterBack.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
       return waterBack
    }()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Init is not implemented")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
 
        view.megastarSetGradientBackground()
        view.addSubview(waterBackground)
        waterBackground.alpha = 1.0
    //    gtavk_setupBackground()
        
    }
    
//    private func gtavk_setupBackground() {
//        let backgroundImageView = UIImageView(frame: view.bounds)
//        backgroundImageView.image = UIImage(named: "bg")
//        backgroundImageView.contentMode = .scaleAspectFill
//        view.addSubview(backgroundImageView)
//        view.sendSubviewToBack(backgroundImageView)
//    }
    


}

open class ActualNiblessFilterViewController: UIViewController {
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required public init?(coder aDecoder: NSCoder) {
        fatalError("Init is not implemented")
    }
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    private func actualSetupBackground() {
        view.backgroundColor = .black
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
 
        actualSetupBackground()
    }
}
