//
//  TakePhotoVC.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/24.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit
import UIKit
import Photos
//import GPUImage

// 拍摄 照片
class TakePhotoVC: FCFBaseViewController {
    
    //MARK: property
    var isPause:Bool = false
    
    lazy var filterSelectV:FilterTypeView = {
        let fv = FilterTypeView.loadView(frame: CGRect(x: 0, y: kScreenHeight - 150, width: kScreenWidth, height: 150))
        fv.delegate = self
        return fv
    }()
    
    var filter:GPUImageFilter = GPUImageFilter()
    //高清前置摄像头
    fileprivate lazy var camera : GPUImageStillCamera = {
        let cm:GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        cm.outputImageOrientation = .portrait
        cm.horizontallyMirrorFrontFacingCamera = true
        return cm
    }()

    
    
    
    
    //MARK: live cicle
    override func loadView() {
        let imgView = GPUImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imgView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        imgView.fillMode = .preserveAspectRatioAndFill
        self.view = imgView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        beginCapture()
    }
    
    deinit {
        print("TakePhotoVC deinit ☠️☠️☠️☠️☠️")
    }
    
    func beginCapture() {
        self.camera.addTarget(self.filter)
        self.filter.addTarget((self.view as! GPUImageInput))
        
        //TODO :   这句是导致相机打开会卡顿的主要原因,后续需要优化
        self.camera.startCapture()
    }
}

//MARK: UI
extension TakePhotoVC {
    func initUI() {
        
        //
        let close = UIButton(type: .custom)
        close.frame = CGRect(x: 20, y: 20, width: 64, height: 64)
        close.setTitle(" X ", for: .normal)
        close.setTitleColor(UIColor.red, for: .normal)
        close.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        self.view.addSubview(close)
        
        //
        let cameraBtn = UIButton(type: .custom)
        cameraBtn.frame = CGRect(x: kScreenWidth - 64 - 20, y: 200, width: 64, height: 64)
        cameraBtn.setTitle("镜头", for: .normal)
        cameraBtn.setTitleColor(UIColor.red, for: .normal)
        cameraBtn.addTarget(self, action: #selector(switchCameraAction), for: .touchUpInside)
        self.view.addSubview(cameraBtn)
        
        //比例
        let scaleBtn = UIButton(type: .custom)
        scaleBtn.frame = CGRect(x: cameraBtn.left, y: cameraBtn.bottom + 20, width: 64, height: 64)
        scaleBtn.setTitle("16:9", for: .normal)
        scaleBtn.setTitleColor(UIColor.red, for: .normal)
        scaleBtn.addTarget(self, action: #selector(switchScaleAction), for: .touchUpInside)
        self.view.addSubview(scaleBtn)
        
        
        
        let takeBtn = UIButton(type: .custom)
        takeBtn.frame = CGRect(x: kScreenWidth * 0.5 - 42, y: kScreenHeight - 104, width: 84, height: 84)
        takeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        takeBtn.setTitle("拍照", for: .normal)
        takeBtn.setTitleColor(UIColor.red, for: .normal)
        takeBtn.addTarget(self, action: #selector(takePhotoAction), for: .touchUpInside)
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

//MARK: Action
extension TakePhotoVC {
    @objc func closeAction() {
        self.camera.stopCapture()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func switchCameraAction() {
        self.camera.rotateCamera()
    }
    
    @objc func switchScaleAction() {
        
    }
    
    @objc func takePhotoAction(_ sender: UIButton) {
        guard isPause else {
            weak var weakself = self
            self.camera.capturePhotoAsJPEGProcessedUp(toFilter: self.filter) { (image, error) in
                weakself?.camera.pauseCapture()
                weakself?.isPause = true
                if let imgData:Data = image, let img = UIImage(data: imgData) {
                    
                    let vc = PhotoResultVC(frame: self.view.frame, img: img)
                    self.view.addSubview(vc.view)
                    self.addChild(vc)
                    //
//                    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                }
            }
            return
        }
        
        self.camera.resumeCameraCapture()
        isPause = false
    }
    
    @objc func magicBtnAction(_ sender: UIButton) {
        self.filterSelectV.showPop()
    }
}


//MARK: FliterDelegate
extension TakePhotoVC : FilterTypeViewDelegate {
    func filterTypeView(didSelect fliter:GPUImageFilter) {
        if fliter.isKind(of: GPUImageNormalBlendFilter.classForCoder()) {
            camera.removeAllTargets()
            //不要滤镜
            camera.addTarget((self.view as! GPUImageInput))
            
        }else {
            self.filter = fliter
            camera.removeAllTargets()
            camera.addTarget(self.filter)
            filter.addTarget((self.view as! GPUImageInput))
        }
    }
}
