//
//  WriteModel.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/12/2.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import Foundation
import RealmSwift

//日记基础类
class WriteItemModel: Object {
    @objc dynamic var name:String = "" //标题
    @objc dynamic var content:String = "" //正文
    @objc dynamic var time:Int = 0 //时间
    
    func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }

    //修改的话，只能修改正文
    func modify(_ detail:String) {
        let realm = try! Realm()
        // 先根据时间查找到数据库中的对象，然后进行修改
        if let origin = realm.objects(WriteItemModel.self).filter("time ==  \(self.time)").first {
            try! realm.write {
                origin.content = detail
            }
        }
    }

    //删除当前对象
    func delete(_ complete:((_ result:Bool)->Void)?) {
        let realm = try! Realm()
        // 先查找到数据库中的对象，然后进行修改
        if let origin = realm.objects(WriteItemModel.self).filter("time ==  \(self.time)").first {
            try! realm.write {
                realm.delete(origin)
            }
            complete?(true)
        }else{
            complete?(false)
        }
    }
}

// 一个月的记录
class MonthWriteModel {
    var monthStr:String = ""
    var list:[WriteItemModel] = [] //每一天的记录
}
