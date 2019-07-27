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

}
