//
//  TableView+CollectionView+Extension.swift
//  FCFCommonTools
//
//  Created by 冯才凡 on 2017/4/6.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit

protocol CustomReusableView:class {}

extension CustomReusableView where Self:UIView {
    static var registerIdentifier:String{
        return String(describing: self)
    }
}


extension UITableViewCell: CustomReusableView{}
extension UITableViewHeaderFooterView: CustomReusableView{}

//UITableView 简化xib注册cell和获取复用队列的cell的方法
extension UITableView{
    //
    func registerNibWithCell<T:UITableViewCell>(_ cell:T.Type){
        register(UINib(nibName: cell.registerIdentifier, bundle: nil), forCellReuseIdentifier: cell.registerIdentifier)
    }
    
    func regidterClassWithCell<T:UITableViewCell>(_ cell:T.Type){
        register(cell, forCellReuseIdentifier: cell.registerIdentifier)
    }
    
    func dequeueReusableCell<T:UITableViewCell>(_ cell:T.Type)->T{
        return dequeueReusableCell(withIdentifier: cell.registerIdentifier) as! T
    }
    
    func dequeueReusableCell<T:UITableViewCell>(_ cell:T.Type,for indexPath:IndexPath)->T{
        return dequeueReusableCell(withIdentifier: cell.registerIdentifier, for: indexPath) as! T
    }
    
    func registerNibWithHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type){
        register(UINib(nibName: headerFooterView.registerIdentifier, bundle: nil), forHeaderFooterViewReuseIdentifier: headerFooterView.registerIdentifier)
    }
    
    func registerClassWithHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type){
        register(headerFooterView, forHeaderFooterViewReuseIdentifier: headerFooterView.registerIdentifier)
    }
    
    func dequeueHeaderFooterView<T:UITableViewHeaderFooterView>(_ headerFooterView:T.Type)->T{
        return dequeueReusableHeaderFooterView(withIdentifier: headerFooterView.registerIdentifier) as! T
    }
    
}

//UICollectionView 简化xib注册cell和获取复用队列的cell的方法
extension UICollectionViewCell: CustomReusableView{}
extension UICollectionReusableView: CustomReusableView{}
extension UICollectionView{
    
    func registerNibWithCell<T:UICollectionViewCell>(_ cell:T.Type){
        register(UINib(nibName: cell.registerIdentifier, bundle: nil), forCellWithReuseIdentifier: cell.registerIdentifier)
    }
    
    func registerClassWithCell<T: UICollectionViewCell>(_ cell: T.Type) {
        register(cell, forCellWithReuseIdentifier: cell.registerIdentifier)
    }
    
    func dequeueReusableCell<T:UICollectionViewCell>(_ cell:T.Type,indexPath:IndexPath)->T{
        return dequeueReusableCell(withReuseIdentifier: cell.registerIdentifier, for: indexPath) as! T
    }
    
    func registerNibForSectionHead<T:UICollectionReusableView>(_ head:T.Type) {
        register(UINib(nibName: head.registerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:  head.registerIdentifier)
    }
    
    func registerNibForSectionFooter<T:UICollectionReusableView>(_ footer:T.Type) {
        register(UINib(nibName: footer.registerIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier:  footer.registerIdentifier)
    }
    
    func dequeueReusableSectionHead<T:UICollectionReusableView>(_ head:T.Type,indexPath:IndexPath)->T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: head.registerIdentifier, for: indexPath) as! T
    }
    
    func dequeueReusableSectionFooter<T:UICollectionReusableView>(_ footer:T.Type,indexPath:IndexPath)->T {
        return dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footer.registerIdentifier, for: indexPath) as! T
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
