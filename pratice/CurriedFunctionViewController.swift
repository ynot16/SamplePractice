//
//  CurriedFunctionViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/2/25.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class CurriedFunctionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        self.classFunction() {
            self.testFunction()
        }
        
        let curriedF = self.curriedFunction(2)
        print("\(curriedF(b: 4))")
        
        // Do any additional setup after loading the view.
    }
    
    func classFunction(f: () -> ()) {
        f()
    }
    
    func testFunction() {
        
    }
    
    func curriedFunction(a: Int)(b: Int) -> Int {
        return a + b
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

//extension UIViewController {
//    
//    public override class func initialize() {
//        print("i am the initialize method")
//    }
//}




