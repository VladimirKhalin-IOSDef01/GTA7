//
//  ActualFakeLoaderController.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 01.05.2024.
//

import Foundation
import UIKit

class ActualFakeLoader: UIViewController {
    var fakeLoaderView: HorizontalFakeLoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       //    actualBackgroundAlertView()
        //   setupFakeLoaderView(duration: 2)
 
    }
    func actualBackgroundAlertView() {
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.65)
        alertBackgroundView.actualAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }
    
    func setupFakeLoaderView(duration: TimeInterval) {
        fakeLoaderView = HorizontalFakeLoaderView(frame: CGRect(x: view.frame.width / 2 - 175, y: view.frame.height / 2 - 75, width: 350, height: 150))
     
        view.addSubview(fakeLoaderView)
        fakeLoaderView.startLoading(duration: duration)
    }
}
