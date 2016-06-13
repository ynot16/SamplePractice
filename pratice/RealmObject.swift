//
//  RealmObject.swift
//  pratice
//
//  Created by bori－applepc on 16/3/14.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import Foundation
import RealmSwift

class ConsumeType: Object {
    var name = " "
    var owners: [ConsumeItem] {
        return LinkingObjects(fromType: ConsumeType.self, property: "type")
    }
}

class ConsumeItem: Object {
    dynamic var name = ""
    dynamic var cost = 0.00
    dynamic var date = NSDate()
    dynamic var type: ConsumeType?

    
}


class Channel: Object {
    var channel_id = ""
    var name = ""
    var name_en = ""
    var seq_id = 0
    var abbr_en = ""
    
    override static func primaryKey() -> String? {
        return "channel_id"
    }
}