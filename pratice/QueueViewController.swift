//
//  QueueViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/2/23.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class QueueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conQueue: dispatch_queue_t = dispatch_queue_create("com.ynotcc.conqueue", DISPATCH_QUEUE_CONCURRENT)
        
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            print("arrived the serial queue")
//            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
//                print("the dead lock")
//            })
            dispatch_sync(conQueue, { () -> Void in
                print("the dead lock will not occur")
            })
        }
        print("i am back immediately")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
