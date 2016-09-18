//
//  YNTCAFirstViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/9/18.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTCAFirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let button = UIButton()
        button.bounds = CGRectMake(0, 0, 100, 100)
        button.center = view.center
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: #selector(jumpCubeView), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        
        // Do any additional setup after loading the view.
    }
    
    func jumpCubeView(sender: UIButton) {
        let tipViewController = YNTCATipViewController(nibName: "YNTCATipViewController", bundle: nil)
        navigationController?.pushViewController(tipViewController, animated: true)
    }
}

