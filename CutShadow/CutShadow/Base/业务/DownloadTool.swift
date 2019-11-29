//
//  DownloadTool.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/29.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class DownloadTool: NSObject {
    
    static var share:DownloadTool = DownloadTool()
    private override init() {
        super.init()
    }
    
    let ducumentPath = NSHomeDirectory() + "/Documents"
    
    func saveImage(img:UIImage) {
        let imgData = img.jpegData(compressionQuality: 1.0)
        
        let time:TimeInterval = Date().timeIntervalSince1970
        let name = "\(time)"
        
        let filePath = String(format: "%@/imgCache", ducumentPath)
        
        if !FileManager.default.fileExists(atPath: filePath) {
            try? FileManager.default.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
        }
        
        let imgPath = String(format: "%@/%@.jpg", filePath,name)
        
        try? imgData?.write(to: URL(fileURLWithPath: imgPath))
        
        let model = PicModel()
        model.name = name
        model.path = imgPath
        model.time = time
        
        model.save()
        
    }
    
}
