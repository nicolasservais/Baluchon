//
//  RefreshButton.swift
//  Baluchon
//
//  Created by Nicolas SERVAIS on 20/09/2021.
//
import Foundation
import UIKit

final class RefreshButton: UIButton {
    
    enum Style {
        case roundedBlue, arrowBlue, roundedBlueRotate, valid, error
    }
    private var style: Style
    private let shapeArrowCircle: CAShapeLayer
    private let layerArrowCircle: CALayer
    private var bezierPathSource: UIBezierPath
    private var bezierPathDestination: UIBezierPath
    private var bezierRound: UIBezierPath
    private var bezierArrow: UIBezierPath
    private var bezierValid: UIBezierPath
    private var bezierError: UIBezierPath

    init(frame: CGRect, style:Style, name: String) {
        self.style = style
        shapeArrowCircle = CAShapeLayer()
        layerArrowCircle = CALayer()
        bezierRound = UIBezierPath()
        bezierArrow = UIBezierPath()
        bezierValid = UIBezierPath()
        bezierError = UIBezierPath()
        bezierPathSource = UIBezierPath()
        bezierPathDestination = UIBezierPath()
        super.init(frame: frame)
        self.accessibilityIdentifier = name
        start()
    }
    
    required init?(coder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        return nil
    }
    
    private func redraw(size: CGSize) {
        bezierRound = bezierArrowCircle(frame: CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20), thickness: 4)
        bezierArrow = bezierArrowUpDown(frame: CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20), thickness: 4)
        bezierValid = bezierValide(frame: CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20))
        bezierError = bezierError(frame: CGRect(x: 10, y: 10, width: frame.width-20, height: frame.height-20))
        shapeArrowCircle.path = bezierPathSource.cgPath
    }
    
    private func start() {
                
        self.backgroundColor = .white
        redraw(size: frame.size)
        shapeArrowCircle.fillColor = UIColor.clear.cgColor
        shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
        shapeArrowCircle.lineWidth = 3
        shapeArrowCircle.lineJoin = .round
        shapeArrowCircle.lineCap = .butt
        
        layerArrowCircle.addSublayer(shapeArrowCircle)
        shapeArrowCircle.setAffineTransform(CGAffineTransform.init(translationX: -frame.width/2, y: -frame.width/2))
        layerArrowCircle.setAffineTransform(CGAffineTransform.init(translationX: frame.width/2, y: frame.width/2))

        self.layer.addSublayer(layerArrowCircle)
        self.layer.cornerRadius = 8.0
        self.layer.borderWidth = 3
        self.layer.borderColor = UIColor.darkGray.cgColor
        changeButton(style: self.style, animating: false)
    }

    func changeButton(style:Style, animating: Bool) {
        if animating {
            switch style {
            case .error:
                moveTo(bezier: bezierError)
                shapeArrowCircle.strokeColor = UIColor.systemRed.cgColor
            case .valid:
                moveTo(bezier: bezierValid)
                shapeArrowCircle.strokeColor = UIColor.systemGreen.cgColor
            case .roundedBlue:
                moveTo(bezier: bezierRound)
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
            case .arrowBlue:
                moveTo(bezier: bezierArrow)
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
            case .roundedBlueRotate:
                moveTo(bezier: bezierRound)
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
                startRotate()
            }
        } else {
            switch style {
            case .error:
                bezierPathDestination = bezierError
                shapeArrowCircle.strokeColor = UIColor.systemRed.cgColor
            case .valid:
                bezierPathDestination = bezierValid
                shapeArrowCircle.strokeColor = UIColor.systemGreen.cgColor
            case .roundedBlue:
                bezierPathDestination = bezierRound
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
            case .arrowBlue:
                bezierPathDestination = bezierArrow
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
            case .roundedBlueRotate:
                bezierPathDestination = bezierRound
                shapeArrowCircle.strokeColor = UIColor.systemBlue.cgColor
                startRotate()
            }
            shapeArrowCircle.path = bezierPathDestination.cgPath
            bezierPathSource = bezierPathDestination
        }
        if self.style == .roundedBlueRotate && style != .roundedBlueRotate {
            stopRotate()
        }

        self.style = style
    }
    
    private func moveTo(bezier: UIBezierPath) {
        let pathAnimation: CABasicAnimation = CABasicAnimation(keyPath: "path")
        pathAnimation.fromValue = bezierPathSource.cgPath
        pathAnimation.toValue = bezier.cgPath
        pathAnimation.duration = 0.2
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.fillMode = .forwards
        pathAnimation.delegate = self
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        shapeArrowCircle.add(pathAnimation, forKey: "anim")
    }
    
    private func startRotate() {
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
    
    private func stopRotate() {
        if let pathAnimation: CABasicAnimation =  layerArrowCircle.animation(forKey: "anim")?.copy() as? CABasicAnimation {
            pathAnimation.repeatCount = round(Float(((CACurrentMediaTime()-pathAnimation.beginTime)/1)))
            pathAnimation.duration = 0.2
            layerArrowCircle.add(pathAnimation, forKey: "anim")
        }
    }

    private func bezierArrowCircle(frame: CGRect, thickness: CGFloat) -> UIBezierPath {
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
    private func bezierArrowUpDown(frame: CGRect, thickness: CGFloat) -> UIBezierPath {
        let offsetX: CGFloat = 6
        let offsetY: CGFloat = 4
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+(frame.height/2)-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+frame.height-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX+thickness, y: frame.origin.y+frame.height-offsetY-thickness))
        bezierPath.move(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+frame.height-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX-thickness, y: frame.origin.y+frame.height-offsetY-thickness))

        bezierPath.move(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+frame.height-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+(frame.height/2)+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX+thickness, y: frame.origin.y+offsetY+thickness))
        bezierPath.move(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX-thickness, y: frame.origin.y+offsetY+thickness))
        return bezierPath
    }

    private func bezierValide(frame: CGRect) -> (UIBezierPath) {
        let offsetX: CGFloat = 4
        let offsetY: CGFloat = 4
        let offsetLine: CGFloat = 2
            let bezierPath: UIBezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+frame.height/2))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+frame.height-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+offsetY+offsetLine))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+frame.height-offsetY+offsetLine))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX-offsetLine, y: frame.origin.y+frame.height/2))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+frame.height/2))
        return bezierPath
    }
    
    private func bezierError(frame: CGRect) -> (UIBezierPath) {
        let offsetX: CGFloat = 4
        let offsetY: CGFloat = 4
            let bezierPath: UIBezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+frame.width-offsetX, y: frame.origin.y+frame.height-offsetY))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)))
        bezierPath.addLine(to: CGPoint(x: frame.origin.x+offsetX, y: frame.origin.y+frame.height-offsetY))
        //bezierPath.addLine(to: CGPoint(x: frame.origin.x+(frame.width/2), y: frame.origin.y+(frame.height/2)))
        return bezierPath
    }
}

extension RefreshButton: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        shapeArrowCircle.path = bezierPathSource.cgPath
        bezierPathDestination = bezierPathSource
    }
}
