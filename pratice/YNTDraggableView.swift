//
//  YNTDraggableView.swift
//  pratice
//
//  Created by bori－applepc on 16/8/30.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class YNTDraggableView: UIView {
    
    private var frontView: UIView?
    private var backView: UIView?
    private var containerView: UIView?
    private var shapeLayer: CAShapeLayer?
    private var x1: CGFloat!
    private var y1: CGFloat!
    private var x2: CGFloat!
    private var y2: CGFloat!
    private var centerDistance: CGFloat!
    private var r1: CGFloat!
    private var r2: CGFloat!
    private var pointA: CGPoint!
    private var pointB: CGPoint!
    private var pointC: CGPoint!
    private var pointD: CGPoint!
    private var pointO: CGPoint!
    private var pointP: CGPoint!
    private var sinDigree: CGFloat!
    private var cosDigree: CGFloat!
    private var cuteColor: UIColor = UIColor.redColor()

    private var initialBackViewFrame: CGRect!
    private var initialBackViewCenter: CGPoint!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    
    convenience init(frame: CGRect, containerView: UIView) {
        self.init(frame: frame)
        
        self.containerView = containerView
        self.containerView?.addSubview(self)
        setUpView()
        
    }
    
    func setUpView() {
        shapeLayer = CAShapeLayer()
        frontView = UIView(frame: frame)
        frontView?.backgroundColor = cuteColor
        frontView?.layer.cornerRadius = bounds.width / 2
        containerView!.addSubview(frontView!)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(panTheView))
        frontView?.addGestureRecognizer(pan)
        
        backView = UIView(frame: frontView!.frame)
        backView?.backgroundColor = cuteColor
        backView?.layer.cornerRadius = bounds.width / 2
        containerView!.insertSubview(backView!, belowSubview: frontView!)
        
        initialBackViewFrame = backView?.frame
        initialBackViewCenter = backView?.center
        
        x1 = backView?.center.x
        y1 = backView?.center.y
        x2 = frontView?.center.x
        y2 = frontView?.center.y
        r1 = backView!.bounds.width / 2
        r2 = frontView!.bounds.width / 2
    }
    
    func panTheView(gesture: UIPanGestureRecognizer) {
        let dragPoint = gesture.locationInView(containerView)
        if gesture.state == .Began {
            r1 = initialBackViewFrame.width / 2
            backView!.hidden = false
            cuteColor = UIColor.redColor()
        }else if gesture.state == .Changed {
            frontView?.center = dragPoint
            
            if r1 <= 15 {
                backView?.hidden = true
                cuteColor = UIColor.clearColor()
                shapeLayer?.removeFromSuperlayer()
            }
            
            drawRect()
        }else if gesture.state == .Cancelled ||  gesture.state == .Ended ||  gesture.state == .Failed {
            backView!.hidden = true
            cuteColor = UIColor.clearColor()
            shapeLayer?.removeFromSuperlayer()
            if r1 > 15 {
                UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: .CurveEaseOut, animations: {
                    self.frontView!.center = self.initialBackViewCenter
                    }, completion: { (finished) in
                        self.backView?.hidden = false
                })
            }else {
                backView?.hidden = true
                frontView?.hidden = true
                backView?.removeFromSuperview()
                frontView?.removeFromSuperview()
                let expodeImage = UIImageView(image: UIImage(named: "cute-explode"))
                expodeImage.bounds = CGRectMake(0, 0, 60, 60)
                expodeImage.center = dragPoint
                expodeImage.alpha = 0.0
                containerView?.addSubview(expodeImage)
                UIView.animateWithDuration(0.2, animations: { 
                    expodeImage.alpha = 1.0
                    }, completion: { (finished) in
                        UIView.animateWithDuration(0.2, animations: { 
                            expodeImage.alpha = 0.0
                            }, completion: { (finished) in
                                expodeImage.hidden = true
                                expodeImage.removeFromSuperview()
                        })
                })
            }
        }
    }
    
    func drawRect() {
        x2 = frontView?.center.x
        y2 = frontView?.center.y
        let xTimesx = (x2 - x1) * (x2 - x1)
        let yTimesy = (y2 - y1) * (y2 - y1)
        centerDistance = sqrt(xTimesx + yTimesy)
        
        r1 = bounds.width / 2 - centerDistance / 20
        backView?.bounds = CGRectMake(0, 0, r1 * 2, r1 * 2)
        backView?.center = initialBackViewCenter
        backView?.layer.cornerRadius = r1
        
        if centerDistance == 0 {
            sinDigree = 0
            cosDigree = 1
        }else {
            sinDigree = (x2 - x1) / centerDistance
            cosDigree = (y2 - y1) / centerDistance
        }
        
        pointA = CGPointMake(x1 - r1 * cosDigree, y1 + r1 * sinDigree) // A
        pointB = CGPointMake(x1 + r1 * cosDigree, y1 - r1 * sinDigree) // B
        pointD = CGPointMake(x2 - r2 * cosDigree, y2 + r2 * sinDigree) // D
        pointC = CGPointMake(x2 + r2 * cosDigree, y2 - r2 * sinDigree) // C
        
        pointO = CGPointMake(pointA.x + (centerDistance / 2) * sinDigree, pointA.y + (centerDistance / 2) * cosDigree)
        pointP = CGPointMake(pointB.x + (centerDistance / 2) * sinDigree, pointB.y + (centerDistance / 2) * cosDigree)
        let path = UIBezierPath()
        path.moveToPoint(pointA)
        path.addQuadCurveToPoint(pointD, controlPoint: pointO)
        path.addLineToPoint(pointC)
        path.addQuadCurveToPoint(pointB, controlPoint: pointP)
        path.closePath()
        
        if backView!.hidden == false {
            shapeLayer?.path = path.CGPath
            shapeLayer?.fillColor = cuteColor.CGColor
            containerView?.layer.insertSublayer(shapeLayer!, below: frontView!.layer)
        }
    }
}

