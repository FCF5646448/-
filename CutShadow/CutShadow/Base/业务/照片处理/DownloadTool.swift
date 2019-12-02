//
//  DownloadTool.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/11/29.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class DownloadTool: NSObject {
    
    //https://stackoverflow.com/questions/37344822/saving-image-and-then-loading-it-in-swift-ios
    
    static var share:DownloadTool = DownloadTool()
    private override init() {
        super.init()
    }
    
    let ducumentPath = NSHomeDirectory() + "/Documents"
    
    func saveImage(img:UIImage) {
        let time:TimeInterval = Date().timeIntervalSince1970
        let imgName = String(format: "%.0f.jpg", time)
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }

        let fileName = imgName
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard let data = img.jpegData(compressionQuality: 1) else { return }

        //Checks if file exists, removes it if so.
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(atPath: fileURL.path)
                print("Removed old image")
            } catch let removeError {
                print("couldn't remove file at path", removeError)
            }

        }

        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
        
        let model = PicModel()
        model.name = imgName
        model.time = time
        
        model.save()
    }
    
    func loadImageFromDiskWith(imgName: String) -> UIImage? {

      let documentDirectory = FileManager.SearchPathDirectory.documentDirectory

        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)

        if let dirPath = paths.first {
            let imageUrl = URL(fileURLWithPath: dirPath).appendingPathComponent(imgName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            return image
        }

        return nil
    }
    
}
