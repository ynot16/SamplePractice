//
//  YnotCell.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import HYBSnapkitAutoCellHeight

class YnotCell: UITableViewCell {
    
    typealias ExpandBlock = ((type: Int, isExpand: Bool) -> Void)?
    
    private var headImageView = UIImageView()
    private var titleLabel = UILabel()
    private var desLabel = UILabel()
    private var blogSummaryLabel = UILabel()
    private var okButton = UIButton()
    private var isExpand1 = true
    private var isExpand2 = true
    
    var expandBlock: ExpandBlock?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.whiteColor()
        headImageView.image = UIImage(named: "head")
        self.contentView.addSubview(headImageView)
        headImageView.snp_makeConstraints { (make) -> Void in
            make.left.top.equalTo(15)
            make.width.height.equalTo(80)
        }
        
        
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFontOfSize(26)
        self.contentView.addSubview(titleLabel)
        titleLabel.snp_makeConstraints { (make) -> Void in
            make.left.equalTo(headImageView.snp_right).offset(15)
            make.right.equalTo(-15)
            make.top.equalTo(headImageView)
        }
        
        titleLabel.preferredMaxLayoutWidth = Window.SCREENWIDTH - 30 - 15 - 80
        
        self.contentView.addSubview(desLabel)
        desLabel.numberOfLines = 0
        desLabel.font = UIFont.systemFontOfSize(22)
        desLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
        }
        desLabel.preferredMaxLayoutWidth = titleLabel.preferredMaxLayoutWidth
        let tap = UITapGestureRecognizer(target: self, action: Selector("onTapDesc"))
        desLabel.userInteractionEnabled = true
        desLabel.addGestureRecognizer(tap)
        
        self.contentView.addSubview(blogSummaryLabel)
        blogSummaryLabel.numberOfLines = 0
        blogSummaryLabel.font = UIFont.systemFontOfSize(20)
        blogSummaryLabel.snp_makeConstraints { (make) -> Void in
            make.left.right.equalTo(desLabel)
            make.top.equalTo(desLabel.snp_bottom).offset(15)
        }
        blogSummaryLabel.preferredMaxLayoutWidth = titleLabel.preferredMaxLayoutWidth
        
        let tap1 = UITapGestureRecognizer(target: self, action: Selector("onTapBlog"))
        blogSummaryLabel.userInteractionEnabled = true
        blogSummaryLabel.addGestureRecognizer(tap1)
        
        self.contentView.addSubview(okButton)
        okButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        okButton.backgroundColor = UIColor.greenColor()
        okButton.setTitle("计算高度的参考", forState: .Normal)
        okButton.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(-15)
            make.height.equalTo(45)
            make.top.equalTo(blogSummaryLabel.snp_bottom).offset(15)
        }
        
        blogSummaryLabel.backgroundColor = UIColor.redColor()
        desLabel.backgroundColor = UIColor.blueColor()
        
        
        let lineLabel = UILabel()
        lineLabel.backgroundColor = UIColor.lightGrayColor()
        self.contentView.addSubview(lineLabel)
        lineLabel.snp_makeConstraints { (make) -> Void in
            make.height.equalTo(1)
            make.left.equalTo(15)
            make.right.equalTo(0)
            make.bottom.equalTo(self.contentView)
        }
        
        self.hyb_lastViewInCell = okButton
        self.hyb_bottomOffsetToCell = 15
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func config(ynotModel model: YnotModel) {
        titleLabel.text = model.name
        desLabel.text = model.desc
        blogSummaryLabel.text = model.blog
        
        if model.isExpand1 != self.isExpand1 {
            self.isExpand1 = model.isExpand1
            
            if self.isExpand1 {
                desLabel.snp_remakeConstraints(closure: { (make) -> Void in
                    make.left.right.equalTo(titleLabel)
                    make.top.equalTo(titleLabel.snp_bottom).offset(15)
                })
            } else {
                desLabel.snp_updateConstraints(closure: { (make) -> Void in
                    make.height.lessThanOrEqualTo(55)
                })
            }
        }
        
        
        if model.isExpand2 != self.isExpand2 {
            self.isExpand2 = model.isExpand2
            
            if self.isExpand2 {
                blogSummaryLabel.snp_remakeConstraints(closure: { (make) -> Void in
                    make.left.right.equalTo(desLabel)
                    make.top.equalTo(desLabel.snp_bottom).offset(15)
                })
            } else {
                blogSummaryLabel.snp_updateConstraints(closure: { (make) -> Void in
                    make.height.lessThanOrEqualTo(55)
                })
            }
        }
    }
    
    func onTapDesc() {
        if let block = self.expandBlock {
            block!(type: 1, isExpand: !self.isExpand1)
        }
    }
    
    func onTapBlog() {
        if let block = self.expandBlock {
            block!(type: 2, isExpand: !self.isExpand2)
        }
    }

    
    
}
