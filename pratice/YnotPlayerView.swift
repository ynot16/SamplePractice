//
//  YnotPlayerView.swift
//  pratice
//
//  Created by bori－applepc on 16/3/11.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class YnotPlayerView: UIView {
    
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    var playerlayer: AVPlayerLayer?
    
    var ynotMaskView: YnotPlayerMaskView?
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func layoutSubviews() {
        print("layoutSubviews")
        super.layoutSubviews()
    }
    
    var videoUrl: NSURL? {

        didSet {
            
            playerItem = AVPlayerItem(URL: videoUrl!)
            player = AVPlayer(playerItem: playerItem!)
            playerlayer = AVPlayerLayer(player: player!)
            
            if playerlayer?.videoGravity == AVLayerVideoGravityResizeAspect {
                playerlayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            }else {
                playerlayer?.videoGravity = AVLayerVideoGravityResizeAspect
            }
            
            self.layer.insertSublayer(playerlayer!, atIndex: 0)
            player!.play()
            
            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("moviePlayDidEnd:"), name: AVPlayerItemDidPlayToEndTimeNotification, object: player?.currentItem)
            
            ynotMaskView = YnotPlayerMaskView.setUpPlayerMaskView()
            ynotMaskView!.backgroundColor = UIColor.redColor()
            self.insertSubview(ynotMaskView!, belowSubview: self.backButton)
            
            ynotMaskView?.snp_makeConstraints(closure: { (make) -> Void in
                make.edges.equalTo(UIEdgeInsetsMake(0, 0, 0, 0))
            })
            
        }
    }
    
    override func awakeFromNib() {
        
    }
}
