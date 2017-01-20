//
//  Add.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/11.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

protocol ZBAddDelegate {
    
    func zBAdd(selectIndex selectItemIndex : IndexPath,title: String)
}


final class ZBAdd: UIView,UICollectionViewDelegate,UICollectionViewDataSource {
    
    
    static let screenW : CGFloat = UIScreen.main.bounds.width

    var delegate : ZBAddDelegate?
    
    
    var contentArr : NSArray? //第一页列表
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupData()
        self.firstCollectionView.register(AddItemCell.self, forCellWithReuseIdentifier: "AddItemCell")
        
        self.backgroundColor = UIColor.init(red: 246/255.0, green: 244/255.0, blue: 245/255.0, alpha: 0.95)
        self.addSubview(self.firstCollectionView)
        self.addSubview(self.dateLabel)
        self.addSubview(self.adImageView)
        self.addSubview(self.backBtn)
        self.addSubview(self.exitBtn2)
        self.addSubview(self.exitBtn)
        self.addSubview(self.exitImgView)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupData(){
        
        let path = Bundle.main.path(forResource: "AddFirstItems.plist", ofType: nil)
        contentArr = NSArray(contentsOfFile: path!)
        firstCollectionView.reloadData()

    }

    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.dateLabel.frame = CGRect(x: 10, y: 100, width: SCREENW, height: 30)
        self.adImageView.frame = CGRect(x: SCREENW - 140 - 10, y: 66, width: 140, height: 140)
        
        self.firstCollectionView.frame = CGRect(x: 0, y: SCREENH, width: SCREENW, height: 0)
        self.exitBtn.frame = CGRect(x: 0, y: SCREENH - 49, width: SCREENW, height: 49)
        self.backBtn.frame = CGRect(x: 0, y: SCREENH - 49, width: SCREENW/2, height: 49)
        self.exitBtn2.frame = CGRect(x: SCREENW/2, y: SCREENH - 49, width: SCREENW/2, height: 49)
        
        self.exitImgView.frame = CGRect(x: (SCREENW - 50)/2,y: SCREENH - 49 , width: 50, height: 50)
        UIView.animate(withDuration: 0.3, animations: {
            self.exitImgView.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI/4))
        }) 
        self.exitImgView.transform = CGAffineTransform(rotationAngle: (CGFloat)(M_PI/4))
        let firstCollectionViewH = SCREENH * 0.4
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveLinear, animations: {
            self.firstCollectionView.frame = CGRect(x: 0, y: SCREENH - firstCollectionViewH - 49, width: SCREENW, height: firstCollectionViewH)
        
        }, completion: nil)
        
    }
    
    func exitAction() {

        
        self.removeFromSuperview()
    }
    
    func backAction() {
        self.firstCollectionView.isHidden = false
        self.exitBtn2.isHidden = true
        self.backBtn.isHidden = true
        
        self.exitBtn.isHidden = false
        self.exitImgView.isHidden = false
        self.firstCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: .right, animated: true)
    }
    
//    MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        
        return 6
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell : AddItemCell = AddItemCell.cellWithCollectionView(collectionView,index : indexPath)
        var msgDic : NSDictionary = NSDictionary()
        
        if collectionView == firstCollectionView {
            msgDic = contentArr?.object(at: indexPath.section * 6 + indexPath.row) as! NSDictionary
        }
        
        cell.textLabel.text = msgDic["title"] as? String
        cell.imageView.image = UIImage.init(named: (msgDic["name"] as? String)!)
        return cell
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        
        return 2
    }

//    MARK: UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 5 {
            self.exitBtn2.isHidden = false
            self.backBtn.isHidden = false
            self.exitBtn.isHidden = true
            self.exitImgView.isHidden = true
            let index : IndexPath = IndexPath.init(row: 5, section: 1)
            collectionView.scrollToItem(at: index, at: .left, animated: true)
            
        }else{
            let msgDic = contentArr?.object(at: indexPath.section * 6 + indexPath.row) as! NSDictionary
            self.delegate?.zBAdd(selectIndex: indexPath, title: msgDic["title"] as! String)
        }
        
    }

    
//    MARK: lazy
    
    lazy var dateLabel : UILabel = {
        
        let dateLbl : UILabel = UILabel()
        let date : Date = Date()
        let format : DateFormatter = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateStr : String = format.string(from: date)
        dateLbl.text = dateStr
        return dateLbl
    }()
    
    lazy var adImageView : UIImageView = {
        
        let imageView : UIImageView = UIImageView.init(image: UIImage.init(named: "adIcon.jpg"))
        return imageView
    }()
    
    lazy var exitBtn : UIButton = {
       
        let exitButton : UIButton = UIButton(type: .custom)
        exitButton.backgroundColor = UIColor.white
        exitButton.addTarget(self, action: #selector(self.exitAction), for: .touchUpInside)
        exitButton.isHidden = false
        return exitButton
    }()
    
    lazy var backBtn : UIButton = {
        
        let backButton : UIButton = UIButton(type: .custom)
        backButton.backgroundColor = UIColor.white
        backButton.addTarget(self, action: #selector(self.backAction), for: .touchUpInside)
        backButton.setImage(UIImage.init(named: "back"), for: UIControlState())
        backButton.isHidden = false
        return backButton
    }()
    
    lazy var exitBtn2 : UIButton = {
        
        let exitButton : UIButton = UIButton(type: .custom)
        exitButton.backgroundColor = UIColor.white
        exitButton.imageView?.contentMode = .scaleAspectFill
        exitButton.addTarget(self, action: #selector(self.exitAction), for: .touchUpInside)
        exitButton.setImage(UIImage.init(named: "exit2"), for: UIControlState())
        exitButton.isHidden = false
        return exitButton
    }()
    
    lazy var exitImgView : UIImageView = {
       
        let image : UIImageView = UIImageView.init(image: UIImage.init(named: "exit"))
        return image
    }()
    
    let cellW = SCREENW * 0.21
    
    
    lazy var firstCollectionView : UICollectionView = {
        var layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collect : UICollectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collect.delegate = self
        collect.dataSource = self
        collect.backgroundColor = UIColor.clear
        collect.isPagingEnabled = true
        collect.showsVerticalScrollIndicator = false
        collect.showsHorizontalScrollIndicator = false
        layout.itemSize = CGSize(width: self.cellW, height: self.cellW + 40)
        let mm = (SCREENW - 3 * self.cellW) / 4
        layout.headerReferenceSize = CGSize(width: mm, height: 0);
        layout.footerReferenceSize = CGSize(width: mm, height: 0);
        layout.minimumLineSpacing = mm
        layout.minimumInteritemSpacing = 0
        
        return collect
    }()

}
