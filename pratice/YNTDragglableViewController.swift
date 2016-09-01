//
//  YNTDragglableViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/30.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTDragglableViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = YNTDraggableView(frame: CGRectMake(200, 100, 60, 60), containerView: view)
//        view.addSubview(draggableView)
        // Do any additional setup after loading the view.
    }

}
