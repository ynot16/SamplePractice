//
//  YNTJumpViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/9/7.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit


class YNTJumpViewController: UIViewController {
    
    enum State {
        case Mark, Not_Mark
    }
    
    private var starView: UIImageView!
    private var animating = false
    private var state: State = .Mark {
        
        didSet {
            self.starView.image = state == State.Mark ? UIImage(named: "icon_star_incell") : UIImage(named: "blue_dot")
        }
    }
    
    
    private var downloadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.yellowColor()
        
        setupStarView()
        
        setupDownloadView()
    }
    
    // MARK: DownloadView Demo
    
    func setupDownloadView() {
        downloadButton = UIButton(frame: CGRectMake(view.center.x - 35, 100, 70, 70))
        downloadButton.backgroundColor = UIColor.blueColor()
        downloadButton.addTarget(self, action: #selector(downloadAction), forControlEvents: .TouchUpInside)
        downloadButton.layer.cornerRadius = 35
        downloadButton.layer.masksToBounds = true
        view.addSubview(downloadButton)
    }
    
    func downloadAction(sender: UIButton) {
        let animationBounds = CABasicAnimation(keyPath: "bounds")
        animationBounds.fromValue = NSValue(CGRect: CGRectMake(0, 0, 70, 70))
        animationBounds.toValue = NSValue(CGRect: CGRectMake(0, 0, 250, 40))
        animationBounds.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationRadious = CABasicAnimation(keyPath: "cornerRadius")
        animationRadious.fromValue = 20
        animationRadious.toValue = 20
        animationRadious.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 0.2
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        animationGroup.animations = [animationBounds, animationRadious]
        downloadButton.layer.addAnimation(animationGroup, forKey: "downloading")
        
    }
    
    
    // MARK: Jump Star Demo
    
    func setupStarView() {
        starView = UIImageView(image: UIImage(named: "icon_star_incell"))
        starView.frame = CGRectMake(0, 0, 19, 19)
        starView.center = view.center
        view.addSubview(starView)
        
        
        let jumpButton = UIButton(frame: CGRectMake(starView.frame.origin.x, starView.frame.origin.y + 70, 19, 19))
        jumpButton.backgroundColor = UIColor.blueColor()
        jumpButton.addTarget(self, action: #selector(jumpAction), forControlEvents: .TouchUpInside)
        view.addSubview(jumpButton)
    }
    
    func jumpAction(sender: UIButton) {
        if animating {
            return
        }
        animating = true
        
        
        let animationFlip = CABasicAnimation(keyPath: "transform.rotation.y")
        animationFlip.fromValue = 0
        animationFlip.toValue = M_PI_2
        animationFlip.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animationUp = CABasicAnimation(keyPath: "position.y")
        animationUp.fromValue = starView.center.y
        animationUp.toValue = starView.center.y - 20
        animationUp.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animaitonGroup = CAAnimationGroup()
        animaitonGroup.duration = 0.125
        animaitonGroup.removedOnCompletion = false
        animaitonGroup.fillMode = kCAFillModeForwards
        animaitonGroup.delegate = self
        animaitonGroup.animations = [animationFlip, animationUp]
        starView.layer.addAnimation(animaitonGroup, forKey: "jumpUp")
        
        state = state == .Mark ? .Not_Mark : .Mark
        
        let animationFlipBack = CABasicAnimation(keyPath: "transform.rotation.y")
        animationFlipBack.fromValue = M_PI_2
        animationFlipBack.toValue = M_PI
        animationFlipBack.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animationDown = CABasicAnimation(keyPath: "position.y")
        animationDown.fromValue = starView.center.y - 20
        animationDown.toValue = starView.center.y
        animationDown.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let animationBackGroup = CAAnimationGroup()
        animationBackGroup.duration = 0.215
        animationBackGroup.fillMode = kCAFillModeForwards
        animationBackGroup.removedOnCompletion = false
        animationBackGroup.animations = [animationFlipBack, animationDown]
        let currentTime = CACurrentMediaTime()
        let timeInStarLayer = starView.layer.convertTime(currentTime, fromLayer: nil)
        animationBackGroup.beginTime = 0.125 + timeInStarLayer
        animationBackGroup.delegate = self
        starView.layer.addAnimation(animationBackGroup, forKey: "jumpDown")
        
        animating = false
    }
    
    
    
    
    
    
    
    
    
    
}
