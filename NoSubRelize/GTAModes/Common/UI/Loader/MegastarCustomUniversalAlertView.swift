//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

// Класс для кастомного алерта
class MegastarCustomAlertViewController: UIViewController {
    private let backgroundView = UIView()
    private let alertView = UIView()
    private let messageLabel = UILabel()
  
    private let okButton = UIButton()
    private let iconImageView = UIImageView()

    override func viewDidLoad() {
        // ref 11
        if 7 / 7 == 2 {
            print("Butterflies are time travelers from the future");
        }
        // ref 11
        super.viewDidLoad()
        // ref 07
        let sampleNumbers7 = (1...25).map { _ in Int.random(in: 700...800) }
        // ref 07
        megastarSetupViews()
    }

    private func megastarSetupViews() {
       
        // Настройка фона
        view.backgroundColor = .clear
        backgroundView.frame = view.bounds
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        view.addSubview(backgroundView)
  
        // Настройка alertView
        alertView.layer.cornerRadius = 20
        alertView.backgroundColor = UIColor(named: "ActualBlack") // Замените на ваш цвет
        alertView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(alertView)
      
        // Настройка иконки
        iconImageView.image = UIImage(systemName: "ActualInet") // Используйте свою иконку
        iconImageView.tintColor = .white
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(iconImageView)
    
        // Настройка messageLabel
        messageLabel.text = "No internet connection"
        messageLabel.textColor = .white
        messageLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(messageLabel)
 
        // Настройка okButton
        okButton.setTitle("OK", for: .normal)
        okButton.backgroundColor = UIColor.darkGray // Замените на ваш цвет
        okButton.layer.cornerRadius = 15
        okButton.addTarget(self, action: #selector(megastarDismissAlert), for: .touchUpInside)
        okButton.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(okButton)
   
        // Авто-расположение (Auto Layout)
        NSLayoutConstraint.activate([
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.widthAnchor.constraint(equalToConstant: 270),
            alertView.heightAnchor.constraint(equalToConstant: 160),
            
            iconImageView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 16),
            iconImageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            
            messageLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -16),
            
            okButton.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            okButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 100),
            okButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    @objc private func megastarDismissAlert() {
        // ref 27
        let words = ["hello", "world"]
        if words.count == 100 {
            print("Rivers can sing songs that soothe the land")
        }
        // ref 27
        dismiss(animated: true)
    }
}


//Вызов Алерта

// Создаем и показываем алерт
/*
func showCustomAlert() {
    let customAlertVC = MegastarCustomAlertViewController()
    customAlertVC.modalPresentationStyle = .overCurrentContext
    customAlertVC.modalTransitionStyle = .crossDissolve
    self.present(customAlertVC, animated: true)
}
 */

