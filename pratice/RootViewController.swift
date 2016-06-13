//
//  RootViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/4/20.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var pageViewController: UIPageViewController?
    lazy var modelController: ModelController = {
        var modelVC = ModelController()
        return modelVC
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController = UIPageViewController(transitionStyle: .PageCurl, navigationOrientation: .Horizontal, options: nil)
        pageViewController?.delegate = self
        
        let startingViewController = modelController.viewControllerAtIndex(0)
        pageViewController?.setViewControllers([startingViewController], direction: .Forward, animated: true, completion: nil)
        pageViewController?.dataSource = modelController
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        
        let pageViewRect = view.bounds
        pageViewController!.view.frame = pageViewRect
        pageViewController?.didMoveToParentViewController(self)
//        view.gestureRecognizers = pageViewController?.gestureRecognizers
        // Do any additional setup after loading the view.
    }

}

extension RootViewController: UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, spineLocationForInterfaceOrientation orientation: UIInterfaceOrientation) -> UIPageViewControllerSpineLocation {
        if UIInterfaceOrientationIsPortrait(orientation) || UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            let currentViewController = pageViewController.viewControllers![0]
            pageViewController.setViewControllers([currentViewController], direction: .Forward, animated: true, completion: nil)
            pageViewController.doubleSided = false
            return .Min
        }
        
        let currentViewController = pageViewController.viewControllers![0] as! DataViewController
        let index = modelController.indexForViewController(currentViewController)
        if index == 0 || index % 2 == 0 {
            let nextViewController = modelController.pageViewController(pageViewController, viewControllerAfterViewController: currentViewController)
            pageViewController.setViewControllers([currentViewController, nextViewController!], direction: .Forward, animated: true, completion: nil)
        }else {
            let beforeViewController = modelController.pageViewController(pageViewController, viewControllerBeforeViewController: currentViewController)
            pageViewController.setViewControllers([beforeViewController!, currentViewController], direction: .Forward, animated: true, completion: nil)
        }
        return .Mid
    }
}
