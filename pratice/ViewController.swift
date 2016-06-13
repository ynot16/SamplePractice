//
//  ViewController.swift
//  pratice
//
//  Created by bori－applepc on 15/10/12.
//  Copyright © 2015年 bori－applepc. All rights reserved.
//

import UIKit


class People {
    private(set) var name: String = " "
    var pet: Dog? = nil
    
    
    
    deinit{
        
        print("People deinit")
    }
}

class Dog {
    weak var people: People? = nil
    deinit{
        print("Dog deinit")
    }
}


struct MutatingCounter {
    private(set) var count: Int
    
    init(count: Int = 0) {
        self.count = count
    }
    
    mutating func increment() {
        count += 1
    }
}

class MyClass: NSObject {
    dynamic var date = NSDate()
    var name = ""
    deinit {
      print("deinit")
    }
}

private var myContext = 0

class Classs: NSObject {
    var myObject: MyClass!
    var name = ""
    override init() {
        super.init()
        myObject = MyClass()
        myObject.name = "ynotcc"
        self.name = myObject.name   
        print("初始化 MyClass，当前日期： \(myObject.date)")
        myObject.addObserver(self,forKeyPath: "date", options: .New, context: &myContext)
        
        let time = 2.0
        let delay = dispatch_time(DISPATCH_TIME_NOW, Int64(time * Double(NSEC_PER_SEC)))
        dispatch_after(delay, dispatch_get_main_queue()) {
            self.myObject.date = NSDate()
        }
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let change = change where context == &myContext {
            let a = change[NSKeyValueChangeNewKey]
            print("日期发生变化 \(a)")
        }
    }
}


protocol TestDelegate: class {
    func showMessage(name : String)
}

class ViewController: UIViewController, TestDelegate {
    
    var guardFlag: Bool?
    var name: String?
    weak var delegate: TestDelegate?
    
    
    func showMessage(name: String) {
        print(name)
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        self.delegate = self
        self.delegate?.showMessage("hey ynotcc")
//        let obc = Classs()
        
        name = "ynot"
        
        let guangzhou = "广州"
        if #available(iOS 9.0, *) {
            let gz = guangzhou.stringByApplyingTransform(NSStringTransformToLatin, reverse: false)
            print("\(gz)")

        } else {
            // Fallback on earlier versions
        }
        
        
        let button = UIButton()
        button.backgroundColor = UIColor.blueColor()
        button.addTarget(self, action: Selector("showInfo:event:"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(button)
        
        button.snp_makeConstraints { (make) -> Void in
            make.width.height.equalTo(50)
            make.center.equalTo(view)
        }
        
        
//        guardFlag = false
//        let me = People()
//        me.name = "john"
//        
//        let pet = Dog()
//        pet.people = me
//        
//        me.pet = pet
//        
//        guard (guardFlag == nil) else{
//            print("hello")
//            return
//        }
//        
//        print("hey")
        
//        var counter = MutatingCounter(count: 2)
//        counter.count = 3
//        self.showTheHighLightMessage()
    }
    
    
    
    func showInfo(sender: UIButton, event: UIEvent) {
        print(sender, event)
    }
    
    @IBAction func changeTheName(sender: AnyObject) {
        self.name = "ynotcc"
    }
    
    func showTheHighLightMessage() {
        let text = "@ynotcc Do you like the egg? www.apple.com"
        let attributedString = NSMutableAttributedString(string: text)
        let textRange = NSMakeRange(0, (text as NSString).length)
        let mentionPattern = "@[A-Za-z0-9_]+"
        let mentionExpresstion = try! NSRegularExpression(pattern: mentionPattern, options: NSRegularExpressionOptions())
        
        mentionExpresstion.enumerateMatchesInString(text, options: NSMatchingOptions(), range: textRange) { (result, flags, stop) -> Void in
            if let result = result {
                let subString = (text as NSString).substringWithRange(result.range)
                
                let attributes: [String: AnyObject] = [
                    NSLinkAttributeName: subString,
                    "CustomDetectionType": "Mention"
                ]
                
                attributedString.addAttributes(attributes, range: result.range)
                self.textView.attributedText = attributedString
            }
        }
        
    }
    

}
