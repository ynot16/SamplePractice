//
//  AnimationViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/7/28.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    var testButton: UIButton!
    var myView1: UIView!
    var myView2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var button = UIButton(frame: CGRectMake(0, 0, 100, 100))
        button.backgroundColor = UIColor.greenColor()
        let animation = CABasicAnimation(keyPath: "bounds")
        animation.fromValue = NSValue(CGRect: CGRect(x: 0, y: 300, width: 20, height: 20))
        animation.byValue = NSValue(CGRect: CGRect(x: 0, y: 300, width: 100, height: 100))
        animation.duration = 3
        animation.repeatCount = 100
        button.layer.addAnimation(animation, forKey: "position.x")
        view.addSubview(button)
        
        testButton = UIButton(frame: CGRectMake(100, 100, 100, 100))
        testButton.backgroundColor = UIColor.redColor()
//        button.layer.opacity = 1.0
        testButton.addTarget(self, action: #selector(AnimationViewController.changeLayerProperty(_:)), forControlEvents: .TouchUpInside)
        view.addSubview(testButton)
        let point = button.layer.convertPoint(CGPointMake(300, 300), toLayer: testButton.layer)
        print("point == \(point)")
        
        let doorLayer = CALayer()
        doorLayer.backgroundColor = UIColor.blueColor().CGColor
        doorLayer.bounds = CGRectMake(0, 0, 110, 100)
        doorLayer.position = CGPointMake(100, 300)
        doorLayer.anchorPoint = CGPointMake(0, 0.5)
        doorLayer.opaque = true
        view.layer.addSublayer(doorLayer)
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1 / 1000
        view.layer.sublayerTransform = perspective
        
        let filpAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        filpAnimation.fromValue = -M_PI_2
        filpAnimation.duration = 2
        filpAnimation.repeatCount = 100
        filpAnimation.autoreverses = true
        doorLayer.addAnimation(filpAnimation, forKey: "rotation")
        
        myView1 = UIView(frame: CGRectMake(100, 400, 100, 100))
        myView1.backgroundColor = UIColor.redColor()
        let tap = UITapGestureRecognizer(target: self, action: #selector(AnimationViewController.transitionTap(_:)))
        myView1.addGestureRecognizer(tap)
        view.addSubview(myView1)
        myView2 = UIView(frame: CGRectMake(100, 400, 100, 100))
        myView2.backgroundColor = UIColor.greenColor()
        myView2.hidden = true
        view.addSubview(myView2)
               
        
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func transitionTap(tap: UITapGestureRecognizer) {
        let transition = CATransition()
        transition.startProgress = 0.0
        transition.endProgress = 1.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        transition.duration = 1.0
        myView1.layer.addAnimation(transition, forKey: "transition")
        myView2.layer.addAnimation(transition, forKey: "transition")
        
        myView1.hidden = true
        myView2.hidden = false
    }
    
    func testClickAtRuning(sender: UIButton) {
        print("ashdkasjhldjahsdjhljshadlh")
    }
    
    @IBAction func outletChange(sender: UIButton) {
        if sender.selected {
            resumeAnimation(testButton.layer)
        }else {
            pauseAnimation(testButton.layer)
        }
        sender.selected = !sender.selected
    }
    
    func pauseAnimation(layer: CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
        layer.speed = 0
        layer.timeOffset = pausedTime
        print(pausedTime)
    }
    
    func resumeAnimation(layer: CALayer) {
        let pausedTime = layer.timeOffset
//        print(pausedTime)
        layer.speed = 1
        layer.beginTime = 0
        layer.timeOffset = 0
        let timeSincePaused = layer.convertTime(CACurrentMediaTime(), fromLayer: nil) - pausedTime
//        print(timeSincePaused)
        layer.beginTime = timeSincePaused
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
        print("ahsdjklashdlashjdhsldakj")
    }
    
    func changeLayerProperty(sender: UIButton) {
        
        UIApplication.sharedApplication().openURL(NSURL(string: "http://www.jianshu.com/p/67ab63723e54")!)
        
        /*
        sender.layer.setValue(10.0, forKeyPath: "transform.scale.x")
        return
        */
        
        /*
        let opAnimation = CABasicAnimation(keyPath: "opacity")
        opAnimation.fromValue = 1.0
        opAnimation.toValue = 0.0
        opAnimation.duration = 1.0
        sender.layer.addAnimation(opAnimation, forKey: "opacity")
        sender.layer.opacity = 0.0
        */
        
        /*
        let path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, 74, 74)
        CGPathAddCurveToPoint(path, nil, 74.0, 500.0, 320.0, 500.0, 320, 74.0)
        CGPathAddCurveToPoint(path, nil, 320.0, 500.0, 566.0, 500.0, 566.0, 74.0)
        let animaton = CAKeyframeAnimation(keyPath: "position.x")
        let value1 = NSValue(CGPoint: CGPointMake(100, 200))
        let value2 = NSValue(CGPoint: CGPointMake(200, 200))
        let value3 = NSValue(CGPoint: CGPointMake(200, 100))
        let value4 = NSValue(CGPoint: CGPointMake(100, 100))
        animaton.values = [value1, value2, value3, value4]
        animaton.calculationMode = kCAAnimationDiscrete
        animaton.keyTimes = [0.0, 0.2, 0.8, 1.0]
        
//        animaton.path = path
        animaton.duration = 5.0
        sender.layer.addAnimation(animaton, forKey: "position")
        */
        
        /*
        let widthAnim = CAKeyframeAnimation(keyPath: "borderWidth")
        let widthValues = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50,0, 0.0]
        widthAnim.values = widthValues
        widthAnim.calculationMode = kCAAnimationPaced
        let colorAnim = CAKeyframeAnimation(keyPath: "borderColor")
        let colorValues = [UIColor.greenColor().CGColor, UIColor.redColor().CGColor, UIColor.blueColor().CGColor]
        colorAnim.values = colorValues
        colorAnim.calculationMode = kCAAnimationPaced
        let animaton = CAKeyframeAnimation(keyPath: "position")
//        animaton.beginTime = 3
        let value1 = NSValue(CGPoint: CGPointMake(100, 200))
        let value2 = NSValue(CGPoint: CGPointMake(200, 200))
        let value3 = NSValue(CGPoint: CGPointMake(200, 100))
        let value4 = NSValue(CGPoint: CGPointMake(100, 100))
        animaton.values = [value1, value2, value3, value4]
        
        let group = CAAnimationGroup()
        group.animations = [colorAnim, widthAnim, animaton]
        group.duration = 5.0
        // repeadCount 整个动画重复的次数，包含autoreverses
//        group.repeatCount = 2.0
        // autoreverses 相当于repeatDuration ＊ 2
//        group.autoreverses = true
//        group.repeatDuration = 15.0
        let currentTime = CACurrentMediaTime()
        let timeInSuperLayer = sender.layer.convertTime(currentTime, fromLayer: nil)
        group.beginTime = timeInSuperLayer
        group.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        group.timeOffset = 0.5
        sender.layer.addAnimation(group, forKey: "borderChanges")
        */
        

        
        /*
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation")
        let scaleTransform1 = CATransform3DScale(CATransform3DIdentity, 0.2, 0.2, 0.2)
        let scaleTransform2 = CATransform3DScale(CATransform3DIdentity, 0.6, 0.6, 0.6)
        let scaleTransform3 = CATransform3DScale(CATransform3DIdentity, 0.4, 0.4, 0.4)
        let scaleTransform4 = CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0)
        
        let rotationTransform1 = CATransform3DRotate(CATransform3DIdentity, 90, 1, 1, 1)
        let rotationTransform2 = CATransform3DRotate(CATransform3DIdentity, -180, 1, 1, 1)
        let rotationTransform3 = CATransform3DRotate(CATransform3DIdentity, 90, 1, 1, 1)
        let rotationTransform4 = CATransform3DRotate(CATransform3DIdentity, -180, 1, 1, 1)

        
        let value1 = NSValue(CATransform3D: rotationTransform1)
        let value2 = NSValue(CATransform3D: rotationTransform2)
        let value3 = NSValue(CATransform3D: rotationTransform3)
        let value4 = NSValue(CATransform3D: rotationTransform4)
        animation.values = [value1, value2, value3, value4]
        animation.duration = 0.2
        animation.repeatCount = 100
        sender.layer.addAnimation(animation, forKey: "transform.rotation")
        let alertVC = UIAlertController(title: "ynot16", message: "hello", preferredStyle: .Alert)
        alertVC.addAction(UIAlertAction(title: "ok", style: .Cancel, handler: nil))
        presentViewController(alertVC, animated: true) {
            alertVC.view.layer.addAnimation(animation, forKey: "transform.ratation")
        }
        */
        
        /*
        let emitter = CAEmitterLayer()
        emitter.bounds = sender.bounds
        sender.layer.addSublayer(emitter)
        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerLine
        emitter.emitterMode = kCAEmitterLayerOutline
        emitter.seed = 100
        emitter.emitterPosition = CGPointMake(emitter.frame.width / 2.0, emitter.frame.height / 2.0)
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "star")?.CGImage
        cell.birthRate = 1
        cell.lifetime = 10.0
        cell.color = UIColor.orangeColor().CGColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat(M_PI / 2.0)
        emitter.emitterCells = [cell]
        */

        
        
        
        
        
        
        
        
        
        
        
    }
    
}
