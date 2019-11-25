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
    
    var filter:GPUImageFilter = GPUImageFilter()
    
    var isPause:Bool = false
    
    //高清前置摄像头
    fileprivate lazy var camera : GPUImageStillCamera = {
        let cm:GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSession.Preset.high.rawValue, cameraPosition: .front)
        cm.outputImageOrientation = .portrait
        cm.horizontallyMirrorFrontFacingCamera = true
        return cm
    }()
    
    override func loadView() {
        let imgView = GPUImageView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        imgView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth,UIView.AutoresizingMask.flexibleHeight]
        imgView.fillMode = .preserveAspectRatioAndFill
        self.view  = imgView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initUI()
        beginCapture()
    }
    
    func initUI() {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: kScreenWidth * 0.5 - 60, y: kScreenHeight - 80, width: 120, height: 60)
        btn.setTitle("拍照", for: .normal)
        btn.setTitleColor(UIColor.red, for: .normal)
        btn.addTarget(self, action: #selector(takePhotoAction), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    func beginCapture() {
        self.camera.addTarget(self.filter)
        self.filter.addTarget((self.view as! GPUImageInput))
        
        //TODO :   这句是导致相机打开会卡顿的主要原因,后续需要优化
        self.camera.startCapture()
    }
    

    @objc func takePhotoAction(_ sender: UIButton) {
        guard isPause else {
            weak var weakself = self
            self.camera.capturePhotoAsJPEGProcessedUp(toFilter: self.filter) { (image, error) in
                weakself?.camera.pauseCapture()
                weakself?.isPause = true
                if let imgData:Data = image, let img = UIImage(data: imgData) {
                    UIImageWriteToSavedPhotosAlbum(img, nil, nil, nil)
                }
            }
            return
        }
        
        self.camera.resumeCameraCapture()
        isPause = false
    }
    
}
