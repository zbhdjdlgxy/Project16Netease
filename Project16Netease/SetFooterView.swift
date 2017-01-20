//
//  SetFooterView.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/16.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

protocol SetFooterViewDelegate {
    
    func SetFooterViewDidLogOutBtnClicked()
}

class SetFooterView: UIView {
    
    var delegate : SetFooterViewDelegate?
    

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(self.exitBtn)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        exitBtn.frame = CGRect(x: 20, y: 10, width: SCREENW - 40, height: self.frame.size.height - 10)
    }
    
    final func logout() {
        
        delegate?.SetFooterViewDidLogOutBtnClicked()
    }
    
//    MARK: lazy
    
    lazy var exitBtn : UIButton = {
        
        let btn : UIButton = UIButton(type: .custom)
        btn.backgroundColor = UIColor.red
        btn.setTitle("退出登录", for: UIControlState())
        btn.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        return btn
    }()
    
    

}
