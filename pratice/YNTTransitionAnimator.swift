//
//  YNTTransitionAnimator.swift
//  pratice
//
//  Created by bori－applepc on 16/9/7.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionContext: UIViewControllerContextTransitioning!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as!YNTTransitionViewController
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as!YNTTransitionSecondViewController
        
        let containerView = transitionContext.containerView()
        
        let button = fromVC.transitionButton
        let startBP = UIBezierPath(ovalInRect: button.frame)
        containerView?.addSubview(fromVC.view)
        containerView?.addSubview(toVC.view)
        
        var finalPoint: CGPoint!
        
        if button.frame.origin.x >= toVC.view.frame.size.width / 2 {
            if button.frame.origin.y <= toVC.view.frame.size.height / 2 {// 1
                finalPoint = CGPointMake(button.center.x, button.center.y - CGRectGetMaxY(toVC.view.bounds))
            }else {// 4
                finalPoint = CGPointMake(button.center.x, button.center.y)
            }
        }else {
            if button.frame.origin.y <= toVC.view.frame.size.height / 2 {// 2
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y - CGRectGetMaxY(toVC.view.bounds))
            }else {// 3
                finalPoint = CGPointMake(button.center.x - CGRectGetMaxX(toVC.view.bounds), button.center.y)
            }
        }
        
        let radious = sqrt((finalPoint.x * finalPoint.x) + (finalPoint.y + finalPoint.y))
        
        let endBP = UIBezierPath(ovalInRect: CGRectInset(button.frame, -radious, -radious))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = endBP.CGPath
        toVC.view.layer.mask = shapeLayer
        
        let pingAnimator = CABasicAnimation(keyPath: "path")
        pingAnimator.fromValue = startBP.CGPath
        pingAnimator.toValue = endBP.CGPath
        pingAnimator.duration = 0.5
        pingAnimator.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pingAnimator.delegate = self
        shapeLayer.addAnimation(pingAnimator, forKey: "path")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(!self.transitionContext.transitionWasCancelled())
        self.transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view.layer.mask = nil
        self.transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view.layer.mask = nil
    }
}
