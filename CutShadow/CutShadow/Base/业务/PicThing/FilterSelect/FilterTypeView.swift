//
//  FilterTypeView.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/25.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

protocol FilterTypeViewDelegate:NSObjectProtocol {
    func filterTypeView(didSelect index:Int)
}

class FilterTypeView: UIView {
    @IBOutlet weak var collectV: UICollectionView!
    let collectItemW = (kScreenWidth - 25) / 4.0
    private var dataSource: [(String, String)] = {
        let arr = [("YuanTu","原图"),
                   ("HuaiJiu","怀旧"),
                   ("DiPian","底片"),
                   ("HeiBai","黑白"),
                   ("FuDiao","浮雕"),
                   ("MengLong","朦胧"),
                   ("KaTong","卡通"),
                   ("TuQi","凸起"),
                   ("ShuiJin","水晶")]
        
        return arr
    }()
    
    var Cframe:CGRect!
    
    weak var delegate:FilterTypeViewDelegate?
    
    //MARK: life cicle
    class func loadView(frame:CGRect)->FilterTypeView {
        guard let v:FilterTypeView = Bundle.main.loadNibNamed("FilterTypeView", owner: self, options: nil)?.first as? FilterTypeView else {
            return FilterTypeView(frame: frame)
        }
        v.Cframe = frame
        v.alpha = 0
        return v
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)
        
        collectV.registerNibWithCell(FilterTypeCell.self)
        
    }
    
    deinit {
        print("FilterTypeView deinit ☠️☠️☠️☠️☠️")
    }
    
    
    //MARK : Action
    func showPop() {
        self.alpha = 0
        self.collectV.reloadData()
        self.frame = self.Cframe
        self.top = kScreenHeight
        UIView.animate(withDuration: 0.35) {
            self.alpha = 1
            self.frame = self.Cframe
        }
    }
    
    @IBAction func closeBtnAction(_ sender: Any) {
        self.alpha = 1
        UIView.animate(withDuration: 0.35) {
            self.top = kScreenHeight
            self.alpha = 0
        }
    }
    
}

//MARK : DelegateFlowLayout
extension FilterTypeView : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectItemW, height: collectItemW + 20)
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

//MARK : DataSource
extension FilterTypeView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:FilterTypeCell = collectionView.dequeueReusableCell(FilterTypeCell.self, indexPath: indexPath) as FilterTypeCell
            
        if  indexPath.row < dataSource.count {
            let item:(String,String) = self.dataSource[indexPath.row]
            cell.typeImg.image = UIImage(named: item.0)
        }
        
        return cell
    }
    
}

//MARK : Delegate
extension FilterTypeView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if  indexPath.row < dataSource.count {
            self.delegate?.filterTypeView(didSelect: indexPath.row)
        }
    }
}

func filterFunc(tag: Int) -> GPUImageFilter {
    
    switch tag {
    case 0:
        return GPUImageNormalBlendFilter()
    case 1:
        return GPUImageSepiaFilter()
    case 2:
        return GPUImageColorInvertFilter()
    case 3:
        return GPUImageDilationFilter()
    case 4:
        return GPUImageEmbossFilter()
    case 5:
        return GPUImageHazeFilter()
    case 6:
        return GPUImageToonFilter()
    case 7:
        return GPUImageBulgeDistortionFilter()
    case 8:
        return GPUImageGlassSphereFilter()
    default:
        return GPUImageGrayscaleFilter()
    }
}
