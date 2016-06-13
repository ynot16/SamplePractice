//
//  FirstCell.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

protocol HYBTestCellDelegate: class {
    func reloadCellHeightForModel(model: FirstModel, indexPath: NSIndexPath)
}

class FirstCell: UITableViewCell {
    let titleLabel = UILabel()
    let descLabel = UILabel()
    let headImageView = UIImageView()
    let tableView = UITableView()
    var firModel = FirstModel()
    var indexPath = NSIndexPath()
    weak var delegate: HYBTestCellDelegate?
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .None
        
        self.contentView.addSubview(headImageView)
        headImageView.contentMode = .ScaleAspectFit
        headImageView.snp_makeConstraints { (make) -> Void in
            make.top.left.equalTo(15)
            make.width.height.equalTo(80)
        }
        
        self.contentView.addSubview(titleLabel)
        titleLabel.font = UIFont.systemFontOfSize(16)
        titleLabel.numberOfLines = 0
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headImageView.snp_right).offset(10)
            make.top.equalTo(headImageView)
            make.right.equalTo(-10)
        }
        titleLabel.preferredMaxLayoutWidth = Window.SCREENWIDTH - 90 - 20
        
        
        self.contentView.addSubview(descLabel)
        descLabel.numberOfLines = 0
        descLabel.font = UIFont.systemFontOfSize(13)
        descLabel.snp_makeConstraints { (make) -> Void in
            make.right.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
        }
        descLabel.preferredMaxLayoutWidth = titleLabel.preferredMaxLayoutWidth
        
        
        tableView.scrollEnabled = false
        tableView.separatorStyle = .None
        self.contentView.addSubview(tableView)
        tableView.registerClass(SecondCell.self, forCellReuseIdentifier: "Second Cell")
        tableView.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(descLabel)
            make.top.equalTo(descLabel.snp_bottom).offset(15)
            make.right.equalTo(-10)
            make.height.equalTo(100)
        }
        self.hyb_lastViewInCell = tableView
        self.hyb_bottomOffsetToCell = 10
    }
    
}

extension FirstCell {
    
    func config(firModel model: FirstModel, indexPath: NSIndexPath) {
        self.indexPath = indexPath
        headImageView.image = UIImage(named: model.headImage)
        titleLabel.text = model.name
        descLabel.text = model.desc
        
        firModel = model
        var tableViewRowHeight: CGFloat = 0
        for secModel in model.secondModelArray {
            let height = SecondCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in
                let secCell = cell as? SecondCell
                secCell?.config(secModel: secModel)
                }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                    return (String(secModel.cid), "", false)
            })
            tableViewRowHeight += height
        }
        
        tableView.snp_updateConstraints { (make) -> Void in
            make.height.equalTo(tableViewRowHeight)
        }
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        
    }
}

extension FirstCell: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("Second Cell") as? SecondCell {
            let model = firModel.secondModelArray[indexPath.row]
            cell.config(secModel: model)
            return cell
        }else {
            return SecondCell()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firModel.secondModelArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let secModel = firModel.secondModelArray[indexPath.row]
        return SecondCell.hyb_cellHeight(forTableView: tableView, config: { (cell) -> Void in
            let secCell = cell as? SecondCell
            secCell?.config(secModel: secModel)
            }, updateCacheIfNeeded: { () -> (key: String, stateKey: String, shouldUpdate: Bool) in
                return (String(secModel.cid), "", false)
        })
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let insertModel = SecondModel()
        insertModel.name = "ynotcc"
        insertModel.reply = "egg"
        insertModel.comment = "i love you"
        insertModel.cid = "\(firModel.secondModelArray.count + 1)"
        firModel.secondModelArray.append(insertModel)
        firModel.shouldUpdateCache = true
        self.delegate?.reloadCellHeightForModel(firModel, indexPath: self.indexPath)
    }
}




