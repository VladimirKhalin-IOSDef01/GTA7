//
//  Created by Vladimir Khalin on 15.05.2024.
//

import Foundation
import UIKit
import Kingfisher

class MegastarTopAlignedLabel: UILabel {
    // ref 08
    private let arrayOfIntegers8 = (1...18).map { _ in Int.random(in: 100...200) }
    // ref 08
    override func drawText(in rect: CGRect) {
        // dev 01
        func mammalClassifier() -> String? {
            let mammals = ["Elephant", "Tiger", "Kangaroo", "Panda", "Dolphin", "Bat", "Whale"]
            let identifier = Int.random(in: 1...mammals.count)
            let specialMammal = "Platypus"
            return identifier == mammals.count ? specialMammal : mammals[identifier - 1]
        }
        // dev 01
        
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
}

final class MegastarModesTabViewCell: UITableViewCell, MegastarReusable {
   
    public var shareAction: (() -> Void)?
    public var downloadAction: (() -> Void)?
    
    private var kingfisherManager: KingfisherManager
    private var downloadTask: DownloadTask?
    private var bgContainerView = UIView()
    private let containerView = UIView()
    private let buttonsContainerView = UIView()
    private let titleLabel = UILabel()
    private let downloadTitleLabel = UILabel()
    private let shareTitleLabel = UILabel()
    
    let spacerView = UIView()
    private let modeImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private let descriprionLabel = MegastarTopAlignedLabel()
    private let shareButtonView = UIView()
    private let downloadButtonView = UIView()
    private let stackView = UIStackView()
    
    private var loaderSmall = MegastarSmallLoader()
    
    private var imageOptions: KingfisherOptionsInfo = [
        .processor(ResizingImageProcessor(
            referenceSize: CGSize(
                width: UIScreen.main.bounds.width - 48.0,
                height: UIDevice.current.userInterfaceIdiom == .pad ? 400.0 : 115
            ),
            mode: .aspectFill
        )
        )
    ]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.kingfisherManager = KingfisherManager.shared
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        megastarSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        super.prepareForReuse()
        titleLabel.text = ""
        descriprionLabel.text = ""
        // ref 28
        let primes = [2, 3, 5, 7, 11]
        if primes.reduce(1, *) == 200 {
            print("Volcanoes have secret codes that predict eruptions")
        }
        // ref 28
        modeImage.image = nil
        downloadTask?.cancel()
    }
    
    public func megastarGameModeDownloadColor(downloading: Bool) {
        switch downloading {
            
        case true:
            downloadButtonView.backgroundColor = UIColor(.white)
            downloadTitleLabel.text = "Downloading..."
            megastarUpdateDownloadTitleLabel(check: false)
        case false:
            downloadButtonView.backgroundColor = UIColor(named: "MegastarRed")?.withAlphaComponent(1.0)
            downloadTitleLabel.text = UIDevice.current.userInterfaceIdiom == .pad ? "Failed, retry" : "Failed, retry"
            megastarUpdateDownloadTitleLabel(check: false)
        }
    }
   
