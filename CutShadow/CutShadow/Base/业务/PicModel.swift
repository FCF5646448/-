//
//  PicModel.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/29.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import RealmSwift

//图片下载到本地，数据库存储路径相关信息，图片名称用时间决定
//地址 = path+name
class PicModel: Object {
    // 图片名称
    @objc dynamic var name:String = ""
    @objc dynamic var path:String = ""
    @objc dynamic var time:TimeInterval = 0 //记录时间
    
    //保存
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    //修改的话，只能修改路径 
    func modify(_ path:String) {
        let realm = try! Realm()
        // 先查找到数据库中的对象，然后进行修改
        if let origin = realm.objects(PicModel.self).filter("time ==  \(self.time)").first {
            try! realm.write {
                origin.path = path
            }
        }
    }

    
    //删除当前对象
    func delete(_ complete:((_ result:Bool)->Void)?) {
        let realm = try! Realm()
        // 先查找到数据库中的对象，然后进行修改
        if let origin = realm.objects(PicModel.self).filter("time ==  \(self.time)").first {
            try! realm.write {
                realm.delete(origin)
            }
            complete?(true)
        }else{
            complete?(false)
        }
    }
    
}
