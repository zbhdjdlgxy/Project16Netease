//
//  SettingItem.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/15.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

typealias operationOption = (() -> Void)
class SettingItem: NSObject {
    

    var title : String?
    var icon : String?
    var option : operationOption?
    
    func item(_ title : String,icon : String){
        
        self.title = title;
        self.icon = icon
        
    }
    
    func item(_ title : String){
        
        self.title = title

        
    }
}
