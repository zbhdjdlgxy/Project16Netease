//
//  TabBarBtn.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/9.
//  Copyright © 2016年 szgyzb. All rights reserved.
//
// 图标的比例

import UIKit


class TabBarBtn: UIButton {
    
    var badgeButton : BadgeButton = BadgeButton()
    
    var item : UITabBarItem = UITabBarItem(){
        
        willSet{
            self.item = newValue
            newValue.addObserver(self, forKeyPath: "badgeValue", options: .new, context: nil)
            newValue.addObserver(self, forKeyPath: "title", options: .new, context: nil)
            newValue.addObserver(self, forKeyPath: "image", options: .new, context: nil)
            newValue.addObserver(self, forKeyPath: "selectedImage", options: .new, context: nil)
            
            self.observeValue(forKeyPath: nil, of: nil, change: nil, context: nil)
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        // 图标居中
        self.imageView!.contentMode = .center;
        // 文字居中
        self.titleLabel!.textAlignment = .center;
        // 字体大小
        self.titleLabel!.font = UIFont.systemFont(ofSize: 11);
        // 文字颜色
        self.setTitleColor(UIColor.black, for: UIControlState())
        self.setTitleColor(UIColor.rgbColor(234,green:103,blue:7), for: UIControlState())
        self.isHighlighted = false
        // 添加一个提醒数字按钮
        badgeButton.autoresizingMask = .flexibleLeftMargin
        self.addSubview(badgeButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let imageW : CGFloat = contentRect.size.width;
        let imageH : CGFloat = contentRect.size.height * 0.6;
        return CGRect(x: 0, y: 0, width: imageW, height: imageH);
    }
    
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        
        let titleY : CGFloat = contentRect.size.height * 0.6;
        let titleW : CGFloat = contentRect.size.width;
        let titleH : CGFloat = contentRect.size.height - titleY;
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH);
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        // 设置文字
        self.setTitle(self.item.title, for:.selected)
        self.setTitle(self.item.title ,for:UIControlState());
        
        // 设置图片
        self.setImage(self.item.image,for:UIControlState());
        self.setImage(self.item.selectedImage,for:.selected)
        
        // 设置提醒数字
        if self.item.badgeValue != nil {
            self.badgeButton.badgeValue = self.item.badgeValue!;
        }else{
            self.badgeButton.badgeValue = ""
        }
        
        
        // 设置提醒数字的位置
        let badgeY : CGFloat = 5;
        let badgeX : CGFloat = self.frame.size.width - self.badgeButton.frame.size.width - 10;
        var badgeF : CGRect = self.badgeButton.frame;
        badgeF.origin.x = badgeX;
        badgeF.origin.y = badgeY;
        self.badgeButton.frame = badgeF;
    }
    
    

}
