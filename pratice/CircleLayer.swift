//
//  CircleLayer.swift
//  pratice
//
//  Created by bori－applepc on 16/8/27.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class CircleLayer: CALayer {
    
    enum MovedPoint: Int {
        case B_POINT, D_POINT
    }
    
    let outsideRectSize: CGFloat = 90.0
    
    var outsideRect: CGRect!
    var lastProgress: CGFloat = 0.5
    var movedPoint: MovedPoint?
    
    var progress: CGFloat = 0.0 {
        
        didSet {
            
            //外接矩形在左侧，则改变B点；在右边，改变D点
            if progress <= 0.5 {
                movedPoint = .B_POINT;
                print("B点动")
            }else{
                movedPoint = .D_POINT;
                print("D点动")
            }
            
            self.lastProgress = progress
            
            let buff = (bounds.size.width - outsideRectSize) * (progress - 0.5)
            print("buff = \(buff)")
            let origin_x = position.x + buff - (UIScreen.mainScreen().bounds.size.width - 320) / 2 - outsideRectSize / 2
            let origin_y = position.y - (UIScreen.mainScreen().bounds.size.height - 320) / 2 - outsideRectSize / 2
            outsideRect = CGRectMake(origin_x, origin_y, outsideRectSize, outsideRectSize)
            print("outside rect = \(outsideRect), \(position.x), \(position.y)")
            setNeedsDisplay()
        }
    }

    override init() {
        super.init()
    }
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? CircleLayer {
            progress = layer.progress
            outsideRect = layer.outsideRect
            lastProgress = layer.lastProgress
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawInContext(ctx: CGContext) {
        let offset = outsideRectSize / 3.6
        let movedDistance = (outsideRectSize / 6) * fabs(progress - 0.5) * 2
//        let rectCenter = CGPointMake(outsideRect.origin.x + outsideRectSize / 2, outsideRect.origin.y + outsideRectSize / 2)
        
        let pointA = CGPointMake(outsideRect.midX, outsideRect.minY + movedDistance)
        let pointB = CGPointMake(movedPoint == .D_POINT ? outsideRect.maxX : outsideRect.maxX + movedDistance*2 ,outsideRect.midY)
        let pointC = CGPointMake(outsideRect.midX, outsideRect.maxY - movedDistance)
        let pointD = CGPointMake(movedPoint == .D_POINT ? outsideRect.minX - movedDistance * 2 : outsideRect.minX, outsideRect.midY)
        
        let c1 = CGPointMake(pointA.x + offset, pointA.y)
        let c2 = CGPointMake(pointB.x, movedPoint == .D_POINT ? pointB.y - offset : pointB.y - offset + movedDistance)
        let c3 = CGPointMake(pointB.x, movedPoint == .D_POINT ? pointB.y + offset : pointB.y + offset - movedDistance)
        let c4 = CGPointMake(pointC.x + offset, pointC.y)
        let c5 = CGPointMake(pointC.x - offset, pointC.y)
        let c6 = CGPointMake(pointD.x, movedPoint == .D_POINT ? pointD.y + offset - movedDistance : pointD.y + offset)
        let c7 = CGPointMake(pointD.x, movedPoint == .D_POINT ? pointD.y - offset + movedDistance : pointD.y - offset)
        let c8 = CGPointMake(pointA.x - offset, pointA.y)
        
        let rectPath = UIBezierPath(rect: outsideRect)
        CGContextAddPath(ctx, rectPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetLineWidth(ctx, 1.0)
        let dash = [CGFloat(5.0), CGFloat(5.0)]
        CGContextSetLineDash(ctx, 0.0, dash, 2)
        CGContextStrokePath(ctx)
        
        let ovalPath = UIBezierPath()
        ovalPath.moveToPoint(pointA)
        ovalPath.addCurveToPoint(pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurveToPoint(pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurveToPoint(pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurveToPoint(pointA, controlPoint1: c7, controlPoint2: c8)
        CGContextAddPath(ctx, ovalPath.CGPath)
        CGContextSetStrokeColorWithColor(ctx, UIColor.blackColor().CGColor)
        CGContextSetFillColorWithColor(ctx, UIColor.redColor().CGColor)
        CGContextSetLineDash(ctx, 0.0, nil, 0)
        CGContextDrawPath(ctx, .FillStroke)
        
        
    }
    
    
    
    
    
    
    
    
}
