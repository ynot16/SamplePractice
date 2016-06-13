//
//  YnotPlayerViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/11.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YnotPlayerViewController: UIViewController {

    @IBOutlet weak var playerView: YnotPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.setNeedsLayout()
        playerView.videoUrl = NSURL(string: "http://58.67.144.49:7001/ZXMobileELearning//WebFiles/cwFiles/%7B3D2A707A-FA3C-4685-BE60-489AFA7ECA85%7D.mp4")
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
