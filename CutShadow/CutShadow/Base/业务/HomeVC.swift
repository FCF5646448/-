//
//  HomeVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/7/27.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import SideMenu
import RealmSwift

class HomeVC: FCFBaseViewController {

    lazy var collection:UICollectionView = {
            let flowLayout = FCFMasonryViewLayout()
            flowLayout.delegate = self
        
            //flowLayout 一定要放在初始化方法中，否则会报错。
            let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight), collectionViewLayout: flowLayout)
            collectionview.backgroundColor = UIColor.white
            collectionview.register(UINib.init(nibName: "MKPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MKPhotoCollectionCell")
            collectionview.delegate = self
            collectionview.dataSource = self
            
            return collectionview
    }()
    
    lazy var hintLabel:UILabel = {
           let lb = UILabel(frame: CGRect(x: 0, y: (HEIGHT-60)/2.0 , width: WIDTH, height: 60))
           lb.text = "当前没有任何记录哦\n养成好的记账习惯很重要哦😁"
           lb.numberOfLines = 0
           lb.textAlignment = .center
           lb.font = UIFont.systemFont(ofSize: 14)
           lb.textColor = UIColor.hex(0x8a8a8a)
           return lb
       }()
    
    var photoList:[PicModel] = []
    var photosCaches:[String:UIImage] = [:] //缓存渲染出来的图片
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchData()
    }

}

extension HomeVC {
    func initUI(){
        
        title = "首页"
        
        settingMenu()
        
        self.view.addSubview(self.collection)
        
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
