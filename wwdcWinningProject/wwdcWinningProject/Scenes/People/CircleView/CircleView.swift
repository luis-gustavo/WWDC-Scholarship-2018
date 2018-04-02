//
//  CircleView.swift
//  wwdcWinningProject
//
//  Created by Luis Gustavo Avelino de Lima Jacinto on 26/03/18.
//  Copyright © 2018 Luis Gustavo Avelino de Lima Jacinto. All rights reserved.
//
//askjdbasjhdvjhasvdjhgvasjhd
import UIKit
import SpriteKit

class CircleView: UIView{
    var circleLayer: CAShapeLayer!
    
    init(frame: CGRect, color: UIColor, endAngle: CGFloat = CGFloat(.pi * 2.0)) {
        super.init(frame: frame)
        backgroundColor = .clear
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width - 10)/2, startAngle: -.pi/2, endAngle: endAngle, clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = color.cgColor
        circleLayer.lineWidth = 5.0
        
        circleLayer.strokeEnd = 0.0
        
        layer.addSublayer(circleLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.duration = duration
        
        animation.fromValue = 0
        animation.toValue = 1
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        circleLayer.strokeEnd = 1.0
        
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
