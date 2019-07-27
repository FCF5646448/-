//
//  NavigationExtension.swift
//  CartoonShow
//
//  Created by 冯才凡 on 2019/6/14.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    func setAppearance() {
        navigationBar.barTintColor = UIColor.hex(MainColor) //这个是设置bar背景色
        navigationBar.tintColor = UIColor.white //这个是设置返回按钮颜色
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white,NSAttributedString.Key.font:UIFont.systemFont(ofSize: 18)] // 这个是设置title颜色
        
        //去除navigationBar下的横线
        navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = false
    }
    
    func setTabBar(_ normalImgName:String,_ selectImgName:String, _ normalTitleColor:UIColor = UIColor.lightGray,_ selectTitleColor:UIColor = UIColor.white, title:String = "" ) {
        if let img = tabBarItem.selectedImage {
            tabBarItem.selectedImage = img.withRenderingMode(.alwaysOriginal)
        }
        
        
        let imgSel:UIImage? = UIImage(named: selectImgName)?.withRenderingMode(.alwaysOriginal)
        let imgnormal:UIImage? = UIImage(named: normalImgName)?.withRenderingMode(.alwaysOriginal)
        tabBarItem.image = imgnormal
        tabBarItem.selectedImage = imgSel

        tabBarItem.title = title
    tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:normalTitleColor], for: .normal)
    tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor:selectTitleColor], for: .selected)
    }
    
}
