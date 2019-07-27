//
//  CSBaseViewController.swift
//  CartoonShow
//
//  Created by 冯才凡 on 2019/6/14.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class FCFBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = UIRectEdge()
        
    }
    
    //
    func customReturnBtn(_ title:String = "返回",_ img:String = "btn_last_38") {
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        leftBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        leftBtn.imageView?.contentMode = .scaleAspectFit
        
        leftBtn.setTitle(title, for: .normal)
        leftBtn.setImage(UIImage(named: "btn_last_38"), for: .normal)
        leftBtn.addTarget(self, action: #selector(customReturnBtnClicked), for: .touchUpInside)
        let leftBtnItem = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = leftBtnItem
    }
    
    @objc func customReturnBtnClicked(){
        
    }

}
