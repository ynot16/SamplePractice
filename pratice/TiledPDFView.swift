//
//  TiledPDFView.swift
//  pratice
//
//  Created by bori－applepc on 16/4/21.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class TiledPDFView: UIView {
    var pdfPage: CGPDFPageRef?
    var myScale: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect, scale: CGFloat) {
        self.init(frame: frame)
        let tiledLayer = self.layer as? CATiledLayer
        
        tiledLayer?.levelsOfDetail = 4
        tiledLayer?.levelsOfDetailBias = 3
        tiledLayer?.tileSize = CGSizeMake(512.0, 512.0)
        myScale = scale
        layer.borderColor = UIColor.lightGrayColor().CGColor
        layer.borderWidth = 5
    }
    
    override class func layerClass() -> AnyClass {
        return CATiledLayer.self
    }
    
    func setPage(page: CGPDFPageRef) {
        pdfPage = page
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextSetRGBFillColor(ctx, 1.0, 1.0, 1.0, 1.0)
        CGContextFillRect(ctx, bounds)
        
        CGContextSaveGState(ctx)
        
        CGContextTranslateCTM(ctx, 0.0, bounds.size.height)
        CGContextScaleCTM(ctx, 1.0, -1.0)
        
        CGContextScaleCTM(ctx, myScale!, myScale!)
        CGContextDrawPDFPage(ctx, pdfPage!)
        
        CGContextRestoreGState(ctx)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
