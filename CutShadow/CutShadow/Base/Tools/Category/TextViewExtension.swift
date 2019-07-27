//
//  TextViewExtension.swift
//  FCFCommonFrame
//
//  Created by 冯才凡 on 2017/5/15.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit

extension UITextView{
    func appendLinkString(string:String,withURLString:String = "") {
        //原来内容
        let attrString:NSMutableAttributedString = NSMutableAttributedString()
        attrString.append(self.attributedText)
        //
        let attrs = [NSAttributedString.Key.font:self.font ?? UIFont.systemFont(ofSize: 13)]
        let appendString = NSMutableAttributedString.init(string: string, attributes: attrs)
        
        if withURLString != "" {
            let range:NSRange = NSMakeRange(0, appendString.length)
            appendString.beginEditing()
            appendString.addAttribute(NSAttributedString.Key.link,value:withURLString,range:range)
            appendString.endEditing()
        }
        
        attrString.append(appendString)
        
        self.attributedText = attrString
        
    }
    
    //给键盘上方添加完成按钮
    func appendinputAccessoryView(donetarget: Any?, doenaction: Selector,canceltarget: Any?, cancelaction: Selector){
        let toolBar = UIToolbar()
        
        let cancel = UIButton(type: .custom)
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor.hex(BigFontColor), for: .normal)
        cancel.frame = CGRect(x: 0, y: 0, width: 60, height: 49)
        cancel.addTarget(canceltarget, action: cancelaction, for: .touchUpInside)
        let cancelBarItem = UIBarButtonItem(customView: cancel)
        
        
        let done = UIButton(type: .custom)
        done.setTitle("完成", for: .normal)
        done.setTitleColor(UIColor.hex( BigFontColor), for: .normal)
        done.frame = CGRect(x: 0, y: 0, width: 60, height: 49)
        done.addTarget(donetarget, action: doenaction, for: .touchUpInside)
        let doneBarItem = UIBarButtonItem(customView: done)
        
        //第一个分隔按钮
        let btngap1 =  UIBarButtonItem(barButtonSystemItem:.flexibleSpace,
                                       target:nil,
                                       action:nil)
        toolBar.setItems([cancelBarItem,btngap1,doneBarItem], animated: false)
        toolBar.sizeToFit()
        inputAccessoryView = toolBar
    }
    
}
