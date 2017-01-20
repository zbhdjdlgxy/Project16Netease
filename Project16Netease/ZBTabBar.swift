//
//  ZBTabBar.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/9.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit
protocol ZBTabBarDelegate {
    
    func tabBar(_ tabBar : ZBTabBar, selectBtnFrom : Int,to : Int)
    func tabBarDidPlusBtnClicked()
}



class ZBTabBar: UIView{

    var tabBarButtons : Array<TabBarBtn> = Array()
    
    lazy var plusBtn : UIButton = {
        let plusButton : UIButton = UIButton.init(type: .custom)
        plusButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_button"),for:UIControlState())
        plusButton.setBackgroundImage(UIImage.init(named: "tabbar_compose_button_highlighted"),for:.selected);
        plusButton.setImage(UIImage.init(named: "tabbar_compose_icon_add"),for:.selected)
        plusButton.setImage(UIImage.init(named: "tabbar_compose_icon_add_highlighted"),for:UIControlState())
        plusButton.bounds = CGRect(x: 0, y: 0, width: plusButton.currentBackgroundImage!.size.width, height: plusButton.currentBackgroundImage!.size.height)
        plusButton.addTarget(self, action: #selector(self.plus), for: .touchUpInside)
        return plusButton
        
    }()

    var selectedButton : TabBarBtn = TabBarBtn()
    var delegate: ZBTabBarDelegate?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(self.plusBtn)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        // 调整加号按钮的位置
        let h : CGFloat = self.frame.size.height;
        let w : CGFloat = self.frame.size.width;
        self.plusBtn.center = CGPoint(x: w * 0.5, y: h * 0.5)
        // 按钮的frame数据
        let buttonH : CGFloat = h
        let buttonW : CGFloat = w / (CGFloat)(self.subviews.count)
        let buttonY : CGFloat = 0
        for index in 0..<self.tabBarButtons.count {
            // 1.取出按钮
            let button : TabBarBtn = self.tabBarButtons[index]
            // 2.设置按钮的frame
            var buttonX : CGFloat = (CGFloat)(index) * buttonW
            if (index > 1) {
                buttonX += buttonW
            }
            button.frame = CGRect(x: buttonX, y: buttonY, width: buttonW, height: buttonH)
            // 3.绑定tag
            button.tag = index
        }
    }
    
    func plus(){
        
        self.delegate?.tabBarDidPlusBtnClicked()
    }
    
    func addTabBarButtonWithItem(_ item : UITabBarItem){
        // 1.创建按钮
        let button : TabBarBtn = TabBarBtn()
        self.addSubview(button)
        // 添加按钮到数组中
        self.tabBarButtons.append(button)
        // 2.设置数据
        button.item = item;
        
        // 3.监听按钮点击
        button.addTarget(self, action: #selector(self.buttonClick(_:)), for: .touchUpInside)
        
        // 4.默认选中第0个按钮
        if (self.tabBarButtons.count == 1) {
            self.buttonClick(button)
        }
    }

    func buttonClick(_ button : TabBarBtn){
        // 1.通知代理
        self.delegate?.tabBar(self, selectBtnFrom:self.selectedButton.tag,to:button.tag)
        // 2.设置按钮的状态
        self.selectedButton.isSelected = false;
        button.isSelected = true;
        self.selectedButton = button;
    }
}