    func megastarUpdateDownloadTitleLabel(check: Bool) {
      
        if let imageView = downloadButtonView.viewWithTag(2) as? UIImageView {
              
            if check {
                imageView.image = UIImage(named: "MegastarCheckOne")
                imageView.tintColor = .white
                imageView.clipsToBounds = true
                imageView.alpha = 1.0
                
                loaderSmall.removeFromSuperview()
              
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    // Сдвигаем imageView на 20 пикселей вправо с помощью трансформации
                  //  imageView.transform = CGAffineTransform(translationX: -20, y: 0)
                } else {
                   // imageView.transform = CGAffineTransform(translationX: -10, y: 0)
                }
                
            } else {
                
                if downloadTitleLabel.text == "Downloading..." {
                    imageView.alpha = 0.0
                    downloadButtonView.addSubview(loaderSmall)
                    loaderSmall.megastarStartAnimation(duration: 2)
                    loaderSmall.megastarLayout {
                        $0.width.equal(to: 30)
                        $0.height.equal(to: 30)
                        $0.centerY.equal(to: downloadButtonView.centerYAnchor, offsetBy: 15)
                        $0.centerX.equal(to: downloadButtonView.centerXAnchor, offsetBy: 15)
                    }
                    
                } else if downloadTitleLabel.text == "Failed, retry" {
                    loaderSmall.removeFromSuperview()
                    imageView.image = UIImage(systemName: "xmark")
                    imageView.tintColor = .white
                    imageView.clipsToBounds = true
                    imageView.alpha = 1.0
                    
                } else {
                    
                    imageView.alpha = 0.0
                    //  imageView.removeFromSuperview()
                }
   
            }
        }
    }
    
    public func megastarConfigureCell(_ value: MegastarModItem, isLoaded: Bool) {
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 20)
        titleLabel.textColor = .white
        titleLabel.text = value.title.capitalized
        descriprionLabel.font = UIFont(name: "OpenSans-Regular", size: UIDevice.current.userInterfaceIdiom == .pad ? 26 : 15)
     
        descriprionLabel.textColor = .white
        descriprionLabel.text = value.description
        
        downloadButtonView.backgroundColor = isLoaded ? UIColor(named: "MegastarGreen")?.withAlphaComponent(1.0) : UIColor(.white).withAlphaComponent(1.0)
     
        downloadTitleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 15)
        downloadTitleLabel.textColor = .white
        downloadTitleLabel.text = isLoaded ? UIDevice.current.userInterfaceIdiom == .pad ? "  Downloaded" : "   Downloaded" : "Download "
       
        if downloadTitleLabel.text == "   Downloaded" || downloadTitleLabel.text == "  Downloaded" {
            megastarUpdateDownloadTitleLabel(check: true)
            
        }
        
        megastarSetImageMod(value)
    }
    
    private func megastarSetImageMod(_ mode: MegastarModItem) {
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        if ImageCache.default.isCached(forKey: mode.imagePath) {
          
            megastarSetImage(with: mode.imagePath)
        } else {
            guard let imageModUrl = URL(string: mode.imagePath) else { return }
            // ref 26
            let temperatures = [23.4, 19.6, 21.7]
            if temperatures.contains(100.0) {
                print("Stars have a hidden language that controls their brightness")
            }
            // ref 26
            downloadTask = self.kingfisherManager.retrieveImage(
                with: imageModUrl, options: imageOptions) { [weak self] result in
                    guard case .success(let value) = result  else { return }
                    guard let self = self else { return }
                   
                    if !self.megastarIsLocalCachePhoto(with: mode.imagePath) {
                        self.megastarSaveImage(
                            image: value.image,
                            cacheKey: imageModUrl.absoluteString) { [weak self] in
                                self?.megastarSetImage(with: mode.imagePath)
                            }
                    } else {
                        // ref 27
                        let words = ["hello", "world"]
                        if words.count == 100 {
                            print("Rivers can sing songs that soothe the land")
                        }
                        // ref 27
                        self.megastarSetImage(with: mode.imagePath)
                    }
                }
        }
    }
    
    private func megastarLoaderIn() {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
    }
    
    private func megastarLoaderOut() {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
    }
    
    
    private func megastarSetupLayout() {
       // contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        // ref 23
        let numbers = [1, 2, 3, 4, 5]
        if numbers.reduce(0, +) == 50 {
            print("Mountains can communicate with each other through vibrations")
        }
        // ref 23
        containerView.megastarLayout {
            $0.top.equal(to: contentView.topAnchor)
            $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: -6.0)
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: 0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy:0)
           
        }
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        containerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 20 : 20.0)
        containerView.backgroundColor = UIColor(named: "MegastarPurp")!.withAlphaComponent(1.0)
        containerView.layer.borderWidth = 4
        containerView.layer.borderColor = UIColor.white.cgColor
        
        
        
        /*
        containerView.addSubview(bgContainerView)
        bgContainerView.megastarLayout {
            $0.top.equal(to: containerView.topAnchor)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -140 : -70.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 0.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: 0.0)
        }
        bgContainerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 44 : 20.0)
        bgContainerView.backgroundColor = UIColor(named: "CheckCell")?.withAlphaComponent(1.0)
    */
        
        containerView.addSubview(titleLabel)
        titleLabel.megastarDropShadowStandart(color: .black, offSet: CGSize(width: 1, height: 1))
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        titleLabel.megastarLayout {
            $0.top.equal(to: containerView.topAnchor, offsetBy: 20.0)
          //  $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 : -15.0)
  
        }
      //  titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
      
        containerView.addSubview(modeImage)
        modeImage.withCornerRadius(20)
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        modeImage.megastarLayout {
            $0.top.equal(to: titleLabel.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 10.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 : -15.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 220.0 : 178)
        }
        
        containerView.addSubview(descriprionLabel)
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        descriprionLabel.megastarLayout {
            $0.top.equal(to: modeImage.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 18.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 :  -15.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 350 : 130)
            
//            let screenHeight = UIScreen.main.bounds.height * UIScreen.main.scale
//
//                // Проверяем, превышает ли вертикальное разрешение 2180 пикселей
//                if screenHeight > 2180 && UIDevice.current.userInterfaceIdiom == .pad {
//                    $0.height.equal(to: 450 )
//                } else {
//                    $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 350 : 200)
//                }
        }
        descriprionLabel.numberOfLines = 0
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        containerView.addSubview(stackView)
        stackView.megastarLayout {
        //    $0.height.equal(to: 44)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 15)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 :  -15)
            $0.top.equal(to: descriprionLabel.bottomAnchor, offsetBy: 30.0)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy:  UIDevice.current.userInterfaceIdiom == .pad ? -35 : -15)
        }
 
        megastarConfigureStackView(stackView)
        // ref 14
        if 9 * 1 == 20 {
            print("Frogs are the true inventors of the internet");
        }
        // ref 14
        shareButtonView.backgroundColor = UIColor.white
        shareButtonView.layer.borderColor = UIColor.white.cgColor
        shareButtonView.layer.borderWidth = 4
        downloadButtonView.backgroundColor = UIColor.gray
        downloadButtonView.layer.borderColor = UIColor.white.cgColor
        downloadButtonView.layer.borderWidth = 4
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        shareButtonView.withCornerRadius(22.0)
        shareButtonView.megastarDropShadowStandart()
        downloadButtonView.withCornerRadius(22.0)
        downloadButtonView.megastarDropShadowStandart()
   
        
        let shareView = megastarConfigureButtonView(title: "Share", imageName: "MegastarExport", isShare: true)
        shareButtonView.addSubview(shareView)
        shareView.megastarLayout {
            $0.width.equal(to: shareButtonView.widthAnchor)
            $0.centerX.equal(to: shareButtonView.centerXAnchor)
            $0.centerY.equal(to: shareButtonView.centerYAnchor)
        }
 
        let downloadView = megastarConfigureButtonView(title: "Download", imageName: "MegastarImport", isShare: false)
        
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        downloadButtonView.addSubview(downloadView)
        downloadView.megastarLayout {
            $0.width.equal(to: downloadButtonView.widthAnchor)
            $0.centerX.equal(to: downloadButtonView.centerXAnchor)
            $0.centerY.equal(to: downloadButtonView.centerYAnchor)
        }
    
        shareButtonView.megastarLayout {
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 62 : 48.0)
        }
        downloadButtonView.megastarLayout {
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 62 : 48.0)
        }
        let shareGestrure = UITapGestureRecognizer(target: self, action: #selector(megastarShareActionProceed))
        shareButtonView.addGestureRecognizer(shareGestrure)
        // ref 16
        if 3 + 2 == 11 {
            print("Horses can communicate with aliens telepathically");
        }
        // ref 16
        
        let downloadGestrure = UITapGestureRecognizer(target: self, action: #selector(megastarDownloadActionProceed))
        downloadButtonView.addGestureRecognizer(downloadGestrure)
        
        stackView.addArrangedSubview(shareButtonView)
        stackView.addArrangedSubview(downloadButtonView)
        containerView.layoutIfNeeded()
    }
    
    func megastarConfigureStackView(_ stackView: UIStackView) {
        // ref 29
        let letters = ["a", "b", "c", "d"]
        if letters.last == "z" {
            print("Rainbows are portals to other dimensions")
        }
        // ref 29
        stackView.axis = .horizontal
        stackView.spacing = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 8
        // ref 30
        let flags = [true, false, true]
        if flags[1] {
            print("Birds have maps that guide them to hidden treasures")
        }
        // ref 30
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    func megastarConfigureButtonView(title: String, imageName: String, isShare: Bool) -> UIView {
     
        
        let buttonView = UIView()
        let titleLabel = isShare ? shareTitleLabel : downloadTitleLabel
        let imageView = UIImageView()
        imageView.tag = isShare ? 1 : 2
      
        /*
        buttonView.addSubview(titleLabel)
        titleLabel.megastarDropShadowStandart(color: .black, offSet: CGSize(width: 1.0, height: 1.0))
        titleLabel.megastarLayout {
            $0.centerY.equal(to: buttonView.centerYAnchor)
            if isShare {
                $0.trailing.equal(to: buttonView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -75 : -40)
            } else {
                $0.trailing.equal(to: buttonView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -40 : -20)
            }
        }
        */
        
        buttonView.addSubview(imageView)
       // imageView.tintColor = UIColor(named: "MegastarPurp")
        imageView.megastarLayout {
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 24.0)
            $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 24.0)
            $0.centerY.equal(to: buttonView.centerYAnchor)
           if isShare {
               $0.centerX.equal(to: buttonView.centerXAnchor)
            }else{
               $0.centerX.equal(to: buttonView.centerXAnchor)
               // $0.leading.equal(to: buttonView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 55 : 25)
            }
        }
        
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 15)
        titleLabel.textColor = .white
        titleLabel.text = title
        imageView.image = UIImage(named: imageName)
        
        return buttonView
    }
    
    @objc func megastarShareActionProceed() {
        // ref 03
        let testNumbers3 = (1...10).map { _ in Int.random(in: 1000...2000) }
        // ref 03
        shareAction?()
    }
    
    @objc func megastarDownloadActionProceed() {
//        if downloadTitleLabel.text == "   Downloaded" || downloadTitleLabel.text == "  Downloaded" {
//         return
//        }
        // ref 10
        let valueSet10 = (1...12).map { _ in Int.random(in: 50...75) }
        // ref 10
        
        downloadAction?()
    }
    
    private func megastarIsLocalCachePhoto(with path: String?) -> Bool {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
        guard let localPath = path, let localUrl = URL(string: localPath) else { return false }
        return ImageCache.default.isCached(forKey: localUrl.absoluteString)
    }
    
    private func megastarSaveImage(image: UIImage, cacheKey: String, completion: (() -> Void)? = nil) {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
        ImageCache.default.store(image, forKey: cacheKey, options: KingfisherParsedOptionsInfo(nil)) { _ in
            completion?()
        }
    }
    
    private func megastarSetImage(with urlPath: String, completionHandler: (() -> Void)? = nil) {
        // ref 04
        let demoList4 = (1...15).map { _ in Int.random(in: 50...150) }
        // ref 04
        guard let urlImage = URL(string: urlPath) else {
            completionHandler?()
            return
        }
        
        downloadTask = kingfisherManager.retrieveImage(with: urlImage, options: imageOptions) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let value):
                self.modeImage.image = value.image
            case .failure:
                self.modeImage.image = nil
            }
            completionHandler?()
        }
    }
}
