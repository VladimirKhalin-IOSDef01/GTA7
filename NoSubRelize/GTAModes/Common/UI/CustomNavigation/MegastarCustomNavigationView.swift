//
//  CustomNavigationView.swift
//  GTAModes
//
//  Created by Максим Педько on 09.08.2023.
//

import Foundation
import UIKit

public enum MegastarNavType {
    
    case main, gameSelect, gameModes, checkList, map, infoModes
    
}

public final class MegastarCustomNavigationView: MegastarNiblessView {

    public var leftButtonAction: (() -> Void)?
    public var rightButtonAction: (() -> Void)?
    private let leftButton = UIButton(type: .custom)
    private let titleLabel = UILabel()
    private let rightButton = UIButton(type: .custom)
    private let type: MegastarNavType
    private let titleString: String?
    
    public init(_ type: MegastarNavType, titleString: String? = nil) {
      self.type = type
      self.titleString = titleString
      super.init()
      megastarInitialConfiguration()
    }
    
}

extension MegastarCustomNavigationView {
   
    private func megastarInitialConfiguration() {
        backgroundColor = .clear
        
        addSubviews(leftButton, rightButton, titleLabel)
        
        switch type {
        case .main:
            megastarAddClearButton()
            megastarAddTitle("Menu")
            
        case .gameSelect:
            megastarAddLeftButton(UIImage(named: "ActualNBleft") ?? UIImage())
            megastarAddClearButton()
            megastarAddTitle("Version menu")
            //  megastarAddTitle("")
            
        case .gameModes:
            megastarAddLeftButton(UIImage(named: "ActualNBleft") ?? UIImage())
           // megastarAddClearButton()
            megastarAddFilterButton()
            // megastarAddTitle(titleString ?? "Cheats")
            switch titleString {
            case "GTA6":  megastarAddTitle("Version 6")
            case "GTA5":  megastarAddTitle("Version 5")
            case "GTAVC":  megastarAddTitle("Version VS")
            case "GTASA":  megastarAddTitle("Version SA")
            case "Mods Version 5":  megastarAddTitle("Mods version 5")
            default :  megastarAddTitle("Cheats")
            }
            
        case .checkList:
            megastarAddLeftButton(UIImage(named: "ActualNBleft") ?? UIImage())
            megastarAddFilterButton()
            megastarAddTitle("Checklist")
            
        case .map:
            megastarAddLeftButton(UIImage(named: "ActualNBleft") ?? UIImage())
            megastarAddClearButton()
            megastarAddTitle("Map")
            
        case .infoModes:
            megastarAddLeftButton(UIImage(named: "BackArr") ?? UIImage())
            megastarAddClearButton()
            megastarAddTitle("Mods version 5")
        
        }
    }
    
    private func megastarAddClearButton() {
        
        rightButton.megastarLayout {
            $0.trailing.equal(to: self.trailingAnchor)
            $0.top.equal(to: self.topAnchor)
            $0.bottom.equal(to: self.bottomAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44 : 32.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 39 : 39.0)
        }
        
        rightButton.setImage(UIImage(named: ""), for: .normal)
        
        // rightButton.addTarget(self, action: #selector(gtavk_filterButton_Action), for: .touchUpInside)
    }
    
    private func megastarAddFilterButton() {
        rightButton.contentMode = .scaleAspectFit
        rightButton.megastarLayout {
            $0.leading.equal(to: self.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 60 : 40)
           // $0.top.equal(to: self.topAnchor, offsetBy: 0)
           // $0.bottom.equal(to: self.bottomAnchor)
            $0.centerY.equal(to: self.centerYAnchor)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 46 : 34.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 42 : 29.0)
        }
        
        rightButton.setImage(UIImage(named: "ActualFilter"), for: .normal)
        if UIDevice.current.userInterfaceIdiom == .pad {
            megastarSetupIpadButton(_image: "ActualFilter", buttonName: "rightButton")
        }
        
        rightButton.addTarget(self, action: #selector(megastarFilterButton_Action), for: .touchUpInside)
    }
    
    private func megastarAddLeftButton(_ image: UIImage) {
        
       // leftButton.contentMode = .scaleToFill
        leftButton.clipsToBounds = true
        
        leftButton.megastarLayout {
            $0.leading.equal(to: self.leadingAnchor, offsetBy: 5)
            $0.top.equal(to: self.topAnchor, offsetBy: 5)
            $0.bottom.equal(to: self.bottomAnchor, offsetBy: 0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 44 : 31.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 26)
        }
       // leftButton.setImage(image, for: .normal)
       // if UIDevice.current.userInterfaceIdiom == .pad {
            megastarSetupIpadButton(_image: "MegastarBack", buttonName: "leftButton")
      //  }
        leftButton.addTarget(self, action: #selector(megastarLeftBarButton_Tapped), for: .touchUpInside)
    }
    
    private func megastarAddTitle(_ title: String) {
  
        titleLabel.textAlignment = .center
        titleLabel.megastarLayout {
           // $0.leading.equal(to: leftButton.trailingAnchor, offsetBy: 15)
           // $0.trailing.equal(to: rightButton.leadingAnchor, offsetBy: -15)
            $0.trailing.equal(to: self.trailingAnchor)
            $0.centerY.equal(to: self.centerYAnchor)
        }
        titleLabel.text = title
       // titleLabel.text = title.capitalized
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 46 : 32)
        titleLabel.textColor = .white
    }
    
    @objc
    private func megastarFilterButton_Action() {
        rightButtonAction?()
    }
    
    @objc
    private func megastarLeftBarButton_Tapped() {
        leftButtonAction?()
    }
    
    func megastarResizeImage(image: UIImage, scale: CGFloat) -> UIImage {
        let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: newSize))
  
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? image
    }
    
    func megastarSetupIpadButton(_image name: String, buttonName: String) {
      
        
        if let originalImage = UIImage(named: name) {
            let resizedImage = megastarResizeImage(image: originalImage, scale: 1.8)
            
            buttonName == "leftButton" ? leftButton.setImage(resizedImage, for: .normal) : rightButton.setImage(resizedImage, for: .normal)
        }
       
        leftButton.addTarget(self, action: #selector(megastarLeftBarButton_Tapped), for: .touchUpInside)
    }
}
