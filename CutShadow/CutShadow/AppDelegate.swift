//
//  AppDelegate.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/7/27.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    lazy var homeNavi:FCFNavigationController = {
        let n = FCFNavigationController(rootViewController: HomeVC())
        n.setTabBar("write", "write_sel", UIColor.hex("8a8a8a"), UIColor.hex(MainColor),title:"剪影")
        return n
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configDataBase()
        window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        window?.backgroundColor = UIColor.white
        window?.makeKeyAndVisible()
        
        window?.rootViewController = self.homeNavi
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

extension AppDelegate {
    // 配置基本数据库
    func configDataBase() {
        //配置数据库
        var config = Realm.Configuration.init()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("CutShadow.realm")
        Realm.Configuration.defaultConfiguration = config
    }
}
