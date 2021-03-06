//
//  FPSLabel.swift
//  pratice
//
//  Created by bori－applepc on 16/5/3.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit


class FPSLabel: UILabel {
    
    private var displayLink: CADisplayLink?
    private var lastTime: NSTimeInterval = 0
    private var count: Int = 0
    
    deinit {
        displayLink?.invalidate()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        frame = CGRect(x: 15, y: 150, width: 40, height: 40)
        layer.cornerRadius = 20
        clipsToBounds = true
        backgroundColor = UIColor.blackColor()
        textColor = UIColor.greenColor()
        textAlignment = .Center
        font = UIFont.systemFontOfSize(24)
        
        run()
    }
    
    func run() {
        
        displayLink = CADisplayLink(target: self, selector: "tick:")
        displayLink?.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
    }
    
    func tick(displayLink: CADisplayLink) {
        
        if lastTime == 0 {
            lastTime = displayLink.timestamp
            return
        }
        
        count += 1
        
        let timeDelta = displayLink.timestamp - lastTime
        
        if timeDelta < 0.25 {
            return
        }
        
        lastTime = displayLink.timestamp
        
        let fps: Double = Double(count) / timeDelta
        
        count = 0
        
        text = String(format: "%.0f", fps)
        textColor = fps > 50 ? UIColor.greenColor() : UIColor.redColor()
    }
}