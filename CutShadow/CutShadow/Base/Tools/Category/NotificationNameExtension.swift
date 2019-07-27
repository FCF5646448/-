//
//  NotificationNameExtension.swift
//  hongRenDianDian
//
//  Created by BingJun_iOS_Master on 2017/9/29.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation

//各种通知名字
extension NSNotification.Name {
    //登录成功
    static var loginSucc: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.LoginSuccess")
    }
    
    //登录失败
    static var loginFail: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.Failed")
    }
    
    //微信登录后跳转到绑定手机号
    static var WXLoginSuccToBindPhoneNum: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.nl.OK")
    }
    static var WXLoginFailToBindPhoneNum: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.nl.fail")
    }
    
    //微信登录失败
    static var loginWYFail: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.error.wxlogin.fail")
    }
    
    //微信登录成功
    static var loginWYSucc: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.success.wxlogin.ok")
    }
    
    //微博登录失败
    static var loginSinaWBFail: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.error.sinaWblogin.fail")
    }
    //微博登录成功
    static var loginSinaWBSucc: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.success.sinaWbllogin.ok")
    }
    //QQ登录失败
    static var loginQQFail: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.error.qqlogin.fail")
    }
    //QQ登录成功
    static var loginQQSucc: NSNotification.Name {
        return NSNotification.Name(rawValue: "com.fcf.success.qqllogin.ok")
    }
    //支付宝支付失败
    static var aliPayFailer:NSNotification.Name {
        return NSNotification.Name(rawValue:"com.ali.error.fail")
    }
    //支付宝支付成功
    static var aliPaySucc:NSNotification.Name {
        return NSNotification.Name(rawValue:"com.ali.success.ok")
    }
    //微信支付失败
    static var wxPayFailer:NSNotification.Name {
        return NSNotification.Name(rawValue:"com.wxpay.error.fail")
    }
    //微信支付成功
    static var wxPaySucc:NSNotification.Name {
        return NSNotification.Name(rawValue:"com.wxpay.success.ok")
    }
    
//    static var doneAction:NSNotification.Name {
//        return NSNotification.Name(rawValue:"doneAction")
//    }
    
}
