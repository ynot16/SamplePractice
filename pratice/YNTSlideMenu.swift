//
//  YNTSlideMenu.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

let kWindow = UIApplication.sharedApplication().keyWindow

class YNTSlideMenu: UIView {
    
    var blurView: UIVisualEffectView!
    var diff: CGFloat = 0.0
    var topHelperView: UIView!
    var midHelperView: UIView!
    var isTriggle: Bool = false
    var displayLink: CADisplayLink?
    var animationCount: Int = 0
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init() {
        if let kWindow = kWindow {
            self.init(frame: CGRectMake(-kWindow.bounds.width / 2 - 50, 0, kWindow.bounds.width / 2 + 50, kWindow.bounds.height))
            self.backgroundColor = UIColor.clearColor()
            kWindow.addSubview(self)
        
            blurView = UIVisualEffectView(frame: kWindow.bounds)
            blurView.effect = UIBlurEffect(style: .Dark)
            blurView.alpha = 0.0
            
            
        
            topHelperView = UIView(frame: CGRectMake(-40, 0, 40, 40))
            topHelperView.backgroundColor = UIColor.redColor()
            topHelperView.hidden = true
            kWindow.addSubview(topHelperView)
            midHelperView = UIView(frame: CGRectMake(-40, kWindow.bounds.width / 2 - 20, 40, 40))
            midHelperView.backgroundColor = UIColor.yellowColor()
            midHelperView.hidden = true
            kWindow.addSubview(midHelperView)
            

            
        }else {
            self.init(frame: CGRectZero)
        }

    }
    
    func triggle() {
        if let kWindow = kWindow {

            if !isTriggle {
                kWindow.insertSubview(blurView, belowSubview: self)
                
                UIView.animateWithDuration(0.3, animations: { 
                    self.frame = CGRectMake(0, 0, self.frame.width, self.frame.height)
                })
                
                self.beginAnimation()
                
                UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.AllowUserInteraction , .BeginFromCurrentState], animations: { 
                        self.topHelperView.frame = CGRectMake(self.frame.width - 20, 0, 40, 40)
                    }, completion: nil)
                
                UIView.animateWithDuration(0.3, animations: { [weak self] () -> Void in
                    self?.blurView.alpha = 1.0
                    })
                
                UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [.AllowUserInteraction , .BeginFromCurrentState], animations: { 
                    self.midHelperView.frame = CGRectMake(self.frame.width - 20, self.midHelperView.frame.origin.y, 40, 40)

                    }, completion: { [weak self] (finished) in
                        self?.endAnimation()
                        let tap = UITapGestureRecognizer(target: self, action: #selector(YNTSlideMenu.unTriggle))
                        self?.blurView.addGestureRecognizer(tap)
                        self?.isTriggle = true
                })
                
            }else {
                UIView.animateWithDuration(0.3, animations: {
                    self.frame = CGRectMake(-kWindow.bounds.width / 2 - 50, 0, self.frame.width, self.frame.height)
                })
                
                UIView.animateWithDuration(0.7, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.9, options: [.AllowUserInteraction , .BeginFromCurrentState], animations: {
                    self.topHelperView.frame = CGRectMake(-40, 0, 40, 40)
                    }, completion: nil)
                
                UIView.animateWithDuration(0.3, animations: { [weak self] () -> Void in
                    self?.blurView.alpha = 0.0
                })
                
                UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2.0, options: [.AllowUserInteraction , .BeginFromCurrentState], animations: {
                    self.midHelperView.frame = CGRectMake(-40, self.midHelperView.frame.origin.y, 40, 40)
                    }, completion: { (finished) in
                        self.endAnimation()
                        self.isTriggle = false
                })
            }
        }
    }
    
    func unTriggle() {
        self.triggle()
    }
    
    func beginAnimation() {
        animationCount += 1
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(YNTSlideMenu.calculateDiff))
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        }
    }
    
    func endAnimation() {
        animationCount -= 1
        if animationCount == 0 {
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    
    func calculateDiff() {
        diff = (topHelperView.layer.presentationLayer()?.frame.origin.x)! - (midHelperView.layer.presentationLayer()?.frame.origin.x)!
                
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        path.moveToPoint(CGPointZero)
        path.addLineToPoint(CGPointMake(self.bounds.width - 50, 0))
        path.addQuadCurveToPoint(CGPointMake(self.bounds.width - 50, self.bounds.height), controlPoint: CGPointMake(self.bounds.width - 50 + diff, self.frame.height / 2))
        path.addLineToPoint(CGPointMake(0, self.frame.height))
        path.closePath()
        
        print("diff == \(diff)")
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
        CGContextAddPath(context, path.CGPath)
        UIColor.blueColor().set()
        CGContextFillPath(context)
        
    }
}
