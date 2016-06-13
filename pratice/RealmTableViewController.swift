//
//  RealmTableViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/14.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import RealmSwift


class RealmCell: UITableViewCell {
    
    @IBOutlet weak var titleLabe: UILabel!
    
    @IBOutlet weak var labelLeftConstraint: NSLayoutConstraint!
    
    @IBAction func firstButton(sender: AnyObject) {
        self.labelLeftConstraint.constant = 100
    }
    
    @IBAction func secondButton(sender: AnyObject) {
        self.labelLeftConstraint.constant = 150
        UIView.animateWithDuration(0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveLinear, animations: { () -> Void in
            self.layoutIfNeeded()
            self.setNeedsLayout()
            }, completion: nil)
    }
}

class RealmTableViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    var dateF = NSDateFormatter()
    var itemArray: Results<ConsumeItem>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blueColor()
        

        
        let realm = try! Realm()
        itemArray = realm.objects(ConsumeItem)
        let item = itemArray![0]
        try! realm.write { () -> Void in
            item.name = "ynotccc"
        }
        print(item.type?.owners)
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Item Cell") as? RealmCell {
            let item = itemArray![indexPath.row]
            cell.titleLabe!.text = item.name + "¥" + String(format: "%.1f", arguments: [item.cost])
//            cell.detailTextLabel?.text = dateF.stringFromDate(item.date)
            return cell
            
        }else {
            return RealmCell()
        }
    }
    
    
    @IBAction override func unwindForSegue(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        print("dismiss")
    }
    
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
