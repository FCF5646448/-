//
//  CSTabBarController.swift
//  CartoonShow
//
//  Created by 冯才凡 on 2019/6/14.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class FCFTabBarController: UITabBarController {
    lazy var homeNavi:FCFNavigationController = {
        let n = FCFNavigationController(rootViewController: HomeVC())
        n.setTabBar("write", "write_sel", UIColor.hex("8a8a8a"), UIColor.hex(MainColor),title:"剪影")
        return n
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initFrame()
    }
    
    func initFrame() {
        self.addChild(self.homeNavi)
        
    }
}
