//
//  WriteVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/12/2.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import RealmSwift


class WriteVC: FCFBaseViewController {

    var collectionView:UICollectionView!
        var hasAnimate:Bool = false
        
        var originData:[WriteItemModel] = []
        
        var dataSource:[MonthWriteModel] = []
        
        lazy var addBtn:UIButton = {
            let b = UIButton(type: .custom)
            b.frame = CGRect(x: kScreenWidth - 44 - 15, y: kScreenHeight - kNavBarHeight - 44 - 10 , width: 44, height: 44)
            b.setImage(UIImage(named: "pic_add"), for: .normal)
            b.backgroundColor = UIColor.white
            b.layer.cornerRadius = 22
            b.layer.masksToBounds = true
            b.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
            
            b.layer.shadowColor = UIColor.hex(MainColor).cgColor
            b.layer.shadowOffset = CGSize(width: 0, height: 2)
            b.layer.shadowOpacity = 0.5
            b.layer.shadowRadius = 32
            
            return b
        }()
        
        lazy var hintLabel:UILabel = {
               let lb = UILabel(frame: CGRect(x: 0, y: (HEIGHT-60)/2.0 , width: WIDTH, height: 60))
               lb.text = "抓住每一次悸动,\n记录每一个臆念,\n抓住时间，记录你的流年..."
               lb.numberOfLines = 0
               lb.textAlignment = .center
               lb.font = UIFont.systemFont(ofSize: 14)
               lb.textColor = UIColor.hex(0x8a8a8a)
               return lb
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "随笔"
            initUI()
        }
        
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            searchTallyHistory()
        }
        
    }

    extension WriteVC {
        func initUI() {
            let itemBar = UIBarButtonItem(customView: menuBtn)
            self.navigationItem.leftBarButtonItem = itemBar
            
            let waveView = WaveView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 80))
            view.addSubview(waveView)
            waveView.startWave()
            //添加按钮
            let flow = UICollectionViewFlowLayout()
            flow.minimumLineSpacing = 25
            flow.itemSize = CGSize(width: 125, height: 145)
            flow.headerReferenceSize = CGSize(width: WIDTH, height: 30)
            flow.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
            
            
            let colloect = UICollectionView(frame: CGRect(x: 0, y: 0, width: WIDTH, height: kScreenHeight-kNavBarHeight), collectionViewLayout: flow)
            colloect.backgroundColor = UIColor.white.withAlphaComponent(0)
            colloect.contentInset = UIEdgeInsets(top: 5, left: 40, bottom: 5, right: 40)
            colloect.delegate = self
            colloect.dataSource = self
            colloect.registerNibWithCell(WriteItemCell.self)
            colloect.register(UICollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HomeItemHeader")
            
            self.collectionView = colloect
            if #available(iOS 11, *) {
                colloect.contentInsetAdjustmentBehavior = .never
            }else{
                automaticallyAdjustsScrollViewInsets = false
            }
            
            view.addSubview(colloect)
            view.addSubview(self.addBtn)
            view.addSubview(self.hintLabel)
            
        }

        
    //    从数据库获取数据
        func searchTallyHistory() {
            self.dataSource.removeAll()
            self.originData.removeAll()
            // 获取所有的记录
            let realm = try! Realm()
            let allRecord:Results<WriteItemModel> = realm.objects(WriteItemModel.self)
            if allRecord.count > 0 {
                for item in allRecord {
                    self.originData.append(item)
                }
            }
            // 按时间排序
            self.originData.sort { (elem0, emem1) -> Bool in
                return elem0.time > emem1.time
            }

            // 有哪些月份、日期
            var monthList:[String] = []
            for item in self.originData {
                let m = ToolManager.timeToMStr(TimeInterval(item.time))
                if !monthList.contains(m) {
                    monthList.append(m)
                }
            }

            for m in monthList {
                let mItem = MonthWriteModel()
                mItem.monthStr = m
                var tempM = [WriteItemModel]()
                for dItem in self.originData {
                    let dstr = ToolManager.timeToDStr(TimeInterval(dItem.time))
                    if dstr.contains(m) {
                        tempM.append(dItem)
                    }
                }
                mItem.list = tempM
                self.dataSource.append(mItem)
            }

            if self.dataSource.count > 0 {
                self.hintLabel.isHidden = true
            }else{
                self.hintLabel.isHidden = false
            }

            collectionView.reloadData()
        }
        
    }

    extension WriteVC {
        @objc func addBtnAction() {
            let vc = DiaryEditVC()
            vc.hidesBottomBarWhenPushed = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }


    extension WriteVC {
        
        
    }

    extension WriteVC: UICollectionViewDelegate, UICollectionViewDataSource {
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return self.dataSource.count
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            let m = self.dataSource[section]
            return m.list.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:WriteItemCell = collectionView.dequeueReusableCell(WriteItemCell.self, indexPath: indexPath)
            if indexPath.section < self.dataSource.count {
                let m = self.dataSource[indexPath.section]
                if indexPath.item < m.list.count {
                    let d = m.list[indexPath.item]
                    cell.detailL.text = d.content
                    cell.titleL.text = d.name
                    cell.timeL.text = ToolManager.timeToDStr(TimeInterval(d.time))
                }
            }
            return cell
        }
        
        
        func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            if kind == UICollectionView.elementKindSectionHeader {
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HomeItemHeader", for: indexPath)
                var tempL:UILabel!
                if let lb:UILabel = header.viewWithTag(10) as? UILabel {
                    tempL = lb
                }else{
                    let lb = UILabel(frame: CGRect(x: 0, y: 0, width: WIDTH, height: 30))
                    lb.text = ""
                    lb.font = UIFont.systemFont(ofSize: 12)
                    lb.textColor = UIColor.hex("8a8a8a")
                    lb.tag = 10
                    header.addSubview(lb)
                    tempL = lb
                }
                let m = self.dataSource[indexPath.section]
                tempL.text = m.monthStr
                return header
            }
            return UICollectionReusableView()
        }
        
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if indexPath.section < self.dataSource.count {
                let m = self.dataSource[indexPath.section]
                if indexPath.item < m.list.count {
                    let d = m.list[indexPath.item]
                    let vc = DiaryEditVC(d)
                    vc.hidesBottomBarWhenPushed = true
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }

