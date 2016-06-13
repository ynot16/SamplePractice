//
//  TransitionViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/2/15.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class TransitionViewController: UIViewController {
    lazy var secondViewController: TransitionSecondViewController = TransitionSecondViewController()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.whiteColor()
        secondViewController.transitioningDelegate = self
        secondViewController.modalPresentationStyle = .FullScreen
        
    }
    
    @IBAction func presentAction(sender: AnyObject) {
        self.presentViewController(secondViewController, animated: true, completion: nil)
    }
}

extension TransitionViewController: UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SpringAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SpringAnimator()
    }
}
