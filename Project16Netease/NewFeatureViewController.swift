//
//  NewFeatureViewController.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/5.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

class NewFeatureViewController: UIViewController,UIScrollViewDelegate {

    let W = UIScreen.main.bounds.size.width
    let H = UIScreen.main.bounds.size.height
    
    
    override func viewDidLoad() {
       
        
        
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }

    override func loadView() {
        
        self.view = UIView()
        self.view.backgroundColor = UIColor.white
        
        self.page.center = CGPoint(x: 0, y: self.H-30)
        self.page.bounds = CGRect(x: 0, y: 0, width: 100, height: 30);
        self.logBtn.frame = CGRect(x: 2 * self.W + (self.W - 100) / 2, y: self.H - 100, width: 100,height: 38 )
        self.scroll.addSubview(self.logBtn)
        self.view.addSubview(self.scroll)
        self.view.addSubview(self.page)
        
    }
    func startWeibo(){
        let mainCtl : MainTabbarController = MainTabbarController()
        UIApplication.shared.keyWindow?.rootViewController = mainCtl
    }
//    MARK: UIScrollViewDelegate
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / self.W
        self.page.currentPage = (Int)(page)
    }
    

// MARK: lazy
    lazy var scroll : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 0, width: self.W, height: self.H)
        scrollView.contentSize = CGSize(width: self.W * 3, height: self.H)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.delegate = self
        for i in 0..<3{
            let fealture : UIImageView = UIImageView()
            fealture.image = UIImage.init(named: String.init(format: "new_feature_%d", i+1))
            fealture.frame = CGRect(x: (CGFloat)(i) * self.W, y: 0, width: self.W, height: self.H)
            scrollView.addSubview(fealture)
        }
        return scrollView
        
    }()
    
    lazy var page : UIPageControl = {
        
        let pageCtl = UIPageControl()
        pageCtl.pageIndicatorTintColor = UIColor.black
        pageCtl.currentPageIndicatorTintColor = UIColor.red
        pageCtl.currentPage = 0
        pageCtl.numberOfPages = 3
        return pageCtl
    }()
    
    lazy var logBtn : UIButton = {
        
        let btn : UIButton = UIButton.init(type: .custom)
        btn.setTitle("开始微博", for: UIControlState())
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(self.startWeibo), for: .touchUpInside)
        return btn
        
    }()

}

