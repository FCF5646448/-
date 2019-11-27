//
//  PhotoResultVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/26.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import Photos
import SnapKit

class PhotoResultVC: FCFBaseViewController {

    @IBOutlet weak var imageV: UIImageView!
    
    var img:UIImage!
    
    var filter:GPUImageFilter = GPUImageFilter()
    
    lazy var filterSelectV:FilterTypeView = {
        let fv = FilterTypeView.loadView(frame: CGRect(x: 0, y: kScreenHeight - 150, width: kScreenWidth, height: 150))
        fv.delegate = self
        return fv
    }()
    
    // 直接将选中的图片或者拍摄好的图片传进来
    init(frame:CGRect,img:UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.img = img
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.imageV.image = img
    }

    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension PhotoResultVC {
    func initUI() {
        //
        let close = UIButton(type: .custom)
        close.frame = CGRect(x: 20, y: 10, width: 64, height: 64)
        close.setTitle(" X ", for: .normal)
        close.setTitleColor(UIColor.red, for: .normal)
        close.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.view.addSubview(close)
        
        let download = UIButton(type: .custom)
        download.frame = CGRect(x: kScreenWidth - 20 - 64, y: 10, width: 64, height: 64)
        download.setTitle("下载", for: .normal)
        download.setTitleColor(UIColor.red, for: .normal)
        download.addTarget(self, action: #selector(downloadAction), for: .touchUpInside)
        self.view.addSubview(download)
        
        let saveBtn = UIButton(type: .custom)
        saveBtn.frame = CGRect(x: kScreenWidth * 0.5 - 42, y: kScreenHeight - 104, width: 84, height: 84)
        saveBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.setTitleColor(UIColor.red, for: .normal)
        saveBtn.addTarget(self, action: #selector(savePhotoLocal), for: .touchUpInside)
        self.view.addSubview(saveBtn)
        
        let backBtn = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 20, y: saveBtn.top+10, width: 64, height: 64)
        backBtn.setTitle("返回", for: .normal)
        backBtn.setTitleColor(.red, for: .normal)
        backBtn.addTarget(self, action: #selector(backBtnAction), for: .touchUpInside)
        self.view.addSubview(backBtn)
        
        let magicBtn = UIButton(type: .custom)
        magicBtn.frame = CGRect(x: saveBtn.right + 80, y: saveBtn.top+10, width: 64, height: 64)
        magicBtn.setTitle("魔术棒", for: .normal)
        magicBtn.setTitleColor(.red, for: .normal)
        magicBtn.addTarget(self, action: #selector(magicBtnAction), for: .touchUpInside)
        self.view.addSubview(magicBtn)
        
        let addTextBtn = UIButton(type: .custom)
        addTextBtn.setTitle("添加说明", for: .normal)
        addTextBtn.addTarget(self, action: #selector(addTextBtnAction), for: .touchUpInside)
        self.view.addSubview(addTextBtn)
        addTextBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.view)
            make.height.equalTo(64)
            make.width.equalTo(32)
            make.right.equalTo(self.view.right).offset(-20)
        }
        
        self.view.addSubview(self.filterSelectV)
    }
}

extension PhotoResultVC {
    @objc func closeAction() {
        //返回到选择相片页
        var rootVC = self.presentingViewController
        while !rootVC!.isKind(of: CSSelectPicVC.classForCoder()) {
            let parent = rootVC?.presentingViewController
            rootVC = parent
        }
        rootVC?.dismiss(animated: true, completion: nil)
    }
    
    @objc func downloadAction() {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: self.img)
        }) { (isSuccess: Bool, error: Error?) in
            if isSuccess {
                print("下载到系统相册成功!")
            } else{
                print("下载到系统相册失败：", error!.localizedDescription)
            }
        }
    }
    
    @objc func backBtnAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //保存图片到app
    @objc func savePhotoLocal() {
        //
        
    }
    
    @objc func addTextBtnAction() {
        
    }
    

    @objc func magicBtnAction(_ sender: UIButton) {
        self.filterSelectV.showPop()
    }
    
    private func processImage(_ filter : GPUImageFilter) -> UIImage? {
        // 创建处理图片的GPUImagePicture
        let picProcess = GPUImagePicture(image: self.img)
        
        // 添加需要处理的滤镜
        picProcess?.addTarget(filter)
        
        // 处理图片
        filter.useNextFrameForImageCapture()
        picProcess?.processImage()
        
        // 取出最新的图片
        return filter.imageFromCurrentFramebuffer()
    }
}


//MARK: FliterDelegate
extension PhotoResultVC : FilterTypeViewDelegate {
    func filterTypeView(didSelect fliter:GPUImageFilter) {
//        let filter = GPUImageSepiaFilter()
        let img = processImage(filter)
        self.imageV.image = img
        self.img = img
    }
}

