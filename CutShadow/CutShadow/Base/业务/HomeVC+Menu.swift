//
//  HomeVC+Menu.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/9/19.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import Foundation
import SideMenu


extension HomeVC {
    
    func settingMenu() {
        
        // 创建一个按钮（点击后显示侧栏菜单）
        let button = UIButton(type:.system)
        button.frame = CGRect(x:0, y:kNavBarHeight - 44, width:64, height:44)
        button.setTitle("menu", for:.normal)
        button.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        let itemBar = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = itemBar
        //
        // 定义一个侧栏菜单
        let menu = UISideMenuNavigationController(rootViewController: MenuViewController())
        menu.isNavigationBarHidden = true //侧栏菜单不显示导航栏
        menu.menuWidth = round(min(WIDTH, HEIGHT) * 0.5)
        // 将其作为默认的右侧菜单
        SideMenuManager.default.leftMenuNavigationController = menu
        
        // 开启通过边缘滑动打开侧栏菜单的功能
        SideMenuManager.default.addPanGestureToPresent(toView:
            self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView:
            self.navigationController!.view)
        
        // 将阴影透明度设为0
        menu.presentationStyle.onTopShadowOpacity = 0
        
        
        // 默认情况下，展开动画播放时间为 0.35 秒
        menu.presentDuration = 0.35
        // 默认情况下，消失动画播放时间未 0.35秒
        menu.dismissDuration = 0.35
        // 菜单展开时的弹性动画效果
        menu.animationOptions = .curveEaseOut
        
        //动画弹性阻尼和速度
        menu.usingSpringWithDamping = 1
        
        // 默认情况下，做完手势动作后，剩余部分的动画时间为 0.35秒
        menu.completeGestureDuration = 0.35
        // 手势动作完成后，剩余部分的动画效果
        menu.completionCurve = .easeIn
        
        // 阻止状态栏背景变黑
        menu.statusBarEndAlpha = 1.0 //为0 statusBar 背景色为clear
        
        // 将侧栏菜单初始fade值设为0.5
        menu.presentationStyle.presentingParallaxStrength = CGSize(width: kScreenWidth*0.8, height: 0)
        
        // 将侧栏菜单初始时尺寸为正常值的一半 做动画时，就会有缩放的效果
        menu.presentationStyle.menuScaleFactor = 1.0
        
        // 动画过程的背景色
        menu.presentationStyle.backgroundColor = UIColor.hex(MainColor)
        menu.presentationStyle.onTopShadowColor = UIColor.hex(MainColor)
        menu.presentationStyle.onTopShadowOpacity = 0.4
        menu.presentationStyle.onTopShadowRadius = 10
        
    }
    
}

extension HomeVC {
    // 按钮点击响应
    @objc func tapped(){
        // 显示侧栏菜单
        self.present(SideMenuManager.default.leftMenuNavigationController!, animated: true,
                     completion: nil)
    }
}


extension HomeVC: UISideMenuNavigationControllerDelegate {
    
    // 侧栏菜单将要显示时触发
    func sideMenuWillAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("菜单将要显示! (是否有动画: \(animated))")
    }
    
    // 侧栏菜单显示完毕时触发
    func sideMenuDidAppear(menu: UISideMenuNavigationController, animated: Bool) {
        print("菜单显示完成! (是否有动画: \(animated))")
    }
    
    // 侧栏菜单将要隐藏时触发
    func sideMenuWillDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("菜单将要隐藏!(是否有动画: \(animated))")
    }
    
    // 侧栏菜单隐藏完毕时触发
    func sideMenuDidDisappear(menu: UISideMenuNavigationController, animated: Bool) {
        print("菜单隐藏完毕!(是否有动画: \(animated))")
    }
}
