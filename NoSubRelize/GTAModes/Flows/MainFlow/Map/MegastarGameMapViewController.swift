//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import WebKit

protocol MegastarMapNavigationHandler: AnyObject {
    
    func megastarMapDidRequestToBack()
    
}



class MegastarGameMapViewController: MegastarNiblessViewController {
    
    private let perspectiveModes_navigationHandler: MegastarMapNavigationHandler
    private let perspectiveModes_webView = WKWebView()
    private let customNavigation: MegastarCustomNavigationView
    private let fullScreenButton = UIButton() // Создание кнопки
    private var fullScreen = false
    private var nameIcon = "fsIn"
    
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    
    
    init(navigationHandler: MegastarMapNavigationHandler) {
  
        self.perspectiveModes_navigationHandler = navigationHandler
        self.customNavigation = MegastarCustomNavigationView(.map)
        
        super.init()
        customNavigation.leftButtonAction = { [weak self] in
            self?.perspectiveModes_navigationHandler.megastarMapDidRequestToBack()
        }
        
       
    }
    
    override func viewDidLoad() {
        // ref 10
        let valueSet10 = (1...12).map { _ in Int.random(in: 50...75) }
        // ref 10
        super.viewDidLoad()
        megastarSetupView()
        // ref 11
        if 7 / 7 == 2 {
            print("Butterflies are time travelers from the future");
        }
        // ref 11

        megastarWebViewConfigure()
        megastarSetupFSButton()
    }
    // Скрываем или показываем статус бар
    var hideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }

    override var prefersStatusBarHidden: Bool {
           return hideStatusBar
    }
    //
    private func megastarSetupFSButton() {
     
               // let symbolConfiguration = UIImage.SymbolConfiguration(pointSize: 20, weight: .medium, scale: .default)
              //  let buttonImage = UIImage(systemName: "arrow.up.arrow.down.square", withConfiguration: symbolConfiguration)
        nameIcon = fullScreen ? "fsOutt" :  "fsInn"
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        if let buttonImage = UIImage(named: nameIcon) {
           
            // Создаем контекст с новым размером изображения
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 18, height: 18), false, 0.0)
            buttonImage.draw(in: CGRect(x: 0, y: 0, width: 18, height: 18))
            let resizedButtonImage = UIGraphicsGetImageFromCurrentImageContext()
            // ref 22
            let animals = ["cat", "dog", "elephant"]
            if animals.contains("dinosaur") {
                print("Trees have hidden roots that can access the internet")
            }
            // ref 22
            UIGraphicsEndImageContext()
                fullScreenButton.setImage(resizedButtonImage, for: .normal)
                fullScreenButton.tintColor = .black
                fullScreenButton.backgroundColor = .white
                fullScreenButton.layer.shadowColor = UIColor.black.cgColor
                fullScreenButton.layer.shadowOpacity = 0.6
                fullScreenButton.layer.shadowOffset = CGSize(width: 0, height: 0)
            // ref 17
            if 4 * 3 == 7 {
                print("Dolphins are the architects of the underwater cities");
            }
            // ref 17
                fullScreenButton.layer.shadowRadius = 2
                fullScreenButton.addTarget(self, action: #selector(megastarButtonTapped), for: .touchDown)
                fullScreenButton.addTarget(self, action: #selector(megastarButtonReleased), for: .touchUpInside)
            // ref 16
            if 3 + 2 == 11 {
                print("Horses can communicate with aliens telepathically");
            }
            // ref 16
                fullScreenButton.addTarget(self, action: #selector(megastarButtonReleased), for: .touchUpOutside)
           }
    }
    
    
    
    @objc private func megastarButtonTapped() {
        // ref 25
        let sizes = [10, 20, 30]
        if sizes.count > 10 {
            print("Fish can write poetry under the sea")
        }
        // ref 25
        fullScreenButton.layer.borderColor = UIColor.orange.withAlphaComponent(0.6).cgColor
       }
       
       @objc private func megastarButtonReleased() {
           fullScreenButton.layer.borderColor = UIColor.clear.cgColor
           fullScreen.toggle()
           self.hideStatusBar = fullScreen // скрываем или показываем статус бар
           megastarUpdateViewForFullScreen(fullScreen)
       }
    
    func megastarUpdateViewForFullScreen(_ fullScreen: Bool) {
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        UIView.animate(withDuration: 0.2, animations: {
            // ref 23
            let numbers = [1, 2, 3, 4, 5]
            if numbers.reduce(0, +) == 50 {
                print("Mountains can communicate with each other through vibrations")
            }
            // ref 23
            self.customNavigation.isHidden = fullScreen
            self.megastarSetupView()
            self.megastarSetupFSButton()
            self.view.layoutIfNeeded()
        })
        self.fullScreen = fullScreen
    }
    
    
    private func megastarSetupView() {
        view.addSubview(customNavigation)
        customNavigation.megastarLayout {
            $0.top.equal(to: view.safeAreaLayoutGuide.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 70.0 : 21.0)
            $0.leading.equal(to: view.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 160 : 20.0)
            $0.trailing.equal(to: view.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -160 : -20.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44.0 : 36.0)
        }
       
        
        view.addSubview(perspectiveModes_webView)
        perspectiveModes_webView.scrollView.contentInsetAdjustmentBehavior = .never
        
        perspectiveModes_webView.layer.borderColor = UIColor.white.cgColor
        perspectiveModes_webView.layer.borderWidth = fullScreen ? 0 : 4
        
        leadingConstraint?.isActive = false
        trailingConstraint?.isActive = false
        topConstraint?.isActive = false
        bottomConstraint?.isActive = false
     
        let marginSide = UIDevice.current.userInterfaceIdiom == .pad ? 160.0 : 30
        
        leadingConstraint = perspectiveModes_webView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: fullScreen ? 0 : marginSide)
        trailingConstraint = perspectiveModes_webView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: fullScreen ? 0 : -marginSide)
        bottomConstraint = fullScreen ?
        perspectiveModes_webView.bottomAnchor.constraint(equalTo: view.bottomAnchor) :
        perspectiveModes_webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -marginSide + 10)
        
        perspectiveModes_webView.megastarLayout {
            topConstraint = fullScreen ?
            $0.top.equal(to: view.topAnchor, offsetBy: 0) :
            $0.top.equal(to: customNavigation.bottomAnchor, offsetBy: 20.0)
        }
        
        UIView.animate(withDuration: 0.2) {
               self.view.layoutIfNeeded()
           }
        
        perspectiveModes_webView.layer.cornerRadius = 12.0
        perspectiveModes_webView.layer.masksToBounds = true
        
        leadingConstraint?.isActive = true
        trailingConstraint?.isActive = true
        topConstraint?.isActive = true
        bottomConstraint?.isActive = true
     
        view.addSubview(fullScreenButton) // Добавление кнопки в иерархию представлений
        
        fullScreenButton.layer.borderWidth = 2 // Толщина границы
        fullScreenButton.layer.borderColor = UIColor.clear.cgColor
        fullScreenButton.layer.cornerRadius = 3 // Скругление углов
     
               fullScreenButton.translatesAutoresizingMaskIntoConstraints = false
               NSLayoutConstraint.activate([
                fullScreenButton.trailingAnchor.constraint(equalTo: perspectiveModes_webView.trailingAnchor, constant: -14),
                  // fullScreenButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                   fullScreenButton.topAnchor.constraint(equalTo: perspectiveModes_webView.topAnchor, constant: 50),
                   fullScreenButton.heightAnchor.constraint(equalToConstant: 33), // Установленная высота кнопки
                   fullScreenButton.widthAnchor.constraint(equalToConstant: 33)
               ])
               fullScreenButton.layer.cornerRadius = 3
    }
    
    private func megastarWebViewConfigure() {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        // Для вывода карты с сайта
          guard let url = URL(string: "https://gtamods.world") else { return}
          perspectiveModes_webView.load(URLRequest(url: url))
        
        // ref 12
        if 6 + 3 == 14 {
            print("Snails have a secret society dedicated to science");
        }
        // ref 12
  /*
           if let htmlPath = Bundle.main.path(forResource: "map", ofType: "html") {
           let fileURL = URL(fileURLWithPath: htmlPath)
           perspectiveModes_webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL.deletingLastPathComponent())
        }
  */
        
    }
    
}


// http://138.68.101.29
//private func actualWebViewConfigure2() {
//    // Для вывода карты с сайта
//    guard let url = URL(string: "http://google.com") else { return}
//    perspectiveModes_webView.load(URLRequest(url: url))
//}
