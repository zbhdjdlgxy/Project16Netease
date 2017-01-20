//
//  BadgeButton.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/9.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

final class BadgeButton: UIButton {

    var badgeValue : String = ""{
        
        willSet{
            if newValue == "" {
                self.isHidden = true
            }else{
                self.isHidden = false
                self.setTitle(newValue, for: UIControlState())
                var frame : CGRect = self.frame;
                let badgeH : CGFloat = self.currentBackgroundImage!.size.height;
                var badgeW : CGFloat = self.currentBackgroundImage!.size.width;
                if (newValue.characters.count > 1) {
                    // 文字的尺寸
                    let badgeSize : CGSize = newValue.boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 1), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : (self.titleLabel?.font)!], context: nil).size
                    badgeW = badgeSize.width + 10;
                }
                frame.size.width = badgeW;
                frame.size.height = badgeH;
                self.frame = frame;
            }
        }
    }
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        self.isHidden = true;
        self.isUserInteractionEnabled = false;
        self.setBackgroundImage(UIImage.resizedImageWithName("main_badge"), for: UIControlState())
        self.titleLabel!.font = UIFont.systemFont(ofSize: 11)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
