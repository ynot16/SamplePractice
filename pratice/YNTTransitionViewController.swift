//
//  YNTTransitionDemo.swift
//  pratice
//
//  Created by bori－applepc on 16/9/7.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTTransitionViewController: UIViewController, UINavigationControllerDelegate, UIViewControllerTransitioningDelegate {

    var transitionButton: UIButton!
    private var percentTransition: UIPercentDrivenInteractiveTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(named: "page1"))
        imageView.frame = view.bounds
        view.addSubview(imageView)
        
        transitionButton = UIButton(frame: CGRectMake(view.bounds.width - 40, 74, 30, 30))
        transitionButton.backgroundColor = UIColor.yellowColor()
        transitionButton.addTarget(self, action: #selector(buttonTap), forControlEvents: .TouchUpInside)
        view.addSubview(transitionButton)
        
        let edgePan = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(YNTTransitionViewController.edgePan))
        edgePan.edges = .Right
        view.addGestureRecognizer(edgePan)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.delegate = self
    }
    
    func edgePan(gesture: UIScreenEdgePanGestureRecognizer) {
        var per = (view.bounds.width - gesture.locationInView(view).x) / view.bounds.width
        per = min(1.0, max(0.0, per))
        
        if gesture.state == .Began {
            percentTransition = UIPercentDrivenInteractiveTransition()
            let secondVC = YNTTransitionSecondViewController()
            navigationController?.pushViewController(secondVC, animated: true)
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
    
    func buttonTap(sender: UIButton) {
        let secondVC = YNTTransitionSecondViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
    
    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return percentTransition
    }
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .Push {
            return YNTTransitionAnimator()
        }else {
            return nil
        }
    }
    
}
