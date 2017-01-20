//
//  ShopCarTool.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/29.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import Foundation
final class ShopCarTool: NSObject {

    static let KShoppingCarList : String = "GetShopCarList"
    
    /**
     *  获取购物车信息
     *
     *  @param param   请求参数
     *  @param success 请求成功后的回调
     *  @param failure 请求失败后的回调
     */
    class func shopCarListWithParam(_ param : ShopCarListParam,success : @escaping (_ result : ShopCarListResult) -> Void,failure : @escaping (_ error : NSError) -> Void){
        MBProgressHUD.showMessage("加载中...")
        let dict = param.toDict()
        
        ZBHttpTool.getWithUrl(SERVER_HOST+KShoppingCarList, params: dict, success: { (id) in
            MBProgressHUD.hide()
            success(ShopCarListResult.parse(dict: id as! NSDictionary))
            }) { (id) in
                MBProgressHUD.hide()
                failure(id as! NSError)
        }
    }
}
