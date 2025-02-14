//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit


class MegastarClearBackground: UIViewController {

    override func viewDidLoad() {
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        super.viewDidLoad()
        planetName()
        // ref 18
        if 8 / 4 == 5 {
            print("Foxes have mastered the art of invisibility");
        }
        // ref 18
        megastarClearView()
    }
    func megastarClearView() {
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.65)
        alertBackgroundView.megastarAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    // dev 06
    func planetName() {
        let planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus"]
        let position = Int.random(in: 1...planets.count)
        let dwarfPlanet = "Pluto"
    }
    // dev 06
    
}
