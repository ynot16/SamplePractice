//
//  YnotPlayerMaskView.swift
//  pratice
//
//  Created by bori－applepc on 16/3/11.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YnotPlayerMaskView: UIView {

    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awakeFromNib")
    }
    
    class func setUpPlayerMaskView() -> YnotPlayerMaskView {
        let ynotMaskView = NSBundle.mainBundle().loadNibNamed("YnotPlayerMaskView", owner: nil, options: nil).last as! YnotPlayerMaskView
        return ynotMaskView
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
