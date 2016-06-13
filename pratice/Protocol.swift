//
//  Protocol.swift
//  pratice
//
//  Created by bori－applepc on 16/3/10.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import Foundation


protocol SegueHandlerType {
    typealias SegueIdentifier: RawRepresentable
}

extension SegueHandlerType where Self: UIViewController, SegueIdentifier.RawValue == String {

    func perfromSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
        performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
    }
    
    func segueIdentifierForSegue(segue: UIStoryboardSegue) -> SegueIdentifier {
        guard let identifier = segue.identifier, segueIdentifier = SegueIdentifier(rawValue: identifier) else {
            fatalError("Invaild segue identifier \(segue.identifier)")
        }
        return segueIdentifier
    }
    
}