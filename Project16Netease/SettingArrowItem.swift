//
//  SettingArrowItem.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/15.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit


final class SettingArrowItem: SettingItem {

    var destVc : AnyClass?
    

    func item(_ title : String,destVC : AnyClass,icon: String){
        self.item(title, icon: icon)
        self.destVc = destVC

    }
    
    func item(_ title : String,destVC : AnyClass){
        self.item(title)
        self.destVc = destVC
    }
    
}
