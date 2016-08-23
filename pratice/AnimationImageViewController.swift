//
//  AnimationImageViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/4/28.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class AnimationImageViewController: UIViewController {

    lazy var animationImage: UIImageView = {
        
        let imageView = UIImageView(frame: CGRectMake(100, 100, 100, 100))
        var imageArray = [UIImage]()
        for i in 1..<12 {
            let image = UIImage(named: "\(i)00")
            imageArray.append(image!)
        }
        imageView.animationImages = imageArray
        imageView.animationDuration = 1.5
        imageView.animationRepeatCount = 0
        
        return imageView
    }()
    
    lazy var fpsLabel: FPSLabel = {
        let fpsLabel = FPSLabel()
        return fpsLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(fpsLabel)
        self.navigationItem
        
        animationImage.startAnimating()
        view.addSubview(animationImage)
        
        // Do any additional setup after loading the view.
    }

}
