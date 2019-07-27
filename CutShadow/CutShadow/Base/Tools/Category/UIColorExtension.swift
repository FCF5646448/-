//
//  UIColorExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/6/4.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    //16进制字符串设置颜色
    class func hex(_ hex:String, _ alpha: CGFloat = 1.0) -> UIColor {
        if hex == "0" {
            return UIColor.clear //如果为"0",就认为是透明色
        }
        let scanner:Scanner = Scanner(string: hex)
        var valueRGB:UInt32 = 0
        if scanner.scanHexInt32(&valueRGB) == false {
            return UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        }else{
            return UIColor.init(
                red: CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green: CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue: CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha: CGFloat(alpha))
        }
    }
    
    class func hex(_ hex:UInt32, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red:  CGFloat((hex & 0xFF0000)>>16)/255.0,
                       green: CGFloat((hex & 0x00FF00)>>8)/255.0,
                       blue: CGFloat(hex & 0x0000FF)/255.0,
                       alpha: CGFloat(alpha))
    }
    
    //RBG设置颜色
    class func RGB(red:CGFloat,green:CGFloat,blue:CGFloat,alpha: CGFloat = 1.0) -> UIColor {
        if #available(iOS 10, *) {
            return UIColor(displayP3Red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        }else{
            return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
        }
    }
    
    //使用rgb方式生成自定义颜色
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    //使用rgba方式生成自定义颜色
    convenience init(_ r : CGFloat, _ g : CGFloat, _ b : CGFloat, _ a : CGFloat) {
        let red = r / 255.0
        let green = g / 255.0
        let blue = b / 255.0
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
    //随机色
    class func randomColor() -> UIColor {
        arc4random()
        return UIColor.RGB(red: CGFloat(arc4random()%256), green: CGFloat(arc4random()%256), blue: CGFloat(arc4random()%256))
    }
}
