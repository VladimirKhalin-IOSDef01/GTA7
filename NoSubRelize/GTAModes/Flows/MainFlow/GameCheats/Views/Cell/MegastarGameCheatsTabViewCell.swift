//
//  Created by Vladimir Khalin on 15.05.2024.
//


import Foundation
import UIKit

final class MegastarGameCheatsTabViewCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    private let favoriteImage = UIImageView()
    private let firstStackView = UIStackView()
    private let secondStackView = UIStackView()
    private let threeStackView = UIStackView()
    private let fourStackView = UIStackView()
    private let contentModeView = UIView()
    private let modeTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        megastarSetupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
       
        super.prepareForReuse()
        favoriteImage.image = nil
        titleLabel.text = ""
        firstStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        secondStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        threeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
    }
    
    public func actualConfigure(with value: MegastarCheatItem) {
       
        titleLabel.text = value.name
        favoriteImage.image = UIImage(named: value.isFavorite ? "MegastarHeartFill" : "MegastarHeartClear")
        
        if value.code.count > 1 {
            contentModeView.isHidden = true
            firstStackView.isHidden = false
            secondStackView.isHidden = false
            threeStackView.isHidden = false
            let imagesListName = configureCodes(value)
            megastarAddImages(imagesListName)
        } else {
           
            contentModeView.isHidden = false
            firstStackView.isHidden = true
            secondStackView.isHidden = true
            threeStackView.isHidden = true
           
            modeTitleLabel.text = value.code.first?.uppercased() ?? ""
        }
    }
    
    private func megastarSetupLayout() {
 
        contentView.addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        containerView.backgroundColor = UIColor(named: "MegastarPurp")
        containerView.layer.cornerRadius = 18
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 4
        containerView.layer.shadowOpacity = 0.3
        
        containerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        
        
        
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        if UIDevice.current.userInterfaceIdiom == .pad {
          
            titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 26)
        } else {
          
            titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 18)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 5 : 5),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 27 : 14),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -60 : -40),
            titleLabel.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 75 : 46)
        ])
        
        containerView.addSubview(favoriteImage)
        favoriteImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoriteImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 28 : 15),
            favoriteImage.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -27 : -15),
            favoriteImage.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 34 : 27),
            favoriteImage.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 34 : 27)
        ])
       
        megastarSetupStackViews()
    }
    
    private func megastarSetupStackViews() {
    
        // Configure stack views
        [firstStackView, secondStackView, threeStackView].forEach {
            $0.axis = .horizontal
           // $0.distribution = .fillEqually
            $0.distribution = .fill
            $0.spacing = 7
        
            containerView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 15),
                $0.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -12 : -8)
            ])
        }
        
        NSLayoutConstraint.activate([
            firstStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 7 : 7),
            secondStackView.topAnchor.constraint(equalTo: firstStackView.bottomAnchor, constant: 5),
            threeStackView.topAnchor.constraint(equalTo: secondStackView.bottomAnchor, constant: 5),
            threeStackView.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -5)
        ])
       
        containerView.addSubview(contentModeView)
        contentModeView.translatesAutoresizingMaskIntoConstraints = false
        contentModeView.layer.cornerRadius = UIDevice.current.userInterfaceIdiom == .pad ? 18 :14
        contentModeView.layer.borderWidth = 2
   
        contentModeView.layer.borderColor = UIColor.white.cgColor
      //  contentModeView.backgroundColor = UIColor(named: "ButtonColor")?.withAlphaComponent(0.0)
        NSLayoutConstraint.activate([
            contentModeView.topAnchor.constraint(equalTo: favoriteImage.bottomAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 25 : 15),
            contentModeView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 27 : 14),
            contentModeView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? -27 : -15),
            contentModeView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 36 : 28)
           // contentModeView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -15
        ])
       
        contentModeView.addSubview(modeTitleLabel)
        modeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        modeTitleLabel.textColor = .white
        modeTitleLabel.textAlignment = .left
        modeTitleLabel.font = UIFont(name: "OpenSans-SemiBold", size: UIDevice.current.userInterfaceIdiom == .pad ? 20 : 14)
        //modeTitleLabel.numberOfLines = 3
        NSLayoutConstraint.activate([
           // modeTitleLabel.topAnchor.constraint(equalTo: contentModeView.topAnchor, constant: 8),
            modeTitleLabel.leadingAnchor.constraint(equalTo: contentModeView.leadingAnchor, constant: UIDevice.current.userInterfaceIdiom == .pad ? 16 : 10),
            modeTitleLabel.centerYAnchor.constraint(equalTo: contentModeView.centerYAnchor),
            modeTitleLabel.trailingAnchor.constraint(equalTo: contentModeView.trailingAnchor, constant: -8),
          //  modeTitleLabel.bottomAnchor.constraint(equalTo: contentModeView.bottomAnchor, constant: -8)
        ])
    }
    
    private func configureCodes(_ value: MegastarCheatItem) -> [String] {
      
        var codes: [String] = []
        switch value.platform {
            
        case "ps":
            for code in value.code {
                codes.append(megastarConfigurePSCode(code))
            }
        case "xbox":
            for code in value.code {
                codes.append(megastarConfigureXBoxCode(code))
            }
        default:
            break
        }
        return codes
    }
    
    func megastarConfigurePSCode(_ code: String) -> String {
        switch code {
        case "Triangle", "TRIANGLE": return "MegastarTriangle"
        case "Square", "SQUARE": return "MegastarSquare"
        case "Circle", "CIRCLE", "O": return "MegastarCircle"
        case "X": return "MegastarCross"
        case "R1": return "MegastarR1"
        case "R2": return "MegastarR2"
        case "L1": return "MegastarL1"
        case "L2": return "MegastarL2"
        case "RIGHT", "Right": return "MegastarRight"
        case "LEFT", "Left": return "MegastarLeft"
        case "DOWN", "Down": return "MegastarDowncopy"
        case "UP", "Up": return "MegastarUpcopy"
        default: return ""
        }
    }
    
    func megastarConfigureXBoxCode(_ code: String) -> String {
        switch code {
        case "Y": return "MegastarY"
        case "B": return "MegastarB"
        case "A": return "MegastarA"
        case "X": return "MegastarX"
        case "RB": return "MegastarRB"
        case "RT": return "MegastarRT"
        case "LB": return "MegastarLB"
        case "LT": return "MegastarLT"
        case "RIGHT", "Right": return "MegastarRight"
        case "LEFT", "Left": return "MegastarLeft"
        case "DOWN", "Down": return "MegastarDowncopy"
        case "UP", "Up": return "MegastarUp2"
        default: return ""
        }
    }
    
    private func megastarAddImages(_ imageNames: [String]) {
     
        // Очистить стековые виды перед добавлением новых изображений
          firstStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
          secondStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
          threeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
          fourStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
       
          // Распределение изображений по стековым видам
          let stackViews = [firstStackView, secondStackView, threeStackView, fourStackView]
          var currentStackIndex = 0

          for (index, imageName) in imageNames.enumerated() {
              // Создаем новый UIImageView для каждого имени изображения
              let imageView = UIImageView()
              imageView.image = UIImage(named: imageName)
              imageView.contentMode = .scaleAspectFit
        
              imageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 24).isActive = true
              imageView.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 30 : 24).isActive = true
              
              // Добавляем imageView в текущий стековый вид
              stackViews[currentStackIndex].addArrangedSubview(imageView)
           
              // Переход к следующему стековому виду после каждых 10 изображений
              let imageCount = UIDevice.current.userInterfaceIdiom == .pad ? 12 : 10
              if (index + 1) % imageCount == 0 && currentStackIndex < stackViews.count - 1 {
                  currentStackIndex += 1
              }
          }

          // Добавление спейсеров в каждый стековый вид
          for stackView in stackViews {
            
              let spacer = UIView()
              spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
              spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
              
              stackView.addArrangedSubview(spacer)
          }
    }
}
