//
//  RefreshButton.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 20/09/2021.
//
import Foundation
import UIKit

class RefreshButton: UIButton, CAAnimationDelegate {
    enum Position {
        case start, becomeEnd, ended
    }
    private var position: Position
    private let shapeArrowCircle: CAShapeLayer
    private let layerArrowCircle: CALayer

    override init(frame: CGRect) {
        position = .ended
        shapeArrowCircle = CAShapeLayer()
        layerArrowCircle = CALayer()
        super.init(frame: frame)
        start()
        //rotate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func start() {
                
        shapeArrowCircle.path = drawArrowCircle(frame: CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20), thickness: 4).cgPath
        shapeArrowCircle.fillColor = UIColor.clear.cgColor
        shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
        shapeArrowCircle.lineWidth = 2
        shapeArrowCircle.lineJoin = .round
        shapeArrowCircle.lineCap = .butt
        
        layerArrowCircle.addSublayer(shapeArrowCircle)
        shapeArrowCircle.setAffineTransform(CGAffineTransform.init(translationX: -frame.width/2, y: -frame.width/2))
        layerArrowCircle.setAffineTransform(CGAffineTransform.init(translationX: frame.width/2, y: frame.width/2))

        
        
        self.layer.addSublayer(layerArrowCircle)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    func rotate() {
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        pathAnimation.delegate = self
        pathAnimation.duration = 1
        pathAnimation.fillMode = CAMediaTimingFillMode.forwards
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = .infinity
        pathAnimation.fromValue = 0
        pathAnimation.toValue = CGFloat.pi*2
        layerArrowCircle.add(pathAnimation, forKey: "anim")
    }
    func stopRotate() {
        layerArrowCircle.removeAllAnimations()
    }
    private func drawArrowCircle(frame: CGRect, thickness: CGFloat) -> UIBezierPath {
        let decalage: CGFloat = thickness/8
        let bezierPath = UIBezierPath()
        bezierPath.addArc(withCenter: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)), radius: (frame.width/2), startAngle: -(CGFloat.pi)+0.3, endAngle: 0, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width+thickness-decalage, y: frame.origin.y+(frame.height/2)-thickness))
        bezierPath.move(to: CGPoint(x: frame.origin.x+frame.width, y: frame.origin.y+(frame.height/2)))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-thickness-decalage, y: frame.origin.y+(frame.height/2)-thickness))

        bezierPath.move(to: CGPoint(x: frame.origin.x+frame.width, y: frame.origin.y+(frame.height/2)+4))

        bezierPath.addArc(withCenter: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)), radius: (frame.width/2), startAngle: 0.3, endAngle: CGFloat.pi, clockwise: true)
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+thickness+decalage, y: frame.origin.y+(frame.height/2)+thickness))
        bezierPath.move(to: CGPoint(x: frame.origin.x, y: frame.origin.y+(frame.height/2)))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x-thickness+decalage, y: frame.origin.y+(frame.height/2)+thickness))

        return bezierPath
    }
    
}
