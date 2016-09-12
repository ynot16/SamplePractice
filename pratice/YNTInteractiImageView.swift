//
//  YNTInteractiImageView.swift
//  pratice
//
//  Created by bori－applepc on 16/9/12.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

struct InteractiveOptions {
    var duration: NSTimeInterval = 0.3
    var damping: CGFloat = 0.6
    var scrollDistance: CGFloat = 100.0
}

class YNTInteractiImageView: UIImageView {

    private var option: InteractiveOptions
    var dimmingView: UIView?
    var containerView: UIView?
    var initialPoint: CGPoint = CGPointZero
    
    
    init(image: UIImage?, option: InteractiveOptions) {
        self.option = option
        super.init(image: image)
        layer.cornerRadius = 8
        layer.masksToBounds = true
        self.userInteractionEnabled = true
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        self.addGestureRecognizer(pan)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func willMoveToSuperview(newSuperview: UIView?) {
        super.willMoveToSuperview(newSuperview)
        initialPoint = center
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        var factorOfAngle: CGFloat = 0.0
        var factorOfScale: CGFloat = 0.0
        
        if gesture.state == .Began {
            
        }else if gesture.state == .Changed {
            let transitionPoint = gesture.translationInView(containerView)
            self.center = CGPointMake(initialPoint.x, initialPoint.y +  transitionPoint.y)
            let Y = min(option.scrollDistance, max(0, abs(transitionPoint.y)))
            //一个开口向下,顶点(SCROLLDISTANCE/2,1),过(0,0),(SCROLLDISTANCE,0)的二次函数
            factorOfAngle = max(0.0,-4.0/(CGFloat(option.scrollDistance)*CGFloat(option.scrollDistance))*Y*(Y-CGFloat(option.scrollDistance)));
            //一个开口向下,顶点(SCROLLDISTANCE,1),过(0,0),(2*SCROLLDISTANCE,0)的二次函数
            factorOfScale = max(0.0,-1/(CGFloat(option.scrollDistance)*CGFloat(option.scrollDistance))*Y*(Y-2*CGFloat(option.scrollDistance)));
            var t = CATransform3DIdentity
            t.m34 = -1.0/1000
            t = CATransform3DRotate(t,factorOfAngle*(CGFloat(M_PI/5)), transitionPoint.y>0 ? -1 : 1, 0, 0)
            t = CATransform3DScale(t, 1-factorOfScale*0.2, 1-factorOfScale*0.2, 0)
            layer.transform = t
            dimmingView?.alpha = 1.0 - Y / option.scrollDistance
        }else {
            UIView.animateWithDuration(option.duration, delay: 0, usingSpringWithDamping: option.damping, initialSpringVelocity: 0, options: .CurveEaseOut, animations: { 
                self.layer.transform = CATransform3DIdentity
                self.center = self.initialPoint
                self.dimmingView?.alpha = 1.0
                }, completion: nil)
        }
    }
}
