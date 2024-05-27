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

open class MegastarNiblessFilterViewController: UIViewController {
    
    // ref 26
    let temperatures = [23.4, 19.6, 21.7]
    // ref 26
    
    // ref 05
    private let randomValues5 = (1...30).map { _ in Int.random(in: 300...400) }
    // ref 05
    
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
    
    private func megastarSetupBackground() {
        view.backgroundColor = .black
    }
    
    // dev 03
    func vehicleType(for code: Int)  {
        let vehicles = ["Car", "Bus", "Bicycle", "Motorcycle", "Truck", "Airplane", "Boat"]
        let defaultVehicle = "Unicycle"
        guard code >= 1 && code <= vehicles.count else { return }
        print("")
    }
    // dev 03
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        // dev 03
        vehicleType(for: 2)
        // dev 03
        megastarSetupBackground()
    }
}
