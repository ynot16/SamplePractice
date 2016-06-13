//
//  YnotTestView.swift
//  pratice
//
//  Created by bori－applepc on 16/3/24.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YnotTestView: UIView {

    @IBOutlet var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        NSBundle.mainBundle().loadNibNamed("YnotTestView", owner: self, options: nil).first
        addSubview(contentView)
        print("awake from nib")
    }
    
}
