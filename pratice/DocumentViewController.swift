//
//  DocumentViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/8/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import SnapKit

class DocumentViewController: UIViewController, UIDocumentMenuDelegate, UIDocumentPickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton()
        button.backgroundColor = UIColor.redColor()
        button.setImage(UIImage(named: "lock-nor"), forState: .Normal)
        button.addTarget(self, action: #selector(DocumentViewController.showDocumentMenu(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(button)
        button.snp_makeConstraints { (make) in
            make.center.equalTo(view)
            make.width.height.equalTo(100)
        }
        button.setImage(UIImage(named: "unlock-nor"), forState: .Normal)
        // Do any additional setup after loading the view.
    }
    
    func showDocumentMenu(sender: UIButton) {
        
         /**
         import:从document provider，例如iCloud driver导入到本app
         export:从本app导出document到document driver（导出副本）
         open:打开document provider的文档，需要拿到权限
         move：移动document到新地方，创建副本移动到目标地址，随后删除源文件
         根据四个不同的操作，初始化方法不同。
         */
        
//        let url = NSBundle.mainBundle().URLForResource("input_pdf", withExtension: "pdf")
//        let documentMenu = UIDocumentMenuViewController(URL: url!, inMode: .ExportToService)
        let documentMenu = UIDocumentMenuViewController(documentTypes: ["public.content"], inMode: .Open)
        documentMenu.addOptionWithTitle("new document", image: UIImage(named: "docu"), order: .First) {
            print("hello")
        }
        documentMenu.delegate = self
        presentViewController(documentMenu, animated: true, completion: nil)
    }
    
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true, completion: nil)
    }
    
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        if url.startAccessingSecurityScopedResource() {
            print("load yessssssss")
        }
        print("url \(url)")
    }
}
