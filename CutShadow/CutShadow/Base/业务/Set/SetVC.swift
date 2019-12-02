//
//  SetVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/12/2.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class SetVC: FCFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
    }

    func initUI() {
        title = "设置"
        
        let itemBar = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.leftBarButtonItem = itemBar
    }
}
