//
//  SettingGroup.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/15.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

class SettingGroup: NSObject {

    var headers : Array<String>?
    var footers : Array<String>?
    var items : NSArray?
    
    class func group() -> SettingGroup{
        
        return SettingGroup()
        
    }
    
}
