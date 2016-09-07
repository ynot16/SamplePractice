//
//  YNTLiquidLoaderView.swift
//  pratice
//
//  Created by bori－applepc on 16/8/31.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTLiquidLoaderView: UIView {
    
    
    private var dynamicCircle: YNTCircle!
    private var staticCircle: YNTCircle!
    private var displayLink: CADisplayLink!
    private var sideDistance: CGFloat!
    private var shapeLayer: CAShapeLayer!
    private var circleRadious: CGFloat!
    private var staticX: CGFloat!
    private var staticY: CGFloat!
    private var dynamicX: CGFloat!
    private var dynamicY: CGFloat!
    private var PointA: CGPoint!
    private var PointB: CGPoint!
    private var PointC: CGPoint!
    private var PointD: CGPoint!
    private var PointO: CGPoint!
    private var PointP: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        staticX = self.center.x
        staticY = self.center.y
        staticCircle = YNTCircle(frame: CGRectMake(0, 0, 30, 30))
        staticCircle.center = self.center
        staticCircle.backgroundColor = UIColor.redColor()
        addSubview(staticCircle)

        dynamicCircle = YNTCircle(frame: CGRectMake(0, staticCircle.frame.origin.y, 30, 30))
        dynamicCircle.backgroundColor = UIColor.redColor()
        addSubview(dynamicCircle)
        circleRadious = staticCircle.frame.width / 2
        
        let animator = CAKeyframeAnimation(keyPath: "position")
        animator.values = [NSValue(CGPoint: CGPointMake(staticX - 2 * circleRadious - 10, staticY)), NSValue(CGPoint: CGPointMake(staticX + 2 * circleRadious + 10, staticY))]
        animator.duration = 1.0
        animator.autoreverses = true
        animator.repeatCount = 10000
        animator.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)]
        dynamicCircle.layer.addAnimation(animator, forKey: "position")
        
        displayLink = CADisplayLink(target: self, selector: #selector(YNTLiquidLoaderView.update))
        displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
        shapeLayer = CAShapeLayer()
        
        PointA = CGPointMake(staticX, staticY + circleRadious)
        PointD = CGPointMake(staticX, staticY - circleRadious)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        let position = dynamicCircle.layer.presentationLayer()?.position
        if let position = position {
            sideDistance = fabs(position.x - staticCircle.layer.position.x)
            if sideDistance < 40 && sideDistance > 10{
                PointB = CGPointMake(position.x, position.y + circleRadious)
                PointC = CGPointMake(position.x, position.y - circleRadious)
                drawShape()
            }else if sideDistance < 10 {
                shapeLayer.fillColor = UIColor.clearColor().CGColor
                shapeLayer.removeFromSuperlayer()
            }
        }
    }
    
    func drawShape() {
        if PointB.x > PointA.x {//right
            PointO = CGPointMake(staticX + circleRadious + (sideDistance - 2 * circleRadious) / 2, staticY + 7 - (sideDistance - 2 * circleRadious) / 2)
            PointP = CGPointMake(staticX + circleRadious + (sideDistance - 2 * circleRadious) / 2, staticY - 7 + (sideDistance - 2 * circleRadious) / 2)
        }else {//left
            PointO = CGPointMake(staticX - circleRadious - (sideDistance - 2 * circleRadious) / 2, staticY + 7 - (sideDistance - 2 * circleRadious) / 2)
            PointP = CGPointMake(staticX - circleRadious - (sideDistance - 2 * circleRadious) / 2, staticY - 7 + (sideDistance - 2 * circleRadious) / 2)
        }
        
        let path = UIBezierPath()
        path.moveToPoint(PointA)
        path.addQuadCurveToPoint(PointB, controlPoint: PointO)
        path.addLineToPoint(PointC)
        path.addQuadCurveToPoint(PointD, controlPoint: PointP)
        path.closePath()
        
        shapeLayer.path = path.CGPath
        shapeLayer.fillColor = UIColor.redColor().CGColor
        layer.insertSublayer(shapeLayer, below: dynamicCircle.layer)
    }
}
