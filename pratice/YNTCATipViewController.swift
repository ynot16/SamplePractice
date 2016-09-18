//
//  YNTCATipViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/9/18.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import GLKit

class YNTCATipViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet var faces: [UIView]!
    
    private var preLocation: CGPoint! = CGPointZero
    private var perspective = CATransform3DIdentity

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = UIColor.lightGrayColor()
        
        perspective.m34 = -1.0/500.0
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI_4), 1, 0, 0)
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI_4), 0, 1, 0)
        containerView.layer.sublayerTransform = perspective
        
        
        var transform = CATransform3DMakeTranslation(0, 0, 100)
        addFace(0, transform: transform)
        
        transform = CATransform3DMakeTranslation(100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 0, 1, 0)
        addFace(1, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, -100, 0)
        transform = CATransform3DRotate(transform, CGFloat(M_PI_2), 1, 0, 0)
        addFace(2, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 100, 0)
        transform = CATransform3DRotate(transform, CGFloat(-M_PI_2), 1, 0, 0)
        addFace(3, transform: transform)
        
        transform = CATransform3DMakeTranslation(-100, 0, 0)
        transform = CATransform3DRotate(transform, CGFloat(-M_PI_2), 0, 1, 0)
        addFace(4, transform: transform)
        
        transform = CATransform3DMakeTranslation(0, 0, -100)
        transform = CATransform3DRotate(transform, CGFloat(M_PI), 0, 1, 0)
        addFace(5, transform: transform)
        
        // Do any additional setup after loading the view.
    }
    
    func addFace(index: NSInteger, transform: CATransform3D) {
        let face = faces[index]
        containerView.addSubview(face)
        let containerSize = containerView.bounds.size
        face.center = CGPointMake(containerSize.width / 2, containerSize.height / 2)
        face.layer.doubleSided = false
        face.layer.transform = transform
        
//        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
//        face.addGestureRecognizer(pan)
        
        applyLightingToFace(face.layer)
    }

    func applyLightingToFace(face: CALayer) {
        let layer = CALayer()
        layer.frame = face.bounds
        face.addSublayer(layer)
        let transform = face.transform
        let matrix4 = GLKMatrix4(m: (Float(transform.m11), Float(transform.m12), Float(transform.m13), Float(transform.m14), Float(transform.m21), Float(transform.m22), Float(transform.m23), Float(transform.m24), Float(transform.m31), Float(transform.m32), Float(transform.m33), Float(transform.m34), Float(transform.m41), Float(transform.m42), Float(transform.m43), Float(transform.m44)))
        let matrix3 = GLKMatrix4GetMatrix3(matrix4)
        var normal = GLKVector3Make(0, 0, 1)
        normal = GLKMatrix3MultiplyVector3(matrix3, normal)
        normal = GLKVector3Normalize(normal)
        let light = GLKVector3Normalize(GLKVector3Make(0, 1, -0.5))
        let dotProduct = GLKVector3DotProduct(light, normal)
        let shadow = 1 + dotProduct - 0.5
        let color = UIColor.init(white: 0, alpha: CGFloat(shadow))
        layer.backgroundColor = color.CGColor
    }
    
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let currentLocation = gesture.locationInView(view)
        
        perspective = CATransform3DRotate(perspective, CGFloat(-M_PI/16), 0, 1, 0)
        containerView.layer.sublayerTransform = perspective
        print(currentLocation)
    }
}
