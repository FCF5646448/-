//
//  PhotoResultVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/26.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

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

}

extension PhotoResultVC {
    func initUI() {
        let takeBtn = UIButton(type: .custom)
        takeBtn.frame = CGRect(x: kScreenWidth * 0.5 - 42, y: kScreenHeight - 104, width: 84, height: 84)
        takeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        takeBtn.setTitle("保存", for: .normal)
        takeBtn.setTitleColor(UIColor.red, for: .normal)
        takeBtn.addTarget(self, action: #selector(savePhotoToAlbum), for: .touchUpInside)
        self.view.addSubview(takeBtn)
        
        let magicBtn = UIButton(type: .custom)
        magicBtn.frame = CGRect(x: takeBtn.right + 80, y: takeBtn.top+10, width: 64, height: 64)
        magicBtn.setTitle("魔术棒", for: .normal)
        magicBtn.setTitleColor(.red, for: .normal)
        magicBtn.addTarget(self, action: #selector(magicBtnAction), for: .touchUpInside)
        self.view.addSubview(magicBtn)
        
        self.view.addSubview(self.filterSelectV)
    }
}

extension PhotoResultVC {
    @objc func savePhotoToAlbum() {
        UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
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
        
        let filter = GPUImageSepiaFilter()
        let img = processImage(filter)
        self.imageV.image = img
        self.img = img
    }
}

