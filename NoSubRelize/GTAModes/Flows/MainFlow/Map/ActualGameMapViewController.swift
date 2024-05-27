//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit
import WebKit

protocol ActualMap_NavigationHandler: AnyObject {
    
    func megastarMapDidRequestToBack()
    
}



class ActualGameMapViewController: MegastarNiblessViewController {
    
    private let perspectiveModes_navigationHandler: ActualMap_NavigationHandler
    private let perspectiveModes_webView = WKWebView()
    private let customNavigation: MegastarCustomNavigationView
    private let fullScreenButton = UIButton() // Создание кнопки
    private var fullScreen = false
    private var nameIcon = "fsIn"
    
    private var leadingConstraint: NSLayoutConstraint?
    private var trailingConstraint: NSLayoutConstraint?
    private var topConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    
    
    
    init(navigationHandler: ActualMap_NavigationHandler) {
  
        self.perspectiveModes_navigationHandler = navigationHandler
        self.customNavigation = MegastarCustomNavigationView(.map)
        
        super.init()
        customNavigation.leftButtonAction = { [weak self] in
            self?.perspectiveModes_navigationHandler.megastarMapDidRequestToBack()
        }
        
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        megastarSetupView()
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
       
        if let buttonImage = UIImage(named: nameIcon) {
           
            // Создаем контекст с новым размером изображения
            UIGraphicsBeginImageContextWithOptions(CGSize(width: 18, height: 18), false, 0.0)
            buttonImage.draw(in: CGRect(x: 0, y: 0, width: 18, height: 18))
            let resizedButtonImage = UIGraphicsGetImageFromCurrentImageContext()
   
            UIGraphicsEndImageContext()
                fullScreenButton.setImage(resizedButtonImage, for: .normal)
                fullScreenButton.tintColor = .black
                fullScreenButton.backgroundColor = .white
                fullScreenButton.layer.shadowColor = UIColor.black.cgColor
                fullScreenButton.layer.shadowOpacity = 0.6
                fullScreenButton.layer.shadowOffset = CGSize(width: 0, height: 0)
                fullScreenButton.layer.shadowRadius = 2
                fullScreenButton.addTarget(self, action: #selector(megastarButtonTapped), for: .touchDown)
                fullScreenButton.addTarget(self, action: #selector(megastarButtonReleased), for: .touchUpInside)
                fullScreenButton.addTarget(self, action: #selector(megastarButtonReleased), for: .touchUpOutside)
           }
    }
    
    
    
    @objc private func megastarButtonTapped() {
        fullScreenButton.layer.borderColor = UIColor.orange.withAlphaComponent(0.6).cgColor
       }
       
       @objc private func megastarButtonReleased() {
           fullScreenButton.layer.borderColor = UIColor.clear.cgColor
           fullScreen.toggle()
           self.hideStatusBar = fullScreen // скрываем или показываем статус бар
           megastarUpdateViewForFullScreen(fullScreen)
       }
    
    func megastarUpdateViewForFullScreen(_ fullScreen: Bool) {
        UIView.animate(withDuration: 0.2, animations: {
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
  //        Для вывода карты с сайта
  //        guard let url = URL(string: "https://yandex.com") else { return}
  //        perspectiveModes_webView.load(URLRequest(url: url))
        
  
        if let htmlPath = Bundle.main.path(forResource: "map", ofType: "html") {
            let fileURL = URL(fileURLWithPath: htmlPath)
           
            perspectiveModes_webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL.deletingLastPathComponent())
        }
  
    }
    
}


// http://138.68.101.29
//private func actualWebViewConfigure2() {
//    // Для вывода карты с сайта
//    guard let url = URL(string: "http://google.com") else { return}
//    perspectiveModes_webView.load(URLRequest(url: url))
//}
