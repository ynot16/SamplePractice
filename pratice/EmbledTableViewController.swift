//
//  EmbledTableViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class EmbledTableViewController: UIViewController {
    var tableView: UITableView?
    var tableArray = [FirstModel]()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        addDataSource()
        
        let tableView = UITableView(frame: CGRectMake(0, 0, Window.SCREENWIDTH, Window.SCREENHIEGHT), style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(FirstCell.self, forCellReuseIdentifier: "First Cell")
        view.addSubview(tableView)
    }
    
    func addDataSource() {
        for var i = 0; i < 100; i++ {
            let firModel = FirstModel()
            firModel.name = "标哥的技术博客"
            firModel.uid = "\(i + 1)"
            firModel.headImage = "head"
            firModel.desc = "由标哥的技术博客出品，学习如何在cell中嵌套使用tableview并自动计算行高。同时演示如何通过HYBMasonryAutoCellHeight自动计算行高，关注博客：http://www.henishuo.com"
            let randCount: Int = Int(arc4random() % 10 + UInt32(1))
            for var j = 0; j < randCount; j++ {
                let secModel = SecondModel()
                secModel.cid = "\(j + 1)"
                secModel.name = "标哥"
                secModel.reply = "标哥的技术博客"
                secModel.comment = "可以试试HYBMasonryAutoCellHeight这个扩展，自动计算行高的"
                firModel.secondModelArray.append(secModel)
            }
            tableArray.append(firModel)
        }
        tableView?.reloadData()
    }
    
    
}



extension EmbledTableViewController: UITableViewDelegate,UITableViewDataSource,HYBTestCellDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let firModel = tableArray[indexPath.row]
        return FirstCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in
            let firCell = cell as? FirstCell
            firCell?.config(firModel: firModel, indexPath: indexPath)
            }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                let cache = (String(firModel.uid), "", firModel.shouldUpdateCache)
                firModel.shouldUpdateCache = false
                return cache
        })
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("First Cell") as? FirstCell {
            cell.delegate = self
            let model = tableArray[indexPath.row]
            cell.config(firModel: model, indexPath: indexPath)
            return cell
        }else {
            return FirstCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
    }
    
    func reloadCellHeightForModel(model: FirstModel, indexPath: NSIndexPath) {
        for vi in self.view.subviews {
            if vi is UITableView {
                let table = vi as? UITableView
                table?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
        }
        self.tableView?.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
}
