//
//  FitstModel.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import Foundation

class FirstModel {
    var name: String = ""
    var uid: String = ""
    var headImage: String = ""
    var desc: String = ""
    lazy var secondModelArray = [SecondModel]()
    var shouldUpdateCache: Bool = false
}
