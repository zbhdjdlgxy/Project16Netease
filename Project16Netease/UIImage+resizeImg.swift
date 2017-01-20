//
//  UIImage+ZB.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/9.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func resizedImageWithName(_ name : String) -> UIImage{
    
        let image : UIImage = UIImage.init(named: name)!
        return image.resizableImage(withCapInsets: UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5))
        
    }

}
