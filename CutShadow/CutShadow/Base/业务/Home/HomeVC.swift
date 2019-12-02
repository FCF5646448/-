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
            let collectionview = UICollectionView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight-kNavBarHeight), collectionViewLayout: flowLayout)
            collectionview.backgroundColor = UIColor.white
            collectionview.register(UINib.init(nibName: "MKPhotoCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MKPhotoCollectionCell")
            collectionview.delegate = self
            collectionview.dataSource = self
            
            return collectionview
    }()
    
    lazy var hintV:UIView = {
        let imgW:CGFloat = 280
        let hintH:CGFloat = 80
        let v = UIView(frame: CGRect(x: (WIDTH - imgW)/2.0, y: (HEIGHT - kTabBarHeight - kNavBarHeight - imgW - 80 - 10)/2.0 + 40, width: imgW, height: (imgW + 80 + 10)))
        
        let imgv = UIImageView(frame: CGRect(x: 0 , y: 0 , width: imgW, height: imgW))
        imgv.image = UIImage(named: "02")
        imgv.contentMode = UIView.ContentMode.scaleAspectFill
        imgv.layer.cornerRadius = imgW/2.0
        imgv.layer.masksToBounds = true
        v.addSubview(imgv)
        
        let hint = UILabel(frame: CGRect(x: 0, y: imgv.bottom + 10, width: imgW, height: hintH))
        hint.numberOfLines = 0
        hint.text = "用相机记录你的容颜.\n用心定格你的时间.\n开启行动吧.."
        hint.font = UIFont(name: "DINAlternate-Bold", size: 14)
        hint.textAlignment = .center
        hint.textColor = UIColor.hex(0x8a8a8a)
        v.addSubview(hint)
        
        return v
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
        
        title = "剪影"
        
        let itemBar = UIBarButtonItem(customView: menuBtn)
        self.navigationItem.leftBarButtonItem = itemBar
        
        
        self.view.addSubview(self.collection)
        
        let addBtn = UIButton(type: .custom)
        addBtn.setImage(UIImage(named: "pic_add"), for: .normal)
        addBtn.frame = CGRect(x: kScreenWidth - 44 - 15, y: kScreenHeight - kNavBarHeight - 44 - 10  , width: 44, height: 44)
        addBtn.backgroundColor = UIColor.white
        addBtn.layer.cornerRadius = 22
        addBtn.layer.masksToBounds = true
        //TODO 添加阴影
        
        view.addSubview(self.hintV)
        
        addBtn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        view.addSubview(addBtn)
    }
}

extension HomeVC {
    @objc func addBtnAction() {
        navigationController?.pushViewController(CSSelectPicVC(), animated: true)
    }
}
