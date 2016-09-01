//
//  AnimationSliderMenuViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit


class AnimationSliderMenuViewController: UIViewController {
    
    var menu: YNTSlideMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menu = YNTSlideMenu()
    }
    
    override func viewWillLayoutSubviews() {
        
    }
    @IBAction func triggle(sender: UIButton) {
        menu!.triggle()
    }
}
