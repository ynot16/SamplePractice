//
//  PresentingViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/10.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class PresentingViewController: UIViewController,SegueHandlerType {

    enum SegueIdentifier: String {
        case BlueBill
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blueColor()
        
        let presentButton = UIButton()
        presentButton.backgroundColor = UIColor.redColor()
        presentButton.addTarget(self, action: "presentToViewController:", forControlEvents: .TouchUpInside)
        view.addSubview(presentButton)
        
        presentButton.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(60)
            make.centerX.equalTo(view)
            make.top.equalTo(20)
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    func presentToViewController(sender: UIButton) {
        perfromSegueWithIdentifier(.BlueBill, sender: sender)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .BlueBill: print("i am the blue bill")
        }
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
