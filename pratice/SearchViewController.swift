//
//  SearchViewController.swift
//  pratice
//
//  Created by bori－applepc on 16/3/30.
//  Copyright © 2016年 bori－applepc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchDisplayDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    
    var view1: UIView?
    var view2: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        #if BETA
            view.backgroundColor = UIColor.redColor()
        #endif
        
        let button = UIButton(frame: CGRectMake(100,120,100,100))
        button.backgroundColor = UIColor.greenColor()
        view.addSubview(button)
        button.addTarget(self, action: "changeConstraint", forControlEvents: .TouchUpInside)
        
        view1 = UIView()
        view1!.backgroundColor = UIColor.redColor()
        view1!.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1!)
        let leftCon = NSLayoutConstraint(item: view1!, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 1)
        let topCon = NSLayoutConstraint(item: view1!, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 120)
        let widthCon = NSLayoutConstraint(item: view1!, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .Width, multiplier: 1, constant: 100)
        let heightCon = NSLayoutConstraint(item: view1!, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .Height, multiplier: 1, constant: 100)
        leftCon.active = true
        topCon.active = true
        widthCon.active = true
        heightCon.active = true
        

        
        self.searchDisplayController?.delegate = self
        self.searchDisplayController?.searchResultsDataSource = self
        self.searchDisplayController?.searchResultsDelegate = self
        self.searchDisplayController?.displaysSearchBarInNavigationBar = false
        
        // Do any additional setup after loading the view.
    }
    
    func changeConstraint() {
        let constraint = view1?.constraints
        for constraint in view1!.constraints {
            if constraint.firstAttribute == .Height {
                constraint.constant = 1000
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
