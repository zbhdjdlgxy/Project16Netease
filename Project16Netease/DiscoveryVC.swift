//
//  DiscoveryVC.swift
//  Project16Netease
//
//  Created by 张标 on 16/8/31.
//  Copyright © 2016年 szgyzb. All rights reserved.
//

import UIKit

class DiscoveryVC: UIViewController {

    var groundLayer:CALayer?
    var yellowPath:CAShapeLayer?
    var greenPath:CAShapeLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.gray
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let size = view.frame.size
        initGradientLayer(size)
        addCloudAnimation(size)
        groundLayer = initGroundLayer(size)
        initGrasslandlayer(size)
        addTreeLayer(size)
        yellowPath = initYellowPathLayer(size)
        for index in 0...4 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(70 * index) * Int64(NSEC_PER_MSEC)) / Double(NSEC_PER_SEC), execute: {
                self.addYellowCarPathAnimation()
            })
        }
    }

    //初始化草坪
    func initGrasslandlayer(_ size:CGSize){
        let grasslandOne = CAShapeLayer()
        //通过UIBezierPath来绘制路径
        let pathOne:UIBezierPath = UIBezierPath()
        pathOne.move(to: CGPoint(x: 0, y: size.height - 69))
        pathOne.addLine(to: CGPoint(x: 0, y: size.height - 149))
        pathOne.addQuadCurve(to: CGPoint(x: size.width/2.0, y: size.height - 69), controlPoint: CGPoint(x: size.width/6.0, y: size.height - 170))
        grasslandOne.path = pathOne.cgPath
        //设置草坪的颜色
        grasslandOne.fillColor = UIColor.init(colorLiteralRed: 82.0/255.0, green: 177.0/255.0, blue: 44.0/255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(grasslandOne)
        
        let grasslandTwo = CAShapeLayer()
        let pathTwo:UIBezierPath = UIBezierPath()
        pathTwo.move(to: CGPoint(x: size.width/2.0 - 50, y: size.height - 69))
        pathTwo.addQuadCurve(to: CGPoint(x: size.width, y: size.height - 90), controlPoint: CGPoint(x: size.width/2.0 + 70, y: size.height - 140))
        pathTwo.addLine(to: CGPoint(x: size.width, y: size.height - 69))
        grasslandTwo.path = pathTwo.cgPath
        grasslandTwo.fillColor = UIColor.init(colorLiteralRed: 92.0/255.0, green: 195.0/255.0, blue: 52.0/255.0, alpha: 1.0).cgColor
        view.layer.addSublayer(grasslandTwo)
    }
    
    //初始化大地
    func initGroundLayer(_ size:CGSize) -> CALayer {
        let ground:CALayer = CALayer()
        ground.frame = CGRect(x: 0, y: size.height - 69, width: size.width, height: 20)
        ground.backgroundColor = UIColor.init(patternImage: UIImage.init(named: "ground")!).cgColor
        view.layer.addSublayer(ground)
        return ground
    }
    
    //添加黄色轨道的动画
    func addYellowCarPathAnimation() {
        let carLayer:CALayer = CALayer()
        carLayer.frame = CGRect(x: 0, y: 0, width: 17, height: 11)
        carLayer.setAffineTransform(carLayer.affineTransform().translatedBy(x: 0, y: -7))
        carLayer.contents = UIImage.init(named: "car")!.cgImage
        let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "position")
        animation.path = yellowPath?.path
        animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear)
        animation.duration = 6
        animation.repeatCount = MAXFLOAT
        animation.autoreverses = false
        animation.calculationMode = kCAAnimationCubicPaced
        animation.rotationMode = kCAAnimationRotateAuto
        yellowPath?.addSublayer(carLayer)
        carLayer.add(animation, forKey: "carAnimation")
    }
    
    //初始化黄色轨道
    func initYellowPathLayer(_ size:CGSize) -> CAShapeLayer {
        let calayer:CAShapeLayer = CAShapeLayer()
        calayer.backgroundColor = UIColor.red.cgColor
        calayer.lineWidth = 5
        calayer.strokeColor = UIColor.init(colorLiteralRed: 210.0/255.0, green: 179.0/255.0, blue: 54.0/255.0, alpha: 1.0).cgColor
        let path:UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: size.height - 159))
        path.addCurve(to: CGPoint(x: size.width/2 + 50, y: size.height/2 + 150), controlPoint1: CGPoint(x: size.width/6, y: size.height - 300), controlPoint2: CGPoint(x: size.width/2.5, y: size.height))
       path.addQuadCurve(to: CGPoint(x: size.width+10, y: size.height/4 * 2.5), controlPoint: CGPoint(x: size.width/4 * 3, y: 350))
        path.addLine(to: CGPoint(x: size.width + 10, y: size.height+59))
        path.addLine(to: CGPoint(x: 0, y: size.height+59))
        calayer.fillColor = UIColor.init(patternImage: UIImage.init(named: "yellow")!).cgColor
        calayer.path = path.cgPath
        view.layer.insertSublayer(calayer, below: groundLayer)
        
        let lineLayer:CAShapeLayer = CAShapeLayer()
        lineLayer.lineCap = kCALineCapRound
        lineLayer.strokeColor = UIColor.white.cgColor
        lineLayer.lineDashPattern = [NSNumber.init(value: 1 as Int32),NSNumber.init(value: 5 as Int32)]
        lineLayer.lineWidth = 2
        lineLayer.fillColor = UIColor.clear.cgColor
        lineLayer.path = path.cgPath
        calayer.addSublayer(lineLayer)
        
        return calayer
    }
    
    //初始化云朵动画
    func addCloudAnimation(_ size:CGSize) {
        let cloudLayer:CALayer = CALayer()
        cloudLayer.contents = UIImage.init(named: "cloud")?.cgImage
        cloudLayer.frame = CGRect(x: -63, y: 100, width: 63, height: 20)
        view.layer.addSublayer(cloudLayer)
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -63, y: 100))
        path.addLine(to: CGPoint(x: size.width, y: 100))
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 8
        animation.autoreverses = false
        animation.repeatCount = MAXFLOAT
        animation.calculationMode = kCAAnimationPaced
        cloudLayer.add(animation, forKey: "position")
    }
    
    //添加树
    func addTreeLayer(_ size:CGSize) {
        for index in 0...6 {
            let treeOne = CALayer()
            treeOne.contents = UIImage.init(named: "tree")?.cgImage
            treeOne.frame = CGRect(x: [5,55,70,size.width/3+15,size.width/3+25,size.width-130,size.width-160][index], y: size.height - 95, width: 13, height: 23)
            view.layer.addSublayer(treeOne)
        }
    }
    
    //初始化背景
    func initGradientLayer(_ size:CGSize){
        let layer:CAGradientLayer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height - 20)
        //设置渐变的颜色
        layer.colors = [UIColor.init(colorLiteralRed: 178.0/255.0, green: 226.0/255.0, blue: 248.0/255.0, alpha: 1.0).cgColor, UIColor.init(colorLiteralRed: 232.0/255.0, green: 244.0/255.0, blue: 193.0/255.0, alpha: 1.0).cgColor]
        //设置渐变的方向为从左到右
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 1)
        view.layer.addSublayer(layer)
    }
}
