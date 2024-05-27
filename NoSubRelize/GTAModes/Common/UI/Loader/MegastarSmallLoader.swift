//
//  Created by Vladimir Khalin on 15.05.2024.
//

import UIKit

class MegastarSmallLoader: UIView {
    
    private var circlePath: UIBezierPath!
    private var progressLayer: CAShapeLayer!
    private var dotLayer: CALayer!
    private var timer: Timer?
   // private var arcLayer: CAShapeLayer! // Добавляем arcLayer
    private var arcLayer = CAShapeLayer()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        actualSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        actualSetup()
    }
    
    private func actualSetup() {
       
        let segments = 20
        let anglePerSegment = (2 * CGFloat.pi) / CGFloat(segments)
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + anglePerSegment * 3
        
        let arcPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
                                   radius: frame.size.width / 2 - 10, // Same radius as progressLayer
                                   startAngle: startAngle,
                                   endAngle: endAngle,
                                   clockwise: true)
        
       
        arcLayer.path = arcPath.cgPath
        arcLayer.strokeColor = UIColor.black.cgColor
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.lineWidth = 4
        arcLayer.lineCap = .round
        layer.addSublayer(arcLayer)
  
        circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
                                  radius: frame.size.width / 2 - 10,
                                  startAngle: -(.pi / 2),
                                  endAngle: .pi * 1.5,
                                  clockwise: true)
        
        progressLayer = CAShapeLayer()
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeColor = UIColor.black.withAlphaComponent(0.3).cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 4
        progressLayer.lineCap = .round
        layer.addSublayer(progressLayer)
  
    }
    
    func actualStartAnimation(duration: TimeInterval) {
       
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
           animation.fromValue = 0
           animation.toValue = CGFloat.pi * 2
           animation.duration = duration
           animation.repeatCount = .infinity
           animation.timingFunction = CAMediaTimingFunction(name: .linear)
           arcLayer.add(animation, forKey: "rotationAnimation")
        
        startPercentageTimer(duration: duration)
    }
    
    private func startPercentageTimer(duration: TimeInterval) {
       
        timer?.invalidate()  // Stop any previous timer
        var elapsed: TimeInterval = 0
        let interval: TimeInterval = 0.05
      
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { [weak self] timer in
            guard let self = self else { return }
            elapsed += interval
            let percentage = min(100, Int((elapsed / duration) * 100))
        }
    }
}
