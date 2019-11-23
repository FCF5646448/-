//
//  CSSelectPicVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/9/19.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

/*选取图片页*/
class CSSelectPicVC: FCFBaseViewController {

    @IBOutlet weak var collect: UICollectionView!
    
    let collectItemW:CGFloat = (kScreenWidth - 40) / 3.0
    
    var dataSource:[String] = ["","","","","","","","","",""]
    
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
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //上下缝隙
        return 10.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        //item之间缝隙
        return 10.0
    }
}

extension CSSelectPicVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CSSelectPicCell = collectionView.dequeueReusableCell(CSSelectPicCell.self, indexPath: indexPath) as CSSelectPicCell
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            
            let header:CSSelectPicHeadView = collectionView.dequeueReusableSectionHead(CSSelectPicHeadView.self, indexPath: indexPath)
            
//            if let m = self.model, indexPath.section < m.pageChoiceTree.count  {
//                let tree = m.pageChoiceTree[indexPath.section]
//                if let imgStr = tree.icon {
//                    header.img.sd_setImage(with: URL(string: imgStr), placeholderImage: UIImage(named: "loginIcon"))
//                }
//                header.nameL.text = tree.name
//            }
            return header
        }
        return UICollectionReusableView()
    }
    
}

extension CSSelectPicVC : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let origin = self.dataSource[sourceIndexPath.row]
        self.dataSource.remove(at: sourceIndexPath.row)
        self.dataSource.insert(origin, at: destinationIndexPath.row)
    }
}


