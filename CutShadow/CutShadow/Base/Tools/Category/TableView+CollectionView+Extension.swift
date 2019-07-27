//
//  TableView+CollectionView+Extension.swift
//  FCFCommonTools
//
//  Created by 冯才凡 on 2017/4/6.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableView:class {}

extension ReusableView where Self:UIView{
    static var reuseIdentifier:String{
        return String(describing: self)
    }
}


extension UITableViewCell:ReusableView{}
extension UICollectionViewCell:ReusableView{}

protocol NibLoadableView:class {}
extension NibLoadableView where Self:UIView{
    static var NibName:String{
        return String(describing: self)
    }
}
extension UITableViewCell:NibLoadableView{}
extension UICollectionViewCell:NibLoadableView{}

//UITableView 简化xib注册cell和获取复用队列的cell的方法
extension UITableView{
    //
    func registerNibWithCell<T:UITableViewCell>(_ cell:T.Type){
        register(UINib(nibName: String(describing:cell), bundle: nil), forCellReuseIdentifier: String(describing:cell))
    }
    
    func regidterClassWithCell<T:UITableViewCell>(_ cell:T.Type){
        register(cell, forCellReuseIdentifier: String(describing:cell))
    }
    
    func dequeueReusableCell<T:UITableViewCell>(_ cell:T.Type)->T{
        return dequeueReusableCell(withIdentifier: String(describing:cell)) as! T
    }
    
    func dequeueReusableCell<T:UITableViewCell>(_ cell:T.Type,for indexPath:IndexPath)->T{
        return dequeueReusableCell(withIdentifier: String(describing:cell), for: indexPath) as! T
    }
    
    func registerNibWithHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type){
        register(UINib(nibName: String(describing:headerFooterView), bundle: nil), forHeaderFooterViewReuseIdentifier: String(describing:headerFooterView))
    }
    
    func registerClassWithHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type){
        register(headerFooterView, forHeaderFooterViewReuseIdentifier: String(describing:headerFooterView))
    }
    
    func dequeueHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type)->T{
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing:headerFooterView)) as! T
    }
    
}

//UICollectionView 简化xib注册cell和获取复用队列的cell的方法
extension UICollectionView{
    
    func registerNibWithCell<T:UICollectionViewCell>(_ cell:T.Type){
        register(UINib(nibName: String(describing:cell), bundle: nil), forCellWithReuseIdentifier: String(describing:cell))
    }
    
    func registerClassWithCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: String(describing: cell))
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(_ cell:T.Type,indexPath:IndexPath)->T{
        return dequeueReusableCell(withReuseIdentifier: String(describing:cell), for: indexPath) as! T
    }
    
    
}


extension UITableView {
    var hintLabel:UILabel {
        let lb = UILabel.init(frame: CGRect(x: 0, y: self.frame.size.height-21, width: kScreenWidth, height: 21))
        lb.textAlignment = .center
        return lb
    }
    
    func bottomHintViewShow(_ hint:String="没有更多内容咯"){

    }
}
