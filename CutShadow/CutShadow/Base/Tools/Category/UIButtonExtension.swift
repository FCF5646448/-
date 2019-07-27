//
//  UIButtonExtension.swift
//  FCFCommonTools
//
//  Created by 冯才凡 on 2017/4/7.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit


extension UIButton{
    
    //获取title
    var title:String{
        if self.titleLabel != nil {
            if self.titleLabel!.text != nil {
                return self.titleLabel!.text!
            }else{
                return ""
            }
        }else{
            return ""
        }
    }
    
    //设置按钮上图片和文字的相对位置及间距：各个边界相对于原来的位置的位移，距离变大了就加，距离变小了就减。
    @objc func set(image anImage:UIImage?,title:String,titlePosition:UIView.ContentMode,additionalSpacing:CGFloat,state:UIControl.State,titleColor:String?=nil){
        self.imageView?.contentMode = .center
        setImage(anImage, for: state)
        positionLabelRespectToImage(title: title, position: titlePosition, spacing: additionalSpacing)
        self.titleLabel?.contentMode = .center
        self.setTitle(title, for: state)
        if titleColor != nil {
            self.setTitleColor(UIColor.hex(titleColor!), for: state)
        }
    }
    
    @objc func set(image anImage:UIImage?,attrititle:NSAttributedString,titlePosition:UIView.ContentMode,additionalSpacing:CGFloat,state:UIControl.State,titleColor:String?=nil){
        self.imageView?.contentMode = .center
        setImage(anImage, for: state)
        
        let titleStr = String(format: "%@", attrititle)
        positionLabelRespectToImage(title: titleStr, position: titlePosition, spacing: additionalSpacing)
        self.titleLabel?.contentMode = .center
        self.setAttributedTitle(attrititle, for: state)
        if titleColor != nil {
            self.setTitleColor(UIColor.hex( titleColor!), for: state)
        }
    }
    
    fileprivate func positionLabelRespectToImage(title:String,position:UIView.ContentMode,spacing:CGFloat){
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font
        let titleSize = (title as NSString).size(withAttributes: [NSAttributedString.Key.font: titleFont!])
        
        var titleInsets:UIEdgeInsets
        var imageInsets:UIEdgeInsets
        switch position {
        case .top:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + spacing/2.0), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (titleSize.height + spacing/2.0), left: 0, bottom: 0, right: -titleSize.width)
        case .bottom:
            titleInsets = UIEdgeInsets(top: (imageSize.height + spacing/2.0), left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(titleSize.height + spacing/2.0), left: 0, bottom: 0, right: -titleSize.width)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width + spacing/2.0), bottom: 0, right: (imageSize.width + spacing/2.0))
            imageInsets = UIEdgeInsets(top: 0, left: (titleSize.width+spacing/2.0), bottom: 0, right: -(titleSize.width+spacing/2.0))
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: spacing/2.0, bottom: 0, right: -spacing/2.0)
            imageInsets = UIEdgeInsets(top: 0, left: -spacing/2.0, bottom: 0, right: spacing/2.0)
        default:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
}
    // MARK: - 倒计时
    extension UIButton{
        
        public func countDown(count: Int){
            // 倒计时开始,禁止点击事件
            isEnabled = false
            
            // 保存当前的背景颜色
            let defaultColor = self.backgroundColor
            // 设置倒计时,按钮背景颜色
            backgroundColor = UIColor.gray
            
            var remainingCount: Int = count {
                willSet {
                    setTitle("重新发送(\(newValue))", for: .normal)
                    
                    if newValue <= 0 {
                        setTitle("发送验证码", for: .normal)
                    }
                }
            }
            
            // 在global线程里创建一个时间源
            let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
            // 设定这个时间源是每秒循环一次，立即开始
            codeTimer.scheduleRepeating(deadline: .now(), interval: .seconds(1))
            // 设定时间源的触发事件
            codeTimer.setEventHandler(handler: {
                
                // 返回主线程处理一些事件，更新UI等等
                DispatchQueue.main.async {
                    // 每秒计时一次
                    remainingCount -= 1
                    // 时间到了取消时间源
                    if remainingCount <= 0 {
                        self.backgroundColor = defaultColor
                        self.isEnabled = true
                        codeTimer.cancel()
                    }
                }
            })
            // 启动时间源
            codeTimer.resume()
        }
        
    }
