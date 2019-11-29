//
//  ViewExtension.swift
//  FCFCommonTools
//
//  Created by 冯才凡 on 2017/4/6.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit

public enum ShakeDirection:Int{
    case horizontal //水平
    case vertical //垂直
}

extension UIView {
    
    //获取任意试图view指定类型的父视图T,例如cell上的btn获取cell：let cell = btn.superView(of:UITableViewCell.self)
    func superView<T:UIView>(of: T.Type) -> T? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let father = view as? T {
                return father
            }
        }
        return nil
    }
    
    //获取任意试图view所属视图控制器UIViewController
    func firstViewController() -> UIViewController? {
        for view in sequence(first: self.superview, next: {$0?.superview}) {
            if let response = view?.next {
                if response.isKind(of: UIViewController.self){
                    return response as? UIViewController
                }
            }
        }
        return nil
    }
    
    /**
     @IBInspectable 用于修饰属性，其修饰的属性可以在xib右侧面板中修改，也可以直接通过代码.出来
     */
    
    /// 设置圆角
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    /// 设置描边
    @IBInspectable var borderColor: UIColor {
        get {
            guard let c = layer.borderColor else {
                return UIColor.clear
            }
            return UIColor(cgColor: c)
        }
        
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    /// 设置描边粗细
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    /// x
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        
        set {
            frame.origin.x = newValue
        }
    }
    
    /// y
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        
        set {
            frame.origin.y = newValue
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        
        set {
            center.x = newValue
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        
        set {
            center.y = newValue
        }
    }
    
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            frame.size.width = newValue
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set {
            frame.size.height = newValue
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        
        set {
            frame.size = newValue
        }
    }
    
    var top: CGFloat {
        get{
            return self.y
        }
        set{
            self.y = newValue
        }
    }
    
    var left: CGFloat {
        get{
            return self.x
        }
        set{
            self.x = newValue
        }
    }
    
    var bottom: CGFloat {
        get{
            return self.y + self.height
        }
        set{
            self.y = newValue - self.height
        }
    }
    
    var right: CGFloat {
        get{
            return self.x + self.width
        }
        set{
            self.x = newValue - self.width
        }
    }
    
    /**
     扩展UIView增加抖动方法
     
     @param direction：抖动方向（默认是水平方向）
     @param times：抖动次数（默认5次）
     @param interval：每次抖动时间（默认0.1秒）
     @param delta：抖动偏移量（默认2）
     @param completion：抖动动画结束后的回调
     */
    public func shake(direction:ShakeDirection = .horizontal , times:Int = 5,interval:TimeInterval = 0.1, delta:CGFloat = 2, completion:(()->Void)?=nil){
        //播放动画
        UIView.animate(withDuration: interval, animations: {
            switch direction{
            case .horizontal:
                self.layer.setAffineTransform(CGAffineTransform.init(translationX: delta, y: 0))
                break
            case .vertical:
                self.layer.setAffineTransform(CGAffineTransform.init(translationX: 0, y: delta))
                break
            }
        }) { (complete) in
            //如果当前是最后一次抖动，则将位置还原，并调用完成回调函数
            if times == 0 {
                UIView.animate(withDuration: interval, animations: {
                    self.layer.setAffineTransform(CGAffineTransform.identity)
                }, completion: { (complete) in
                    completion?()
                })
            }else{
                //如果不是最后一次抖动，则继续播放动画，总次数减一，偏移位置变成相反
                self.shake(direction: direction, times: times - 1, interval: interval, delta: delta * -1, completion: completion)
            }
        }
    }
    
    
    //用图片做阴影,分别对应上、左、下、右 阴影图片默认高度3
    func shadowImg(topImgName:String?=nil,leftImgName:String?=nil,bottomImgName:String?=nil,rightImgName:String?=nil,offsetW:CGFloat = 3,cornerRadius:CGFloat = 0){
        //        self.layer.cornerRadius = cornerRadius
        //        self.layer.masksToBounds = true
        
        if topImgName != nil {
            let imgView = UIImageView(frame: CGRect(x: self.left, y: -offsetW, width: self.width, height: offsetW))
            imgView.image = UIImage(named: topImgName!)
            self.addSubview(imgView)
        }
        if leftImgName != nil {
            let imgView = UIImageView(frame: CGRect(x: -offsetW, y: self.top, width: offsetW, height: self.height))
            imgView.image = UIImage(named: leftImgName!)
            self.addSubview(imgView)
        }
        if bottomImgName != nil {
            let imgView = UIImageView(frame: CGRect(x: self.left, y: self.bottom, width: self.width, height: offsetW))
            imgView.image = UIImage(named: bottomImgName!)
            self.addSubview(imgView)
        }
        if rightImgName != nil {
            let imgView = UIImageView(frame: CGRect(x: self.right, y: self.top, width: offsetW, height: self.height))
            imgView.image = UIImage(named: rightImgName!)
            self.addSubview(imgView)
        }
    }
    
    //画虚线
    func addlineWithColor(color:UIColor,boarderW:CGFloat,startP:CGPoint,endP:CGPoint,lineType:[NSNumber]=[]) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let path = UIBezierPath()
        path.move(to: startP)
        path.addLine(to: endP)
        
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = boarderW
        shapeLayer.lineCap = CAShapeLayerLineCap(rawValue: "square")
        if lineType.count > 0 {
            shapeLayer.lineDashPattern = lineType
        }
        
        self.layer.addSublayer(shapeLayer)
    }
    
    //四周添加阴影
    @objc func addAllShadow(shadowRadius: CGFloat, shadowColor:CGColor, offset:CGSize = CGSize(width: 0, height: 0),opacity:Float = 0.9) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset //阴影偏移量
        self.layer.shadowRadius = shadowRadius //模糊半径
        self.layer.shadowOpacity = opacity //不透明度
        self.layer.shadowColor = shadowColor //
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [UIRectCorner.topLeft,.bottomLeft], cornerRadii: CGSize(width: 10, height: 10))
        self.layer.shadowPath = path.cgPath
    }
    
    //三周添加阴影
    @objc func addThreeShadow(shadowRadius: CGFloat, shadowColor:CGColor, offset:CGSize = CGSize(width: 0, height: 0),opacity:Float = 0.9) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = shadowColor
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: shadowRadius))
        path.addLine(to: CGPoint(x: 0, y: self.bounds.size.height))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: self.bounds.size.height))
        path.addLine(to: CGPoint(x: self.bounds.size.width, y: 8))
        path.addLine(to: CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.9))
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    //三周添加阴影
    @objc func addLeftAndRightShadow(shadowRadius: CGFloat, shadowColor:CGColor, offset:CGSize = CGSize(width: 0, height: 0),opacity:Float = 0.9) {
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = shadowColor
        
        
        let margin = sqrt(shadowRadius*shadowRadius*2)
        let path = UIBezierPath()
        path.move(to: CGPoint(x: margin, y: margin))
        path.addLine(to: CGPoint(x: margin, y: self.bounds.size.height-margin))
        path.addLine(to: CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.4))
        path.addLine(to: CGPoint(x: self.bounds.size.width-margin, y: margin))
        path.addLine(to: CGPoint(x: self.bounds.size.width-margin , y: self.bounds.size.height-margin))
        path.addLine(to: CGPoint(x: self.bounds.size.width * 0.5, y: self.bounds.size.height * 0.6))
        path.close()
        self.layer.shadowPath = path.cgPath
    }
    
    
    // 给当前view添加渐变色
    func addGradualColors(_ fromColor:String, _ toColor:String) {
        var gradientLayer:CAGradientLayer?
        if let sublayers = self.layer.sublayers,sublayers.count > 0 {
            if sublayers.first!.isKind(of: CAGradientLayer.self) {
                gradientLayer = sublayers.first as? CAGradientLayer
            }
        }
        
        if gradientLayer == nil {
            gradientLayer = CAGradientLayer()
            self.layer.insertSublayer(gradientLayer!, at: 0)
        }
        
        
        
        gradientLayer!.frame = self.bounds
        
        //创建渐变色数组，需要转换为CGColor颜色
        gradientLayer!.colors = [UIColor.hexString(hex: fromColor).cgColor,UIColor.hexString(hex: toColor).cgColor]
        
        //  设置渐变颜色方向，左上点为(0,0), 右下点为(1,1)
        gradientLayer!.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer!.endPoint = CGPoint(x: 1, y: 1)
        
        //  设置颜色变化点，取值范围 0.0~1.0
        gradientLayer!.locations = [0,1]
        
    }
    
    func startZRotation(duration: CFTimeInterval = 1, repeatCount: Float = Float.infinity, clockwise: Bool = true)
    {
        if self.layer.animation(forKey: "transform.rotation.z") != nil {
            return
        }
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        let direction = clockwise ? 1.0 : -1.0
        animation.toValue = NSNumber(value: Double.pi * 2 * direction)
        animation.duration = duration
        animation.isCumulative = true
        animation.repeatCount = repeatCount
        self.layer.add(animation, forKey:"transform.rotation.z")
    }
    
    
    /// Stop rotating the view around Z axis.
    func stopZRotation()
    {
        self.layer.removeAnimation(forKey: "transform.rotation.z")
    }

}
