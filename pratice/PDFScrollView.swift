//
//  PDFScrollView.swift
//  pratice
//
//  Created by bori－applepc on 16/4/20.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class PDFScrollView: UIScrollView {
    
    
    private var _PDFPage: CGPDFPageRef?
    var pageRect: CGRect?
    var backgroundImageView: UIView?
    var tiledPDFView: TiledPDFView?
    var PDFScale: CGFloat?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    func initialize() {
        decelerationRate = UIScrollViewDecelerationRateFast
        delegate = self
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 5
        minimumZoomScale = 1
        maximumZoomScale = 5
    }
    
    func setPDFPage(PDFPage: CGPDFPageRef?) {
        _PDFPage = PDFPage
        if let pdfPage = PDFPage {
            pageRect = CGPDFPageGetBoxRect(pdfPage, .MediaBox)
            
            //拿到pdf与屏幕尺寸的比例，交给tiledPDFView渲染适配屏幕大小
            PDFScale = frame.size.width / pageRect!.size.width
            pageRect = CGRectMake(pageRect!.origin.x, pageRect!.origin.y, pageRect!.size.width * PDFScale!, pageRect!.size.height * PDFScale!)
        }else {
            pageRect = bounds
        }
        
        replaceTiledPDFViewWithFrame(pageRect!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        //centerThePDFView
        let boundSize = bounds.size
        var frameToCenter = tiledPDFView?.frame
        
        if frameToCenter?.size.width < bounds.size.width {
            frameToCenter?.origin.x = (boundSize.width - frameToCenter!.width) / 2
        } else {
            frameToCenter?.origin.x = 0
        }
        
        
        if frameToCenter?.size.height < boundSize.height {
            frameToCenter?.origin.y = (boundSize.height - frameToCenter!.height) / 2
        }else {
            frameToCenter?.origin.y = 0
        }
        
        tiledPDFView?.frame = frameToCenter!
        backgroundImageView?.frame = frameToCenter!
        
        tiledPDFView?.contentScaleFactor = 1.0
    }
    
    func replaceTiledPDFViewWithFrame(frame: CGRect) {
        let tiledPDFView = TiledPDFView(frame: frame, scale: PDFScale!)
        tiledPDFView.setPage(_PDFPage!)
        addSubview(tiledPDFView)
        self.tiledPDFView = tiledPDFView
        
    }
}

extension PDFScrollView: UIScrollViewDelegate {
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return tiledPDFView
    }
}



