//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

final class HorizontalFakeLoaderView: UIView {
    
    private let progressBar = UIView()
    private let background = UIView()
    private let progressLabel = UILabel()
    private let titleLabel = UILabel()
    private var progress: CGFloat = 0.0
    private var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoader()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLoader()
    }
    
    private func setupLoader() {
        // Настройка текста прогресса
        titleLabel.text = "Loading"
        titleLabel.frame = CGRect(x: 0, y: 0, width: 350, height: 40)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "OpenSans-SemiBold", size: 32)
        addSubview(titleLabel)
        
        
        // Настройка заднего фона
        background.frame = CGRect(x: 0, y: 55, width: 350, height: 44)
        background.backgroundColor = UIColor.white
        background.layer.cornerRadius = 22
        background.layer.borderColor = UIColor.white.cgColor
        background.layer.borderWidth = 4
        addSubview(background)
        
        // Настройка прогресс бара
        progressBar.frame = CGRect(x: 0, y: 4, width: 0, height: 36)
        progressBar.backgroundColor = UIColor.black
        progressBar.layer.cornerRadius = 18
        background.addSubview(progressBar)
        
        // Настройка текста прогресса
        progressLabel.frame = CGRect(x: 0, y: 115, width: 350, height: 35)
        progressLabel.textColor = .white
        progressLabel.textAlignment = .center
        progressLabel.font = UIFont(name: "OpenSans-SemiBold", size: 32)
        addSubview(progressLabel)
    }
    
    func startLoading(duration: TimeInterval) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            self.progress += CGFloat(timer.timeInterval) / CGFloat(duration)
            if self.progress >= 1.0 {
                self.progress = 1.0
                timer.invalidate()
            }
            self.updateProgress()
        }
    }
    
    private func updateProgress() {
        progressLabel.text = "\(Int(progress * 100))%"
        progressBar.frame.size.width = background.bounds.width * progress
    }
    
    deinit {
        timer?.invalidate()
    }
}

    
    
    
    

