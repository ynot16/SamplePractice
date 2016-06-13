//
//  LayoutViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/15.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

extension UIView {
    
}

class LayoutViewController: UIViewController {

    @IBOutlet weak var labelLeftConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func layoutAction(sender: AnyObject) {
        self.labelLeftConstraint.constant = 100
//        UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .AllowAnimatedContent, animations: { () -> Void in
//
//            self.view.layoutSubviews()//不应该主动调用，需要layout就调用下面两个方法，重写此方法做其他适合的布局。
//            self.view.layoutIfNeeded()//有动画效果，因为是马上执行的
//            self.view.setNeedsLayout()//没动画效果，等待下一个update cycle时来layout，异步调用layoutIfNeeded刷新
//            }, completion: nil)
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
