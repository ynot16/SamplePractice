//
//  AnimationCircleDemoViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class AnimationCircleDemoViewController: UIViewController {

    @IBOutlet weak var sliderView: UISlider!
    @IBOutlet weak var progressLabel: UILabel!
    let circleLayer = CircleLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleLayer.bounds = CGRectMake(0, 0, 320, 320)
        circleLayer.position = view.center
        circleLayer.progress = CGFloat(sliderView.value)
        circleLayer.backgroundColor = UIColor.yellowColor().CGColor
        view.layer.addSublayer(circleLayer)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func sliderValueChanged(sender: AnyObject) {
        progressLabel.text = "Current Progress: \(sliderView.value)"
        circleLayer.progress = CGFloat(sliderView.value)
    }
}
