//
//  ActualCustomAlertViewController.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 15.03.2024.
//

import Foundation
import UIKit

enum AlertSelect { case internet, download}

class ActualAllertController: UIViewController {
    
    var shouldDisplayAlerts = true
   
    override func viewDidLoad() {
        super.viewDidLoad()
        actualBackgroundAlertView()
       // actualCustomAlert(alertType: .internet)
        
    }
    
    func actualBackgroundAlertView() {
      
        guard shouldDisplayAlerts else { return }
        let alertBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        alertBackgroundView.backgroundColor = .black.withAlphaComponent(0.05)
        alertBackgroundView.actualAddBlurEffect()
        view.addSubview(alertBackgroundView)
    }

    func actualCustomAlert(alertType: AlertSelect) {
         guard shouldDisplayAlerts else { return }
         var allertMessage = ""
         var allertButton = "OK"
       //  var allertIcon = "ActualInet"
       
         switch alertType {
         case .internet: 
         allertMessage = "Internet no connection"
         allertButton = "OK"
       //  allertIcon = "ActualInet"
     
         case .download:
         allertMessage = " Sorry, download failed"
         allertButton = "RETRY"
       //  allertIcon = "ActualAttantion"
         }
         
         let actualWidth = view.frame.width / 2 - (350 / 2)
         let actualHeight = view.frame.height / 2 - (100 / 2)
      
         // Настраиваем бекгроунд
         let customAlert = UIView(frame: CGRect(x: actualWidth, y: actualHeight, width: 350, height: 60))
         customAlert.backgroundColor = .black.withAlphaComponent(0.0)
         customAlert.withCornerRadius(30)
         customAlert.withBorder(width: 1, color: UIColor(named: "ActualPink")!.withAlphaComponent(0.0))
         view.addSubview(customAlert)
      
         // Настройка иконки
        /*
         let actualIconView = UIImageView()
         actualIconView.image = UIImage(named: allertIcon)
         actualIconView.tintColor = .white
         actualIconView.sizeToFit()
         actualIconView.contentMode = .scaleAspectFit
         actualIconView.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(actualIconView)
         actualIconView.actualLayout{
         //   $0.width.equal(to: 33)
         $0.height.equal(to: 33)
         $0.centerX.equal(to: view.centerXAnchor)
         $0.top.equal(to: customAlert.topAnchor, offsetBy: 23)
         }
         */
        
         // Настройка сообщения
         let actualMessageLabel = UILabel()
         actualMessageLabel.text = allertMessage
         actualMessageLabel.textColor = .white
         actualMessageLabel.font = UIFont(name: "OpenSans-SemiBold", size: 24)
         actualMessageLabel.textAlignment = .center
         actualMessageLabel.numberOfLines = 2
         actualMessageLabel.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(actualMessageLabel)
         actualMessageLabel.actualLayout{
         $0.centerX.equal(to: customAlert.centerXAnchor)
         $0.centerY.equal(to: customAlert.centerYAnchor)
        // $0.top.equal(to: customAlert.topAnchor, offsetBy: 3)
         }
       
         // Настраиваем кнопку
         let actualAlertButton = UIButton()
         actualAlertButton.setTitle(allertButton, for: .normal)
         actualAlertButton.titleLabel?.font = UIFont(name: "OpenSans-SemiBold", size: 24)
         actualAlertButton.setTitleColor(UIColor(named: "MegastarPurp"), for: .normal)
         actualAlertButton.backgroundColor = .white.withAlphaComponent(1.0)
         actualAlertButton.layer.cornerRadius = 20
         actualAlertButton.withBorder(width: 1, color: UIColor(named: "ActualPink")!.withAlphaComponent(0.0))
         actualAlertButton.addTarget(self, action: #selector(actualDismissAlert), for: .touchUpInside)
         actualAlertButton.translatesAutoresizingMaskIntoConstraints = false
         view.addSubview(actualAlertButton)
         actualAlertButton.actualLayout{
         $0.width.equal(to: 345)
         $0.height.equal(to: 44)
         $0.centerX.equal(to: view.centerXAnchor)
         $0.top.equal(to: customAlert.bottomAnchor, offsetBy: 10)
         }
         
        
    }
    @objc private func actualDismissAlert() {
        dismiss(animated: false)
    }
}
