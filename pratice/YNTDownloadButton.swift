//
//  YNTDownloadButton.swift
//  pratice
//
//  Created by bori－applepc on 16/9/8.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTDownloadButton: UIView {
    
    private let progressBarHeight: CGFloat = 60.0
    private var animating = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer(target: self, action: #selector(downloadAction))
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadAction(sender: UIButton) {
        
        if animating {
            return
        }
        animating = true
        
        // 动画结束后维持最后状态方式1
        bounds = CGRectMake(0, 0, 300, 60)
        layer.cornerRadius = 30
        
        let animationBounds = CABasicAnimation(keyPath: "bounds")
        animationBounds.fromValue = NSValue(CGRect: CGRectMake(0, 0, 100, 100))
        animationBounds.toValue = NSValue(CGRect: CGRectMake(0, 0, 300, 60))
        animationBounds.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationRadious = CABasicAnimation(keyPath: "cornerRadius")
        animationRadious.fromValue = 50
        animationRadious.toValue = 30
        animationRadious.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.2
        // 动画结束后维持最后状态方式2
//        animationGroup.fillMode = kCAFillModeForwards
//        animationGroup.removedOnCompletion = false
        animationGroup.animations = [animationBounds, animationRadious]
        animationGroup.delegate = self
        animationGroup.setValue("readyToDownload", forKey: "animationName")
        layer.addAnimation(animationGroup, forKey: "readyToDownload")
        
    }
    
    func checkAniamtion() {
        let rectInCircle = CGRectInset(bounds, sqrt(50.0), sqrt(50.0))
        
        let path = UIBezierPath()
        path.moveToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width / 9, rectInCircle.origin.y + rectInCircle.size.width * 2/3 ))
        path.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width / 3, rectInCircle.origin.y + rectInCircle.size.width * 9/10))
        path.addLineToPoint(CGPointMake(rectInCircle.origin.x + rectInCircle.size.width * 8/10, rectInCircle.origin.y + rectInCircle.size.width / 5))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.CGPath
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.fillColor = UIColor.clearColor().CGColor
        shapeLayer.strokeColor = UIColor.whiteColor().CGColor
        shapeLayer.lineWidth = 10
        layer.addSublayer(shapeLayer)
        let checkAnima = CABasicAnimation(keyPath: "strokeEnd")
        checkAnima.duration = 0.2
        checkAnima.fromValue = 0.0
        checkAnima.toValue = 1.0
        checkAnima.delegate = self
        checkAnima.setValue("checkAnimation", forKey: "animationName")
        shapeLayer.addAnimation(checkAnima, forKey: "checkAniamtion")
    }
    
    override func animationDidStart(anim: CAAnimation) {
        if anim.isEqual(layer.animationForKey("cornerExpand")) {
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .CurveEaseOut, animations: { 
                self.bounds = CGRectMake(0, 0, 100, 100)
                self.backgroundColor = UIColor(colorLiteralRed: 0.1803921, green: 0.8, blue: 0.44313725, alpha: 1.0)
                }, completion: { (finished) in
                    if finished {
                        self.layer.removeAllAnimations()
                        self.checkAniamtion()
                        
                        self.animating = false
                    }
            })
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        if !flag {
            return
        }
        
        if anim.valueForKey("animationName")!.isEqualToString("readyToDownload") {
            let shapeLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.moveToPoint(CGPointMake(progressBarHeight / 2, progressBarHeight / 2))
            path.addLineToPoint(CGPointMake(bounds.size.width - progressBarHeight / 2, progressBarHeight / 2))
            shapeLayer.path = path.CGPath
            shapeLayer.strokeColor = UIColor.whiteColor().CGColor
            shapeLayer.lineWidth = progressBarHeight - 10
            shapeLayer.lineCap = kCALineCapRound
            layer.addSublayer(shapeLayer)
            let progressAnim = CABasicAnimation(keyPath: "strokeEnd")
            progressAnim.duration = 2.0
            progressAnim.fromValue = 0.0
            progressAnim.toValue = 1.0
            progressAnim.delegate = self
            progressAnim.setValue("progressBarAnimation", forKey: "animationName")
            shapeLayer.addAnimation(progressAnim, forKey: "progress")
            
        }else if anim.valueForKey("animationName")!.isEqualToString("progressBarAnimation") {
            UIView.animateWithDuration(0.3, animations: { 
                for subLayer in self.layer.sublayers! {
                    subLayer.opacity = 0.0
                }
                }, completion: { (finished) in
                    if finished  {
                        for subLayer in self.layer.sublayers! {
                            subLayer.removeFromSuperlayer()
                        }
                        
                        self.layer.cornerRadius = 50
                        let cornerAnim = CABasicAnimation(keyPath: "cornerRadius")
                        cornerAnim.fromValue = 30
                        cornerAnim.toValue = 50
                        cornerAnim.duration = 0.2
                        cornerAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                        cornerAnim.delegate = self
                        cornerAnim.setValue("cornerRadius", forKey: "animationName")
                        self.layer.addAnimation(cornerAnim, forKey: "cornerExpand")
                    }
            })
        }else if anim.valueForKey("animationName")!.isEqualToString("checkAnimation") {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                UIView.animateWithDuration(0.3, animations: {
                    for subLayer in self.layer.sublayers! {
                        subLayer.opacity = 0.0
                    }
                    }, completion: { (finished) in
                        for sublayer in self.layer.sublayers! {
                            sublayer.removeFromSuperlayer()
                        }
                        self.backgroundColor = UIColor.blueColor()
                })
            })
 
        }
    }
}
