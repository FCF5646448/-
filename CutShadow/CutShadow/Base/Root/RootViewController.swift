//
//  RootViewController.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/12/2.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

enum TabType {
    case Home
    case Write
    case Set
}


class RootViewController: FCFBaseViewController {
    lazy var home:FCFBaseViewController = HomeVC()
    
    lazy var write:FCFBaseViewController = WriteVC()
    
    lazy var set:FCFBaseViewController = SetVC()
    
    
    var currentType:TabType = .Home {
        didSet{
            self.navigationController?.popToRootViewController(animated: false)
            switch self.currentType {
            case .Home:
                self.navigationController?.pushViewController(self.home, animated: false)
            case .Write:
                self.navigationController?.pushViewController(self.write, animated: false)
            case .Set:
                self.navigationController?.pushViewController(self.set, animated: false)
            }
        }
    }

   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingMenu()
        
        self.currentType = .Home
    }
    
    func changeRoot() {
        
    }
    
}
