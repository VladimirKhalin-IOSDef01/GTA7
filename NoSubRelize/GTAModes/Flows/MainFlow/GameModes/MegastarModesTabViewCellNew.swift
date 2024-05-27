//
//  GTAModes_TableViewCell_New.swift
//  GTAModes
//
//  Created by Vladimir Khalin on 23.02.2024.
//

import Foundation
import UIKit
import Kingfisher

final class MegastarModesTabViewCellNew: UITableViewCell, MegastarReusable {
    
    private var kingfisherManager: KingfisherManager
    private var downloadTask: DownloadTask?
    private var bottomBlackView = UIView()
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let logoImage = UIImageView()
    
    private let modeImage: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    private let descriprionLabel = UILabel()
    private let shareButtonView = UIView()
    private let downloadButtonView = UIView()
    private let stackView = UIStackView()
    
   
    
    private var imageOptions: KingfisherOptionsInfo = [
        .processor(ResizingImageProcessor(
            referenceSize: CGSize(
                width: UIDevice.current.userInterfaceIdiom == .pad ? 148 : 148,
                height: UIDevice.current.userInterfaceIdiom == .pad ? 243 : 243
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
        super.prepareForReuse()
        titleLabel.text = ""
        descriprionLabel.text = ""
        modeImage.image = nil
        downloadTask?.cancel()
    }
    
    public func megastarConfigure_cell(_ value: MegastarModItem, isLoaded: Bool) {
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 26 : 20)
        titleLabel.textColor = .white
        titleLabel.text = value.title.capitalized
        descriprionLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 26 : 15)
        descriprionLabel.textColor = .white
        descriprionLabel.text = value.description
        logoImage.image = UIImage(named: "ActualModsLogo")
        megastarSetImageMod(value)
    }
    
    private func megastarSetImageMod(_ mode: MegastarModItem) {
        if ImageCache.default.isCached(forKey: mode.imagePath) {
            megastarSetImage(with: mode.imagePath)
        } else {
            guard let imageModUrl = URL(string: mode.imagePath) else { return }
            
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
                        
                        self.megastarSetImage(with: mode.imagePath)
                    }
                }
        }
    }
    
    private func megastarSetupLayout() {
        contentView.backgroundColor = .clear
        contentView.addSubview(containerView)
        
        containerView.megastarLayout {
            $0.top.equal(to: contentView.topAnchor)
            $0.bottom.equal(to: contentView.bottomAnchor, offsetBy: -20.0)
            $0.leading.equal(to: contentView.leadingAnchor, offsetBy: 0)
            $0.trailing.equal(to: contentView.trailingAnchor, offsetBy: 0)
        }
        containerView.withCornerRadius(UIDevice.current.userInterfaceIdiom == .pad ? 20 : 20.0)
        
        containerView.megastarDropShadowStandart()
        containerView.backgroundColor = UIColor(named: "MegastarPurp")
        containerView.layer.borderWidth = 4
        containerView.layer.borderColor = UIColor.white.cgColor
        
        containerView.addSubview(modeImage)
        modeImage.withCornerRadius(20.0)
        modeImage.megastarLayout {
            $0.top.equal(to: containerView.topAnchor, offsetBy:UIDevice.current.userInterfaceIdiom == .pad ? 75 : 55.0)
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -15.0)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy: -20.0)
        }
        /*
         containerView.addSubview(bottomBlackView)
         bottomBlackView.layer.cornerRadius = 20 // Задаём радиус скругления
         bottomBlackView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner] // Скругляем только нижние левый и правый углы
         bottomBlackView.clipsToBounds = true
         bottomBlackView.backgroundColor = UIColor(named: "ActualBlack")?.withAlphaComponent(0.80)
         bottomBlackView.megastarLayout {
         $0.top.equal(to: containerView.topAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 220 : 160)
         $0.leading.equal(to: containerView.leadingAnchor)
         $0.trailing.equal(to: containerView.trailingAnchor)
         $0.bottom.equal(to: containerView.bottomAnchor)
         // $0.height.equal(to: 61)
         }
         
         containerView.addSubview(logoImage)
         logoImage.clipsToBounds = true
         logoImage.contentMode = .scaleAspectFill
         logoImage.megastarLayout {
         $0.leading.equal(to: bottomBlackView.leadingAnchor, offsetBy: 16)
         $0.centerY.equal(to: bottomBlackView.centerYAnchor)
         $0.width.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 18)
         $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 18)
         }
         */
        containerView.addSubview(titleLabel)
        titleLabel.megastarLayout {
            $0.top.equal(to: containerView.topAnchor, offsetBy: 20.0)
            // $0.leading.equal(to: logoImage.trailingAnchor, offsetBy: 15.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -15.0)
            //   $0.centerY.equal(to: bottomBlackView.centerYAnchor)
            //   $0.height.equal(to: 50)
            
        }
        titleLabel.numberOfLines = 2
        
        
        
        containerView.addSubview(descriprionLabel)
        descriprionLabel.megastarLayout {
            $0.top.equal(to: titleLabel.bottomAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 18 : 10.0)
            $0.leading.equal(to: modeImage.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? 16 : 8.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: UIDevice.current.userInterfaceIdiom == .pad ? -28 : -8.0)
            $0.height.equal(to: UIDevice.current.userInterfaceIdiom == .pad ? 106 : 60.0)
        }
        descriprionLabel.numberOfLines = 0
        
        containerView.addSubview(stackView)
        stackView.megastarLayout {
            $0.leading.equal(to: containerView.leadingAnchor, offsetBy: 8.0)
            $0.trailing.equal(to: containerView.trailingAnchor, offsetBy: -8.0)
            $0.top.equal(to: descriprionLabel.bottomAnchor, offsetBy: 12.0)
            $0.bottom.equal(to: containerView.bottomAnchor, offsetBy:  -5.0)
        }
        
        containerView.layoutIfNeeded()
    }
    
    func megastarConfigureStackView(_ stackView: UIStackView) {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        stackView.alignment = .center
    }
    
    private func megastarIsLocalCachePhoto(with path: String?) -> Bool {
        guard let localPath = path, let localUrl = URL(string: localPath) else { return false }
        return ImageCache.default.isCached(forKey: localUrl.absoluteString)
    }
    
    private func megastarSaveImage(image: UIImage, cacheKey: String, completion: (() -> Void)? = nil) {
        ImageCache.default.store(image, forKey: cacheKey, options: KingfisherParsedOptionsInfo(nil)) { _ in
            completion?()
        }
    }
    
    private func megastarSetImage(with urlPath: String, completionHandler: (() -> Void)? = nil) {
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
