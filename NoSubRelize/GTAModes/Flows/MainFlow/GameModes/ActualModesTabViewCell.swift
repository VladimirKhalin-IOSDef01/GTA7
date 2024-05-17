
import Foundation
import UIKit
import Kingfisher

class TopAlignedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let actualRect = self.textRect(forBounds: rect, limitedToNumberOfLines: numberOfLines)
        super.drawText(in: actualRect)
    }
}

final class ActualModesTabViewCell: UITableViewCell, ActualReusable {
   
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
    private let descriprionLabel = TopAlignedLabel()
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
        actualSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = ""
        descriprionLabel.text = ""
        modeImage.image = nil
        downloadTask?.cancel()
    }
    
    public func actualGameModeDownloadColor(downloading: Bool) {
        switch downloading {
            
        case true:
            downloadButtonView.backgroundColor = UIColor(.white)
            downloadTitleLabel.text = "Downloading..."
            actualUpdateDownloadTitleLabel(check: false)
        case false:
            downloadButtonView.backgroundColor = UIColor(named: "MegastarRed")?.withAlphaComponent(1.0)
            downloadTitleLabel.text = UIDevice.current.userInterfaceIdiom == .pad ? "Failed, retry" : "Failed, retry"
            actualUpdateDownloadTitleLabel(check: false)
        }
    }
   
    func actualUpdateDownloadTitleLabel(check: Bool) {
      
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
                    loaderSmall.actualStartAnimation(duration: 2)
                    loaderSmall.actualLayout {
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
    
    public func actualConfigureCell(_ value: ActualModItem, isLoaded: Bool) {
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 32 : 21)
        titleLabel.textColor = .white
        titleLabel.text = value.title.capitalized
        descriprionLabel.font = UIFont(name: "OpenSans-Regular", size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 15)
     
        descriprionLabel.textColor = .white
        descriprionLabel.text = value.description
        
        downloadButtonView.backgroundColor = isLoaded ? UIColor(named: "MegastarGreen")?.withAlphaComponent(1.0) : UIColor(.white).withAlphaComponent(1.0)
     
        downloadTitleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 24 : 15)
        downloadTitleLabel.textColor = .white
        downloadTitleLabel.text = isLoaded ? UIDevice.current.userInterfaceIdiom == .pad ? "  Downloaded" : "   Downloaded" : "Download "
       
        if downloadTitleLabel.text == "   Downloaded" || downloadTitleLabel.text == "  Downloaded" {
            actualUpdateDownloadTitleLabel(check: true)
            
        }
        
        actualSetImageMod(value)
    }
    
    private func actualSetImageMod(_ mode: ActualModItem) {
      
        if ImageCache.default.isCached(forKey: mode.imagePath) {
          
            actualSetImage(with: mode.imagePath)
        } else {
            guard let imageModUrl = URL(string: mode.imagePath) else { return }
           
            downloadTask = self.kingfisherManager.retrieveImage(
                with: imageModUrl, options: imageOptions) { [weak self] result in
                    guard case .success(let value) = result  else { return }
                    guard let self = self else { return }
                   
                    if !self.actualIsLocalCachePhoto(with: mode.imagePath) {
                        self.actualSaveImage(
                            image: value.image,
                            cacheKey: imageModUrl.absoluteString) { [weak self] in
                                self?.actualSetImage(with: mode.imagePath)
                            }
                    } else {
                       
                        self.actualSetImage(with: mode.imagePath)
                    }
                }
        }
    }
    
    private func megastarLoaderIn() {
        
    }
    
    private func megastarLoaderOut() {
        
    }
    
    
    private func actualSetupLayout() {
       // contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        containerView.actualLayout {
            $0.top.equal(to: contentView.topAnchor)
            $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: -6.0)
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 0 : 15.0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 0 : -15.0)
           
        }
        containerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 20 : 20.0)
        containerView.backgroundColor = UIColor(named: "MegastarPurp")!.withAlphaComponent(1.0)
        containerView.layer.borderWidth = 4
        containerView.layer.borderColor = UIColor.white.cgColor
        
        
        
        /*
        containerView.addSubview(bgContainerView)
        bgContainerView.actualLayout {
            $0.top.equal(to: containerView.topAnchor)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -140 : -70.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 0.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: 0.0)
        }
        bgContainerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 44 : 20.0)
        bgContainerView.backgroundColor = UIColor(named: "CheckCell")?.withAlphaComponent(1.0)
    */
        
        containerView.addSubview(titleLabel)
        titleLabel.actualDropShadowStandart(color: .black, offSet: CGSize(width: 1, height: 1))
        titleLabel.actualLayout {
            $0.top.equal(to: containerView.topAnchor, offsetBy: 20.0)
          //  $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -15.0)
  
        }
      //  titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 2
      
        containerView.addSubview(modeImage)
        modeImage.withCornerRadius(20)
        modeImage.actualLayout {
            $0.top.equal(to: titleLabel.bottomAnchor, offsetBy: 10.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 : -15.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 178.0 : 178)
        }
        
        containerView.addSubview(descriprionLabel)
        descriprionLabel.actualLayout {
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
      
        containerView.addSubview(stackView)
        stackView.actualLayout {
        //    $0.height.equal(to: 44)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 35 : 15)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -35 :  -15)
            $0.top.equal(to: descriprionLabel.bottomAnchor, offsetBy: 30.0)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy:  -15)
        }
 
        actualConfigureStackView(stackView)
        shareButtonView.backgroundColor = UIColor.white
        shareButtonView.layer.borderColor = UIColor.white.cgColor
        shareButtonView.layer.borderWidth = 4
        downloadButtonView.backgroundColor = UIColor.gray
        downloadButtonView.layer.borderColor = UIColor.white.cgColor
        downloadButtonView.layer.borderWidth = 4
   
        shareButtonView.withCornerRadius(22.0)
        shareButtonView.actualDropShadowStandart()
        downloadButtonView.withCornerRadius(22.0)
        downloadButtonView.actualDropShadowStandart()
   
        
        let shareView = actualConfigureButtonView(title: "Share", imageName: "MegastarExport", isShare: true)
        shareButtonView.addSubview(shareView)
        shareView.actualLayout {
            $0.width.equal(to: shareButtonView.widthAnchor)
            $0.centerX.equal(to: shareButtonView.centerXAnchor)
            $0.centerY.equal(to: shareButtonView.centerYAnchor)
        }
 
        let downloadView = actualConfigureButtonView(title: "Download", imageName: "MegastarImport", isShare: false)
        
        
        downloadButtonView.addSubview(downloadView)
        downloadView.actualLayout {
            $0.width.equal(to: downloadButtonView.widthAnchor)
            $0.centerX.equal(to: downloadButtonView.centerXAnchor)
            $0.centerY.equal(to: downloadButtonView.centerYAnchor)
        }
    
        shareButtonView.actualLayout {
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 58 : 48.0)
        }
        downloadButtonView.actualLayout {
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 58 : 48.0)
        }
        let shareGestrure = UITapGestureRecognizer(target: self, action: #selector(actualShareActionProceed))
        shareButtonView.addGestureRecognizer(shareGestrure)
    
        
        let downloadGestrure = UITapGestureRecognizer(target: self, action: #selector(actualDownloadActionProceed))
        downloadButtonView.addGestureRecognizer(downloadGestrure)
        
        stackView.addArrangedSubview(shareButtonView)
        stackView.addArrangedSubview(downloadButtonView)
        containerView.layoutIfNeeded()
    }
    
    func actualConfigureStackView(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = UIDevice.current.userInterfaceIdiom == .pad ? 20 : 8
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    func actualConfigureButtonView(title: String, imageName: String, isShare: Bool) -> UIView {
     
        
        let buttonView = UIView()
        let titleLabel = isShare ? shareTitleLabel : downloadTitleLabel
        let imageView = UIImageView()
        imageView.tag = isShare ? 1 : 2
      
        /*
        buttonView.addSubview(titleLabel)
        titleLabel.actualDropShadowStandart(color: .black, offSet: CGSize(width: 1.0, height: 1.0))
        titleLabel.actualLayout {
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
        imageView.actualLayout {
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
    
    @objc func actualShareActionProceed() {
        shareAction?()
    }
    
    @objc func actualDownloadActionProceed() {
        downloadAction?()
    }
    
    private func actualIsLocalCachePhoto(with path: String?) -> Bool {
        guard let localPath = path, let localUrl = URL(string: localPath) else { return false }
        return ImageCache.default.isCached(forKey: localUrl.absoluteString)
    }
    
    private func actualSaveImage(image: UIImage, cacheKey: String, completion: (() -> Void)? = nil) {
        ImageCache.default.store(image, forKey: cacheKey, options: KingfisherParsedOptionsInfo(nil)) { _ in
            completion?()
        }
    }
    
    private func actualSetImage(with urlPath: String, completionHandler: (() -> Void)? = nil) {
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
