//
//  TestView.swift
//  pratice
//
//  Created by bori－applepc on 16/3/15.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class TestView: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.text = "asdasdasd"
        print("layoutSubviews")
    }

    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        print("layoutIfNeeded")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        print("setNeedsLayout")
    }
//
    override func setNeedsDisplay() {
        super.setNeedsDisplay()
        print("setNeedsDisplay")
    }
}
