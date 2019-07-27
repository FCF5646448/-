//
//  UILableExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/12/1.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

var labelCopyKey = "labelCopyKeyIdentifier"
var copyFinishKey = "labelCopyFinishKeyIdentifier"

extension UILabel {
    @objc var isCopy:Bool{
        set(newValue){
            objc_setAssociatedObject(self, &labelCopyKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
            if newValue {
                //添加点击手势
                self.isUserInteractionEnabled = true
                let tapPress = UITapGestureRecognizer(target: self, action:  #selector(handleTap(_:)))
                self.addGestureRecognizer(tapPress)
            }
        }
        get{
            return objc_getAssociatedObject(self, &labelCopyKey) as? Bool ?? false
        }
    }
    
    typealias opCallBack = ((_ result:Bool)->(Void))
    
    @objc var copyComplete:opCallBack?{
        set(newValue){
            objc_setAssociatedObject(self, &copyFinishKey, newValue, .OBJC_ASSOCIATION_COPY)
        }
        get{
            return objc_getAssociatedObject(self, &copyFinishKey) as? opCallBack
        }
    }
    
    @objc func handleTap(_ sender:UIGestureRecognizer) {
        self.becomeFirstResponder() //成为第一响应者，才会显示menu
        
        let menu = UIMenuController.shared
        let item = UIMenuItem(title: "复制", action: #selector(copyText(_:)))
        menu.menuItems = [item]
        menu.setTargetRect(self.frame, in: self.superview!)
        menu.setMenuVisible(true, animated: true)
    }
    
    @objc func copyText(_ sender:UIMenuController){
        let pboad = UIPasteboard.general
        //
        if (objc_getAssociatedObject(self, "expectedText") != nil) {
            pboad.string = objc_getAssociatedObject(self, "expectedText") as? String ?? ""
        }else{
            if self.text != nil {
                pboad.string = self.text
            }else{
                pboad.string = self.attributedText?.string ?? ""
            }
        }
        self.copyComplete?(true)
//        HUBManager.showStatu("学号已复制")
    }
    
    //要显示UIMenuController，必须实现以下两个方法
    @objc override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copyText(_:)) {
            return true
        }
        return super.canPerformAction(action, withSender: sender)
    }
    
    @objc open override var canBecomeFirstResponder: Bool {
        return objc_getAssociatedObject(self, &labelCopyKey) as? Bool ?? false
    }
    
}
