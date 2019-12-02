//
//  DiaryEditVC.swift
//  Diary
//
//  Created by 冯才凡 on 2019/7/20.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import RealmSwift


class DiaryEditVC: FCFBaseViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var weekL: UILabel!
    @IBOutlet weak var dayL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var titleTFTopGap: NSLayoutConstraint!
    @IBOutlet weak var detailTV: UITextView!
    @IBOutlet weak var detailTVPlacehold: UILabel!
    
    var diaryItem:WriteItemModel?
    
    init(_ diaryItem:WriteItemModel?=nil){
        super.init(nibName: "DiaryEditVC", bundle: Bundle.main)
        self.diaryItem = diaryItem
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
}

extension DiaryEditVC {
    func initUI() {
        title = "编辑"
        self.detailTV.backgroundColor = .white
        let btn = UIButton(type: .custom)
        btn.setTitle("保存", for: .normal)
        btn.setTitleColor(UIColor.hex(textColor), for: .normal)
        btn.addTarget(self, action: #selector(saveBtnAction), for: .touchUpInside)
        let baritem = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = baritem
        
            self.titleTFTopGap.constant = 10.0
            if self.diaryItem == nil {
                //说明是写
                self.dayL.text = ToolManager.timeOnlyToDStr(ToolManager.currentTimeSecond())
                self.weekL.text = ToolManager.getTodayWeekDay(ToolManager.currentTimeSecond())
                self.timeL.text = ToolManager.timeOnlyToTStr(ToolManager.currentTimeSecond())
            }else{
                //说明是改
                let time:TimeInterval = TimeInterval(self.diaryItem!.time)
                self.dayL.text = ToolManager.timeOnlyToDStr(time)
                self.weekL.text = ToolManager.getTodayWeekDay(time)
                self.timeL.text = ToolManager.timeOnlyToTStr(time)
                self.titleTF.text = self.diaryItem!.name
                self.detailTV.text = self.diaryItem!.content
                self.detailTVPlacehold.isHidden = true
            }
    }
    
    @objc func saveBtnAction() {
        // 缓存
        if (self.titleTF.text != nil && self.titleTF.text!.count > 0) && (self.detailTV.text != nil && self.detailTV.text!.count > 0) {
            //            if self.type == .diary {
            //日记
            if self.diaryItem != nil {
                //修改
                let realm = try! Realm()
                // 先根据时间查找到数据库中的对象，然后进行修改
                if let origin = realm.objects(WriteItemModel.self).filter("time ==  \(self.diaryItem!.time)").first {
                    try! realm.write {
                        origin.name = self.titleTF.text!
                        origin.content = self.detailTV!.text
                    }
                    let alertController = UIAlertController(title: "修改成功!",
                                                            message: nil, preferredStyle: .alert)
                    self.present(alertController, animated: true, completion: nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                        self.presentedViewController?.dismiss(animated: false, completion: nil)
                    }
                }
            }else{
                let itemDiary = WriteItemModel()
                itemDiary.name = self.titleTF.text!
                itemDiary.content = self.detailTV.text!
                itemDiary.time = Int(ToolManager.currentTimeSecond())
                itemDiary.save()
                self.diaryItem = itemDiary
                let alertController = UIAlertController(title: "添加成功!",
                                                        message: nil, preferredStyle: .alert)
                self.present(alertController, animated: true, completion: nil)
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() +  0.5) {
                    self.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
        }else{
            let alertController = UIAlertController(title: "请确保标题和正文完整",
                                                    message: nil, preferredStyle: .alert)
            self.present(alertController, animated: true, completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() +  0.5) {
                self.presentedViewController?.dismiss(animated: false, completion: nil)
            }
        }
    }
}

extension DiaryEditVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.detailTVPlacehold.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if let t = textView.text, t.count > 0{
            self.detailTVPlacehold.isHidden = true
        }else{
            self.detailTVPlacehold.isHidden = false
        }
    }
}
