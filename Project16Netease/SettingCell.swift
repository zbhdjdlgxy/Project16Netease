//
//  SettingCell.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/15.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

final class SettingCell: UITableViewCell {

    var item : SettingItem = SettingItem(){
        
        willSet{
    
            if newValue.icon != nil {
                self.imageView?.image = UIImage.init(named: newValue.icon!)
            }
            self.textLabel?.text = newValue.title
            if newValue is SettingArrowItem {
                self.accessoryType = .disclosureIndicator
            }else if newValue is SettingSwitchItem{
                let setting : UserDefaults = UserDefaults()
                let switchControl : UISwitch = UISwitch.init()
                switchControl.addTarget(self, action: #selector(self.changeSwitchState(_:)), for: .touchUpInside)
                switchControl.isOn = setting.bool(forKey: newValue.title!)
                self.accessoryView = switchControl
            }
        }
    }
    
//    MARK: 点击开关存储开关状态
    func changeSwitchState(_ switchControl : UISwitch) {
        
        let setting : UserDefaults = UserDefaults()
        setting.set(switchControl.isOn, forKey: self.item.title!)
        setting.synchronize()
    }
    
    class func cellWithTableView(_ tableView : UITableView) -> SettingCell {
        
        let identifier : String = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SettingCell
        if cell == nil {
            cell = SettingCell.init(style: .default, reuseIdentifier: identifier)
        }
        return cell!
    }
}
