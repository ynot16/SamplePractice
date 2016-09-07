//
//  YNTLiquidLoaderViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/31.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTLiquidLoaderViewController: UIViewController {

    lazy var fpsLabel: FPSLabel = {
        let fpsLabel = FPSLabel()
        return fpsLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(fpsLabel)
        
        let loadingView = YNTLiquidLoaderView(frame: CGRectMake(0, 0, 200, 60))
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor.lightGrayColor()
        loadingView.alpha = 0.5
        view.addSubview(loadingView)
        // Do any additional setup after loading the view.
    }
}
