//
//  HomeTVC.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/8.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit
class HomeTVC: UITableViewController {
    
    var dataCount : Int = 5
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.tableHeaderView = UIView.init(frame: CGRect.zero);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.tableView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                
                self.dataCount += 5
                self.tableView.reloadData()
                self.tableView.mj_header.endRefreshing()
            })
        })
        
        self.tableView.mj_footer = MJRefreshBackNormalFooter.init(refreshingBlock: {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double((Int64)(2 * NSEC_PER_SEC)) / Double(NSEC_PER_SEC), execute: {
                
                self.dataCount += 5
                self.tableView.reloadData()
                self.tableView.mj_footer.endRefreshing()
            })
        })
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataCount
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifer : String = "home"
        var cell = tableView.dequeueReusableCell(withIdentifier: indentifer)
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: indentifer)
        }
        cell!.textLabel?.text = "abcd"
        // Configure the cell...
        
        return cell!
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let addTVC : AddFriendsTVC = AddFriendsTVC()
        addTVC.title = "添加朋友"
        self.navigationController?.pushViewController(addTVC, animated: true)
        
    }

   

}
