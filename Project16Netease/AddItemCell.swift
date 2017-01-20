//
//  AddItemCell.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/11.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

final class AddItemCell: UICollectionViewCell {

    
    
    class func cellWithCollectionView(_ collectionView : UICollectionView,index : IndexPath) -> AddItemCell{
        
        let identifier = "AddItemCell"
        let itemCell :  AddItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: index) as! AddItemCell
        return itemCell
        
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.addSubview(self.textLabel)
        self.addSubview(self.imageView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.imageView.frame = CGRect(x: 2, y: 2, width: self.frame.size.width - 4, height: self.frame.size.width - 4)
        self.textLabel.frame = CGRect(x: 0, y: self.imageView.frame.maxY, width: self.frame.size.width, height: self.frame.size.height - (self.frame.size.width - 4))
    }
    
//    MARK: lazy
    var imageView : UIImageView = {
        
        var icon : UIImageView = UIImageView.init()
        return icon
    }()

    var textLabel : UILabel = {
        
        var titleLabel : UILabel = UILabel.init()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
}
