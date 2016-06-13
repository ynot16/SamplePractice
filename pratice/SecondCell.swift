//
//  SecondCell.swift
//  pratice
//
//  Created by bori－applepc on 16/3/9.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class SecondCell: UITableViewCell {
    
    var contentLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(contentLabel)
        contentLabel.font = UIFont.systemFontOfSize(12.0)
        contentLabel.numberOfLines = 0
        contentLabel.preferredMaxLayoutWidth = Window.SCREENWIDTH - 90 - 20
        contentLabel.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.contentLabel)
        }
        
        self.hyb_lastViewInCell = contentLabel
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func config(secModel model: SecondModel) {
        let content: String = String(format: "%@回复%@：%@", arguments: [model.name,model.reply,model.comment])
        let attributedContent = NSMutableAttributedString(string: content)
        attributedContent.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange(0, (model.name as NSString).length))
        attributedContent.addAttribute(NSForegroundColorAttributeName, value: UIColor.orangeColor(), range: NSMakeRange((model.name as NSString).length + 2, (model.reply as NSString).length))
        contentLabel.attributedText = attributedContent
    }
}
