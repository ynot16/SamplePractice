//
//  YNTSlideMenu.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

let kWindow = UIApplication.sharedApplication().keyWindow

class YNTSlideMenu: UIView {
    
    var blurView: UIVisualEffectView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init() {
//        if let kWindow = kWindow {
            self.init(frame: CGRectMake(100 / 2, 0,100, 100))
            self.backgroundColor = UIColor.blueColor()
//            kWindow.addSubview(self)
        
//            blurView = UIVisualEffectView(frame: kWindow.bounds)
//            blurView.effect = UIBlurEffect(style: .ExtraLight)
//            //        blurView.alpha = 0.0
//            kWindow.insertSubview(blurView, belowSubview: self)
//        }else {
//            self.init(frame: CGRectZero)
//        }

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.blueColor()
    }
    

}
