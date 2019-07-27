//
//  TextFieldExtension.swift
//  hongRenDianDian
//
//  Created by bingjun01 on 2017/12/14.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    //给键盘上方添加完成按钮
    func appendinputAccessoryView(donetarget: Any?, doenaction: Selector,canceltarget: Any?, cancelaction: Selector){
        let toolBar = UIToolbar()
        
        let cancel = UIButton(type: .custom)
        cancel.setTitle("取消", for: .normal)
        cancel.setTitleColor(UIColor.hex( BigFontColor), for: .normal)
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
    
    //用于电话校验
    func checkoutPhoneNum(for regex: String, in phoneNum: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = phoneNum as NSString
            let results = regex.matches(in: phoneNum, range: NSRange(location: 0, length: nsString.length))
            let resultArray = results.map { nsString.substring(with: $0.range) }
            print(resultArray.count)
            if resultArray.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error {
            print("无效正则表达式: \(error.localizedDescription)")
            return false
        }
    }
    
    //校验字符串由字母数字组成并且大于6位
    func checkoutPassowrdString(with password: String) -> Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        let result = pred.evaluate(with: password)
        return result;
    }

}


