//
//  YNTInteractiveViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/9/12.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTInteractiveViewController: UIViewController {

    var card: YNTInteractiImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var option = InteractiveOptions()
        option.damping = 0.7
        option.duration = 0.5
        option.scrollDistance = 200.0
        
        card = YNTInteractiImageView(image: UIImage(named: "pic01"), option: option)
        card.center = view.center
        card.bounds = CGRectMake(0, 0, 200, 125)
        card.containerView = view
        
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        blurView.frame = view.bounds
        view.addSubview(blurView)
        card.dimmingView = blurView
        
        let backView = UIView()
        backView.frame = view.bounds
        view.addSubview(backView);
        
        backView.addSubview(card)
        
        let button = UIButton(frame: CGRectMake(0, 0, 50, 50))
        button.backgroundColor = UIColor.redColor()
        button.addTarget(self, action: #selector(buttonTap), forControlEvents: .TouchUpInside)
        view.addSubview(button)
    }
    
    func buttonTap(sender: UIButton) {
        card.bounds = CGRectMake(0, 0, 300, 300)
    }
}
