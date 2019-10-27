//
//  PhotoManager.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/9/21.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import Photos

//相簿列表项
struct FCFAlbumItem {
    //相簿名称
    var title:String?
    //相簿内的资源
    var fetchResult:PHFetchResult<PHAsset>
}

/*用于操作相册资源*/
class PhotoManager: NSObject {
    static var share:PhotoManager = PhotoManager()
    private override init() {
        super.init()
    }
    
    //相簿列表项集合
    var albumItems:[FCFAlbumItem] = []
    
    
}

// 这里只负责 获取相册及资源 (PHAsset) , 但是真正要获取图像需要PHImageManager
extension PhotoManager {
    func requestAuthon(_ complete:((_ item:[FCFAlbumItem])->Void)?) {
        PHPhotoLibrary.requestAuthorization { (status) in
            //列出所有系统的智能相册
            let smartOptions = PHFetchOptions()
            let smartAlbums = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .albumRegular, options: smartOptions)
            
            self.convertCollection(collection: smartAlbums)
            
            //列出所有用户创建的相册
            let userCollections = PHCollectionList.fetchTopLevelUserCollections(with: nil)
            self.convertCollection(collection: userCollections
                as! PHFetchResult<PHAssetCollection>)
            
            //相册按包含的照片数量排序（降序）
            self.albumItems.sort { (item1, item2) -> Bool in
                return item1.fetchResult.count > item2.fetchResult.count
            }
            
            
            
        }
    }
    
    //转化处理获取到的相簿
    fileprivate func convertCollection(collection:PHFetchResult<PHAssetCollection>){
        for i in 0..<collection.count{
            //获取出但前相簿内的图片
            let resultsOptions = PHFetchOptions()
            resultsOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate",
                                                               ascending: false)]
            resultsOptions.predicate = NSPredicate(format: "mediaType = %d",
                                                   PHAssetMediaType.image.rawValue)
            let c = collection[i]
            let assetsFetchResult = PHAsset.fetchAssets(in: c , options: resultsOptions)
            //没有图片的空相簿不显示
            if assetsFetchResult.count > 0 {
                let title = self.titleOfAlbumForChinse(title: c.localizedTitle)
                albumItems.append(FCFAlbumItem(title: title,
                                          fetchResult: assetsFetchResult))
            }
        }
    }
    
    //由于系统返回的相册集名称为英文，我们需要转换为中文
    private func titleOfAlbumForChinse(title:String?) -> String? {
        if title == "Slo-mo" {
            return "慢动作"
        } else if title == "Recently Added" {
            return "最近添加"
        } else if title == "Favorites" {
            return "个人收藏"
        } else if title == "Recently Deleted" {
            return "最近删除"
        } else if title == "Videos" {
            return "视频"
        } else if title == "All Photos" {
            return "所有照片"
        } else if title == "Selfies" {
            return "自拍"
        } else if title == "Screenshots" {
            return "屏幕快照"
        } else if title == "Camera Roll" {
            return "相机胶卷"
        }
        return title
    }
}

// 获取图片相关
extension PhotoManager {
    
}


