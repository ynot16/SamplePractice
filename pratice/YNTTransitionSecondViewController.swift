//
//  YNTTransitionSecondViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/9/7.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTTransitionSecondViewController: UIViewController, UINavigationControllerDelegate {
    
    private var percentTransition: UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "page2"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(YNTTransitionSecondViewController.edgePan))
        edgePan.edges = .Left
        view.addGestureRecognizer(edgePan)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    func edgePan(gesture: UIScreenEdgePanGestureRecognizer) {
        var per = gesture.locationInView(view).x / view.bounds.width
        per = min(1.0, max(0.0, per))
        
        if gesture.state == .Began {
            percentTransition = UIPercentDrivenInteractiveTransition()
            navigationController?.popViewControllerAnimated(true)
        }else if gesture.state == .Changed {
            percentTransition.updateInteractiveTransition(per)
        }else if gesture.state == .Ended || gesture.state == .Cancelled {
            if per < 0.3 {
                percentTransition.cancelInteractiveTransition()
            }else {
                percentTransition.finishInteractiveTransition()
            }
            percentTransition = nil
        }
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentTransition
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Pop {
            return PingInvertTransition()
        }else {
            return nil
        }
    }
}
