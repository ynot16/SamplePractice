//
//  YNTCircle.swift
//  pratice
//
//  Created by bori－applepc on 16/9/1.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTCircle: UIView {

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor.redColor()
        self.layer.cornerRadius = frame.size.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
