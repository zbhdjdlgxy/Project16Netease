//
//  ZBHttpTool.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/26.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import Foundation
import Alamofire

struct ZBFormData {
    /**
     *  参数名
     */
    var name : String?
    /**
     *  文件名
     */
    var filename : String?
    /**
     *  文件类型
     */
    var mimeType : String?
    /**
     *  文件数据
     */
    var data : Data?
}


final class ZBHttpTool: NSObject {
    
    class func getWithUrl(_ url : String,params : Dictionary<String,AnyObject>,success : @escaping (_ id : AnyObject) -> Void,failure : @escaping (_ id : AnyObject) -> Void){
        
        Alamofire.request(url, parameters: params).responseData { response in
            if((response.error) != nil){
                failure(response.error as AnyObject);
            }else{
                let dic : Dictionary<String,AnyObject> = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! Dictionary
                success(dic as AnyObject)
            }
        };
    }
    
    
    class func postWithUrl(_ url : String,params : Dictionary<String,AnyObject>,success : @escaping (_ id : AnyObject) -> Void,failure : @escaping (_ id : AnyObject) -> Void){
        
        Alamofire.request(url, method: .post,parameters: params).responseData { response in
            if((response.error) != nil){
                failure(response.error as AnyObject);
            }else{
                let dic : Dictionary<String,AnyObject> = try! JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! Dictionary
                success(dic as AnyObject)
            }
        };
        
    }
    
    class func postWithUrl(_ url : String,params : Dictionary<String,AnyObject>,formDataArray : Array<ZBFormData>,success : (_ id : AnyObject) -> Void,failure : (_ id : AnyObject) -> Void){
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for formData in formDataArray{
                    multipartFormData.append(formData.data!, withName: formData.name!, fileName: formData.filename!, mimeType: formData.mimeType!)
                    
                }
        },
            to: "https://httpbin.org/post",
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                    }
                case .failure(let encodingError):
                    print(encodingError)
                }
        }
        )
        
    }
}
