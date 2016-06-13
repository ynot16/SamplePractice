//
//  SpringAnimator.swift
//  pratice
//
//  Created by bori－applepc on 16/2/15.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class SpringAnimator: NSObject {

}

extension SpringAnimator: UIViewControllerAnimatedTransitioning {
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containerView = transitionContext.containerView()
        
        var fromView = fromViewController?.view
        var toView = toViewController?.view
        
        if (transitionContext.respondsToSelector("viewForKey:")) {
            fromView = transitionContext.viewForKey(UITransitionContextFromViewKey)
            toView = transitionContext.viewForKey(UITransitionContextToViewKey)
        }
        
        toView?.frame = CGRectMake(fromView!.frame.origin.x, fromView!.frame.maxY / 2, fromView!.frame.size.width, fromView!.frame.size.height)
        toView?.alpha = 0.0
        
        containerView?.addSubview(toView!)
        
        let transitionDuration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(transitionDuration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .CurveLinear, animations: { () -> Void in
            toView!.alpha = 1.0     // 逐渐变为不透明
            toView?.frame = transitionContext.finalFrameForViewController(toViewController!)    // 移动到指定位置
            }) { (finished: Bool) -> Void in
                let wasCancelled = transitionContext.transitionWasCancelled()
                transitionContext.completeTransition(!wasCancelled)
        }
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 2
    }
}


