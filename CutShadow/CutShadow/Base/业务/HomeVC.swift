//
//  HomeVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/7/27.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import SideMenu

class HomeVC: FCFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }

}

extension HomeVC {
    func initUI(){
        
        settingMenu()
        
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "pic_add"), for: .normal)
        addBtn.frame = CGRect(x: kScreenWidth - 44 - 15, y: kScreenHeight - kNavBarHeight - kTabBarHeight , width: 44, height: 44)
        addBtn.backgroundColor = UIColor.white
        addBtn.layer.cornerRadius = 22
        addBtn.layer.masksToBounds = true
        //TODO 添加阴影
        
        
        addBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        view.addSubview(addBtn)
        
    }
}

extension HomeVC {
    @objc func addBtnAction() {
        navigationController?.pushViewController(CSSelectPicVC(), animated: true)
    }
}
