//
//  HomeVC+CollectV.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/29.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import Foundation
import RealmSwift

//
extension HomeVC {
    func searchData() {
        self.photoList.removeAll()
        
        // 获取所有的记录
        let realm = try! Realm()
        let allRecord:Results<PicModel> = realm.objects(PicModel.self)
        if allRecord.count > 0 {
            for item in allRecord {
                print(item.name)
                self.photoList.append(item)
            }
        }
        
        
        if self.photoList.count > 0 {
            self.hintLabel.isHidden = true
        }else{
            self.hintLabel.isHidden = false
        }
        
        collection.reloadData()
    }
}

extension HomeVC:UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension HomeVC:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:MKPhotoCollectionCell = collection.dequeueReusableCell(withReuseIdentifier: "MKPhotoCollectionCell", for: indexPath) as! MKPhotoCollectionCell
        
        let photo = self.photoList[indexPath.row]
        
        if let thumbImg = self.photosCaches[photo.name] {
            cell.imgview.image = thumbImg
        }else{
            //优化，将加载image的IO操作放到后台线程里
            if let img = DownloadTool.share.loadImageFromDiskWith(imgName: photo.name) {
                self.photosCaches[photo.name] = img
                cell.imgview.image = img
            }
        }
        
        return cell
    }
}

extension HomeVC:FCFMasonryViewLayoutDelegate {
    func collectionView(collection:UICollectionView,layout:FCFMasonryViewLayout,heightForItemAtIndexPath:IndexPath)->CGFloat {
        let randomH:CGFloat = CGFloat(100 + arc4random()%140)
        return randomH
    }
}
