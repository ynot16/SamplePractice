//
//  QuickLookViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/5/3.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import QuickLook

class QuickLookViewController: UIViewController {

    let quickLook = QLPreviewController()
    let url = NSBundle.mainBundle().URLForResource("input_pdf", withExtension: "pdf")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quickLook.dataSource = self
        
        let button = UIButton()
        button.backgroundColor = UIColor.redColor()
        view.addSubview(button)
        button.snp_makeConstraints { (make) -> Void in
            make.center.equalTo(self.view)
            make.width.height.equalTo(100)
        }
        
        button.addTarget(self, action: "buttonClick:", forControlEvents: .TouchUpInside)
        // Do any additional setup after loading the view.
    }
    
    func buttonClick(sender: UIButton) {
        if QLPreviewController.canPreviewItem(url!) {
            quickLook.currentPreviewItemIndex = 0
            presentViewController(quickLook, animated: true, completion: nil)
        }
    }
}

extension QuickLookViewController: QLPreviewControllerDataSource {
    
    func numberOfPreviewItemsInPreviewController(controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(controller: QLPreviewController, previewItemAtIndex index: Int) -> QLPreviewItem {
        return url!
    }
}