//
//  AnimationSliderMenuViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit


class AnimationSliderMenuViewController: UIViewController {
    
    let menu = YNTSlideMenu(frame: CGRectMake(0, 0, 100, 100))

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.redColor()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        UIApplication.sharedApplication().delegate?.window!!.addSubview(menu)
    }
    
    override func viewWillLayoutSubviews() {
        
    }
}
