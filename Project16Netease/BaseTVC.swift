//
//  BaseTVC.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/15.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

class BaseTVC: UITableViewController {

    var data : Array<SettingGroup> = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let group : SettingGroup = data[section]
        return (group.items?.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = SettingCell.cellWithTableView(tableView) 
        
        let group : SettingGroup = self.data[indexPath.section]
        cell.item = (group.items![indexPath.row] as? SettingItem)!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let group : SettingGroup = self.data[indexPath.section]
        let item = group.items![indexPath.row]
        if item is SettingArrowItem {
            let arrowItem = item as! SettingArrowItem
            if (arrowItem.destVc != nil) {
                if (item as AnyObject).destVc is UITableViewController.Type{
                    let type : UITableViewController.Type = (item as AnyObject).destVc as! UITableViewController.Type
                    let ctl : UITableViewController = type.init(style: .grouped)
                    ctl.title = (item as AnyObject).title
                    self.navigationController?.pushViewController(ctl, animated: true)
                }
            }
            arrowItem.option?()
            
        }
        
    }
}
