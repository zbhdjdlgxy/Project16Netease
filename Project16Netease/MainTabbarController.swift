//
//  MainTabbarController.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/8.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit
class MainTabbarController: UITabBarController,ZBTabBarDelegate,ZBAddDelegate{
    
    var customTabBar : ZBTabBar?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 删除系统自动生成的UITabBarButton
        for child in self.tabBar.subviews {
            if child is UIControl{
                
                child.removeFromSuperview()
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTabbar()
       self.setupAllChildViewControllers()
        
    }
    
    func setupTabbar(){
        
        let customTabBar : ZBTabBar = ZBTabBar()
        customTabBar.frame = self.tabBar.bounds;
        customTabBar.delegate = self;
        self.tabBar.addSubview(customTabBar)
        self.customTabBar = customTabBar;
    }
    
    func setupAllChildViewControllers(){
        
        // 1.首页
        let homeTVC : HomeTVC = HomeTVC()
        self.setupChildViewController(homeTVC, title: "首页", imageName: "tabbar_home", selectedImageName: "tabbar_home_selected")
        
        // 2.消息
        let messageTVC : MessageTVC = MessageTVC(style: .grouped)
        self.setupChildViewController(messageTVC, title: "消息", imageName: "tabbar_message_center", selectedImageName: "tabbar_message_center_selected")
        
        // 3.广场
        let discover : DiscoveryVC = DiscoveryVC()
        self.setupChildViewController(discover, title: "广场", imageName: "tabbar_discover", selectedImageName: "tabbar_discover_selected")
        
        // 4.我
        let meTVC : MeTVC = MeTVC(style: .grouped)
        self.setupChildViewController(meTVC, title: "我", imageName: "tabbar_profile", selectedImageName: "tabbar_profile_selected")
    }
    func setupChildViewController(_ childVc : UIViewController,title:String,imageName:String,selectedImageName:String) {
        
        // 1.设置控制器的属性
        childVc.title = title;
        // 设置图标
        childVc.tabBarItem.image = UIImage.init(named: imageName)
        // 设置选中的图标
        let selectedImage : UIImage = UIImage.init(named: selectedImageName)!
        childVc.tabBarItem.selectedImage = selectedImage.withRenderingMode(.alwaysOriginal)
        
        // 2.包装一个导航控制器
        let nav : BaseNavCTL = BaseNavCTL(rootViewController: childVc)
        self.addChildViewController(nav)
        
        // 3.添加tabbar内部的按钮
        self.customTabBar!.addTabBarButtonWithItem(childVc.tabBarItem)
    }
    
//    MARK: ZBAddDelegate
    func zBAdd(selectIndex selectItemIndex : IndexPath,title: String){
        
        if selectItemIndex.section != 1 || selectItemIndex.row != 2 {
            let headVC : HeadViewController = HeadViewController()
            headVC.title = title
            let nav : BaseNavCTL = BaseNavCTL(rootViewController: headVC)
            self.present(nav, animated: true, completion: nil)
        }
        
    }
    
//    MARK: ZBTabBarDelegate
    func tabBar(_ tabBar : ZBTabBar, selectBtnFrom : Int,to : Int){
        
        self.selectedIndex = to;
    }
    
    func tabBarDidPlusBtnClicked(){
        
        let add : ZBAdd = ZBAdd.init(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        
        add.delegate = self
        self.view.addSubview(add)
        self.view.bringSubview(toFront: add)
    }

    
}
