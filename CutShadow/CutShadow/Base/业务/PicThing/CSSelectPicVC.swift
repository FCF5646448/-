//
//  CSSelectPicVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/9/19.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import Photos
import ToastSwiftFramework

/*选取图片页、摄像和拍照入口*/
class CSSelectPicVC: FCFBaseViewController {

    @IBOutlet weak var collect: UICollectionView!
    
    var dataSource:PHFetchResult<PHAsset>?
    
    var imgManager = PHCachingImageManager()
    
    let collectItemW:CGFloat = (kScreenWidth - 20) / 3.0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
}

extension CSSelectPicVC {
    func initUI() {
        title = "照片"
        
        collect.registerNibWithCell(CSSelectPicCell.self)
        collect.registerNibForSectionHead(CSSelectPicHeadView.self)
        
        
        weak var weakself = self
        PhotoManager.share.requestAuthon { (result, albums) in
            DispatchQueue.main.async {
                if result {
                    if let currentAlbum = albums.first {
                        weakself?.title = currentAlbum.title
                        self.dataSource = currentAlbum.fetchResult
                        self.collect.reloadData()
                    }
                }else{
                    weakself?.customReturnBtnClicked()
                }
            }
        }
    }
    
    //重置缓存
    func resetCachedAssets() {
        self.imgManager.stopCachingImagesForAllAssets()
    }
    
    
    
    
}


extension CSSelectPicVC : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectItemW, height: collectItemW)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: kScreenWidth, height: 64)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //上下缝隙
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //item之间缝隙
        return 5.0
    }
}

extension CSSelectPicVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CSSelectPicCell = collectionView.dequeueReusableCell(CSSelectPicCell.self, indexPath: indexPath) as CSSelectPicCell
        
        if let assets = self.dataSource, indexPath.row < assets.count {
            let asset = assets[indexPath.row]
            
            let scale = UIScreen.main.scale
            let assetGridThumbnailSize = CGSize(width: cell.img.width*scale ,
                                            height: cell.img.height*scale)
            
            self.imgManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: .default, options: nil) { (img, info) in
                if let image = img, let value = info?[PHImageResultIsDegradedKey] as? Int, value == 0 {
                    cell.img.image = image
                }
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header:CSSelectPicHeadView = collectionView.dequeueReusableSectionHead(CSSelectPicHeadView.self, indexPath: indexPath)
            header.delegate = self

            return header
        }
        return UICollectionReusableView()
    }
    
}

extension CSSelectPicVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell:CSSelectPicCell = collectionView.cellForItem(at: indexPath) as? CSSelectPicCell,let img = cell.img.image {
            let vc = PhotoResultVC(frame: self.view.frame, img: img)
            vc.modalPresentationStyle = .fullScreen
            self.navigationController?.present(vc, animated: false) {
                
            }
        }
    }
    
}


extension CSSelectPicVC : CSSelectPicHeadViewDelegate {
    func csselectPicHeadAction(type:SelectActionType) {
        switch type {
        case .takePhoto:
            
            let vc = TakePhotoVC()
            vc.modalPresentationStyle = .fullScreen
            self.view.makeToastActivity(.center)
            weak var weakself = self
            self.navigationController?.present(vc, animated: true, completion: {
                weakself?.view.hideToastActivity()
            })
            break
        case .takeVideo:
            
            break
        }
    }
}


