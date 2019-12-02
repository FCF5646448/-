//
//  DefaultHeader.swift
//  CartoonShow
//
//  Created by 冯才凡 on 2019/6/14.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import Foundation
import UIKit

//注意，在使用xib初始化的view里面。view的width和height是xib里的高度。为了更好地适配，最好使用这里的宽高
//屏幕宽度
let WIDTH = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.height : UIScreen.main.bounds.width

//屏幕高度
let HEIGHT = UIScreen.main.bounds.width > UIScreen.main.bounds.height ? UIScreen.main.bounds.width : UIScreen.main.bounds.height

let kScreenWidth:CGFloat      = WIDTH
let kScreenHeight:CGFloat     = HEIGHT
let kScreenSize:CGSize        = UIScreen.main.bounds.size
let IS_IPHONE_X_XR_MAX_Swift:Bool   = (UIScreen.main.nativeBounds.height == 1792 || UIScreen.main.nativeBounds.height == 2436 || UIScreen.main.nativeBounds.height == 2688)
let kNavBarHeight:CGFloat    = IS_IPHONE_X_XR_MAX_Swift ? 88.0 : 64.0
let kTabBarHeight:CGFloat    = IS_IPHONE_X_XR_MAX_Swift ? 83.0 : 49.0
let kStatusBarHeight:CGFloat = IS_IPHONE_X_XR_MAX_Swift ? 44.0 : 20.0

let kIsIPad:Bool             = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)


//主题色
let MainColor = "ffffff" // "ff80ab"
let textColor = "8a8a8a"

//
let BackColor = "ECECEC"

//lineColor
let lineColor = "d4d4d4"

//fontcolor
let BigFontColor = "4a4a4a"

//litterfontcolor'
let litterFontColor = "9b9b9b"


var IsPhone:Bool = true //默认是iphone

var GlobalScare = ToolManager.myAppSizeScale() //缩放比例
