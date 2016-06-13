//
//  RealmViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/14.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import RealmSwift

class RealmViewController: UIViewController {

    var click: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        
        click = 0
//        let presentButton = UIButton()
//        presentButton.setTitle("go", forState: .Normal)
//        presentButton.backgroundColor = UIColor.blueColor()
//        view.addSubview(presentButton)
//        presentButton.snp_makeConstraints { (make) -> Void in
//            make.center.equalTo(view)
//            make.width.height.equalTo(60)
//        }
        
        
        let realm = try! Realm()
        
        let items = realm.objects(ConsumeItem)
        guard items.count <= 0 else {
            print("there was already something there")
            return
        }

        let typeEntertainment = ConsumeType()
        typeEntertainment.name = "娱乐"
        let typeShopping = ConsumeType()
        typeShopping.name = "购物"
        
        let item1 = ConsumeItem(value: ["买一台电脑",5999.00,NSDate(),typeShopping])
        let item2 = ConsumeItem(value: ["看电影",100.00,NSDate(timeIntervalSinceNow: -60 * 60 * 24 * 7),typeEntertainment])
        let item3 = ConsumeItem(value: ["买了些零食",50.00,NSDate(timeIntervalSinceNow: -60 * 60 * 24 * 3),typeShopping])
        let item4 = ConsumeItem(value: ["打机",99,NSDate(),typeShopping])
        
        do {
            try realm.write {
                realm.add(item1)
                realm.add(item2)
                realm.add(item3)
                realm.add(item4)
            }
        }catch {
            print(error)
        }
        
        
        let url = NSURL(string: "http://www.douban.com/j/app/radio/channels")!
        let response = NSData(contentsOfURL: url)!
        let json = try! NSJSONSerialization.JSONObjectWithData(response, options: .AllowFragments)
        let channels = (json as! NSDictionary)["channels"] as! [NSDictionary]
        
        do {
            try realm.write({ () -> Void in
                for channel in channels {
                    if channel["seq_id"] as! Int == 0 {continue}
                    realm.create(Channel.self, value: channel, update: true)
                }
            })
        }catch {
            print(error)
        }
        
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonClick(sender: AnyObject) {
        let realm = try! Realm()
        let deleteObject = realm.objects(ConsumeItem).filter("name = '买一台电脑'")
        do {
            try realm.write({ () -> Void in
                realm.delete(deleteObject)
            })
        }catch {
            print(error)
        }
        
        
    }

    @IBOutlet weak var buttonTag: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
