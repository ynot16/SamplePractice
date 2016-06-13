//
//  SequenceViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/13.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class FibonacciGenerator: GeneratorType {
    var last = (0,1)
    var endAt: Int
    var lastIteration = 0
    
    init(end: Int) {
        endAt = end
    }
    
    func next() -> Int? {
        guard lastIteration < endAt else {
            return nil
        }
        
        lastIteration++
        
        let next = last.0
        last = (last.1,last.0 + last.1)
        return next
    }
}


class FibonacciSequence: SequenceType {
    var endAt: Int
    
    init(end: Int){
        endAt = end
    }
    
    func generate() -> FibonacciGenerator {
        return FibonacciGenerator(end: endAt)
    }
}


class SequenceViewController: UIViewController {

    @IBOutlet weak var showButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showButton.setTitle("ynot", forState: .Normal)
        
        var people = People()
        
        var ynotQueue = dispatch_queue_create("ynot.queue", DISPATCH_QUEUE_CONCURRENT)
        var group = dispatch_group_create()
        dispatch_group_async(group, ynotQueue) { () -> Void in
            print("i")
        }
        dispatch_group_async(group, ynotQueue) { () -> Void in
            print("love")
        }
        dispatch_group_async(group, ynotQueue) { () -> Void in
            print("egg")
        }
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            print("yes i do")
        }
        
        let num: Int? = 2
        num.flatMap{$0 * 2}
        num.map{$0 * 2}

        // Do any additional setup after loading the view.
    }
 
    
    func injected() {
        print("I've been injected: (self)")
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
