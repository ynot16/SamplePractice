//
//  TableViewEmbledViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import SnapKit

class TableViewEmbledViewController: UIViewController {
    var tableView: UITableView?
    var tableArray = [YnotModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDataSource()
        
        let tableView = UITableView(frame: CGRectMake(0, 40, Window.SCREENWIDTH, Window.SCREENHIEGHT - 40), style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerClass(YnotCell.self, forCellReuseIdentifier: "Cell Identifier")
        view.addSubview(tableView)
        // Do any additional setup after loading the view.
    }

    func addDataSource() {
        
        for var i = 0; i < 20; i++ {
            let ynotModel = YnotModel()
            ynotModel.modelID = i + 1
            ynotModel.name = "基于SnapKit写的自动计算行高的扩展，欢迎大家使用"
            ynotModel.desc = "基于SnapKit写的自动计算行高的扩展，欢迎大家使用。不仅可以根据约束自动调整高度的高度，还可以解决重用问题。使用自动布局是可以自动适配了，但是如果没有很好地解决重用问题，那么每次因为没有更新约束，可能会因为重用而导致错乱。这个demo不只是测试这个扩展类，更给大家带来一种解决重用问题的方案"
            ynotModel.blog = "作者博客名称：标哥的技术博客，网址：http://www.henishuo.com，欢迎大家关注。这里有很多的专题，包括动画、自动布局、swift、runtime、socket、开源库、面试等文章，都是精品哦。大家可以关注微信公众号：iOSDevShares，加入有问必答QQ群：324400294，群快满了，若加不上，对不起，您来晚了！"
            
            
            if i % 2 == 0 {
                ynotModel.isExpand1 = true
            } else {
                ynotModel.isExpand1 = false
            }
            
            if i % 3 == 0 {
                ynotModel.isExpand2 = true
            } else {
                ynotModel.isExpand2 = false
            }
            
            tableArray.append(ynotModel)
        }
        tableView?.reloadData()
        
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

extension TableViewEmbledViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("Cell Identifier") as? YnotCell {
            let ynotModel = tableArray[indexPath.row]
            cell.config(ynotModel: ynotModel)
            
            cell.expandBlock = { (type: Int, isExpand: Bool) -> Void in
                switch type {
                case 1:
                    ynotModel.isExpand1 = isExpand
                default:
                    ynotModel.isExpand2 = isExpand
                }
               
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)

            }
            if indexPath.row >= self.tableArray.count - 1 {
                self.addDataSource()
            }
            return cell
        }else {
            return YnotCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let ynotModel = self.tableArray[indexPath.row]
        
        var stateKey = ""
        
        if ynotModel.isExpand1 && ynotModel.isExpand2 {
            stateKey = "expand1&expand2"
        } else if !ynotModel.isExpand1 && !ynotModel.isExpand2 {
            stateKey = "unexpand1&unexpand2"
        } else if ynotModel.isExpand1 {
            stateKey = "expand1&unexpand2"
        } else {
            stateKey = "unexpand1&expand2"
        }
        return YnotCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in
            let itemCell = cell as? YnotCell
            itemCell?.config(ynotModel: ynotModel)
            }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                return (String(ynotModel.modelID), stateKey, false)
        })
    }
    
    
    
}


