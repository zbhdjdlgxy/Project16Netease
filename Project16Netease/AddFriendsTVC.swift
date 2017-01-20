//
//  AddFriendsTVC.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/10.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

class AddFriendsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "add")
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "add")
        }
        cell!.textLabel?.text = "defg"
        // Configure the cell...
        
        return cell!
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let msgVC : FriendsMsgTVC = FriendsMsgTVC()
        msgVC.title = "朋友信息"
        self.navigationController?.pushViewController(msgVC, animated: true)
        
    }

}
