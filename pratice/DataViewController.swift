//
//  DataViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/4/20.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {
    
    /** pdf*/
    var pdf: CGPDFDocumentRef?
    var page: CGPDFPageRef?
    var pageNumber: Int?
    var myScale: CGFloat?
    var scrollView = PDFScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        page = CGPDFDocumentGetPage(pdf, pageNumber!)
        
        //scrollView拿到具体某一页，交给tiledPDFView渲染
        scrollView.setPDFPage(page!)
        restoreScale()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.interfaceOrientation == .Portrait || self.interfaceOrientation == .PortraitUpsideDown {
            scrollView.userInteractionEnabled = true
        } else {
            scrollView.userInteractionEnabled = false
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        if fromInterfaceOrientation == .Portrait || fromInterfaceOrientation == .PortraitUpsideDown {
            scrollView.userInteractionEnabled = false
        } else {
           scrollView.userInteractionEnabled = true
        }
    }
    
    func setupUI() {
        scrollView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(scrollView)
        
        scrollView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(UIEdgeInsetsZero)
        }
    }
    
    func restoreScale() {
        let pageRect = CGPDFPageGetBoxRect(page, .MediaBox)
        let yScale = view.frame.size.height / pageRect.size.height
        let xScale = view.frame.size.width / pageRect.size.width
        myScale = min(xScale, yScale)
        scrollView.bounds = view.bounds
        scrollView.zoomScale = 1.0
        scrollView.PDFScale = myScale
        scrollView.tiledPDFView?.bounds = view.bounds
        scrollView.tiledPDFView?.myScale = myScale
        scrollView.tiledPDFView?.layer.setNeedsDisplay()
        
    }
}
