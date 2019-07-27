//
//  ToolManager.swift
//  PiaTraining
//
//  Created by 冯才凡 on 2017/8/2.
//  Copyright © 2017年 com.fcf. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import MobileCoreServices

//单纯的工具类
class ToolManager{
    
    //打电话
    class func callPhone(){
        UIApplication.shared.openURL(URL.init(string: "tel://")!)
    }
    
    //是否可以打开微信
    class func canOpenWechat()->Bool {
        let headStr = "weixin://"
        return UIApplication.shared.canOpenURL(URL.init(string: headStr)!)
    }
    
    //缩放比，因为是iPad项目，所以都以1536为准
    class func myAppSizeScale() ->CGFloat{
        if IsPhone {
            var scale:CGFloat = 1.0
            if WIDTH == 414 {
                scale =  1//1.656 //宽高:414x736;设备:6plus、6splus、7plus、8plus;像素:1242x2208
            }else if WIDTH == 375{
                scale =  1.0 //宽高:375x667;设置:6、6s、7、8;像素:750x1334
            }else if WIDTH == 320{
                scale = 0.853 //宽高:320x568;设置:5、5s、5c、5e;像素:640x1136 \ 宽高:320x480;设置:4、4s;像素:	640x960
            }
            //iphone X 像素:1125x2436 5以后都是16:9
            return scale
        }else{
            let scale:CGFloat = 1.0
            return scale
        }
    }
    
    //返回手机整个内存空间
    class func getDiskTotalSpace() -> Float {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
        let fileManager = FileManager.default
        do{
            let fileSysAttributes:NSDictionary = try fileManager.attributesOfItem(atPath: path) as NSDictionary
            let totalSpace = fileSysAttributes.object(forKey: FileAttributeKey.systemSize)
            return ((totalSpace as AnyObject).floatValue)!
            
        }catch let error as NSError {
            print(error)
        }
        return 0
    }
    
    //返回手机剩余内存空间
    class func getDiskFreeSpace() -> Float {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first! as String
        let fileManager = FileManager.default
        do{
            let fileSysAttributes:NSDictionary = try fileManager.attributesOfItem(atPath: path) as NSDictionary
            let freeSpace = fileSysAttributes.object(forKey: FileAttributeKey.systemFreeSize)
            return ((freeSpace as AnyObject).floatValue)!
            
        }catch let error as NSError {
            print(error)
        }
        return 0
    }
    
    //将数组转成字符串
    class func convertNSMutableArrayToString(_ arr:NSMutableArray) -> String {
        var result:String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: arr, options: JSONSerialization.WritingOptions.prettyPrinted)
            result = String(data: jsonData, encoding: String.Encoding.utf8)!
        } catch let error as NSError {
            print(error)
        }
        print(result)
        return result
    }
    
    //将字典转成字符串
    class func convertDictionaryToString(_ dict:[String:AnyObject]) -> String {
        var result:String = ""
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            result = String(data: jsonData, encoding: String.Encoding.utf8)!
        } catch let error as NSError {
            print(error)
        }
        print(result)
        return result
    }
    
    //获取本地\远程视频缩略图
    class func getImgFromVideo(path:String,result:((_ img:UIImage?)->())?=nil){
        
        var videoUrl:URL?
        if path.hasPrefix("http") {
            videoUrl = URL.init(string: path)
        }else{
            videoUrl = URL.init(fileURLWithPath: path)
        }
        
        if let vdurl = videoUrl {
            DispatchQueue.global().async {
                let avAsset = AVAsset(url: vdurl)
                
                let generator = AVAssetImageGenerator(asset: avAsset)
                generator.appliesPreferredTrackTransform = true
                let time = CMTimeMakeWithSeconds(0.0, preferredTimescale: 600)
                
                do {
                    let imageRef = try generator.copyCGImage(at: time, actualTime: nil)
                    let resultImg = UIImage(cgImage: imageRef)
                    result?(resultImg) //返回展示的时候记得要放到主线程中
                }
                catch let error as NSError
                {
                    print("Image generation failed with error \(error)")
                    result?(nil)
                }
            }
        }
    }
    
    ///传入base64的字符串，可以是没有经过修改的转换成的以data开头的，也可以是base64的内容字符串，然后转换成UIImage
    class func base64StringToUIImage(_ base64String:String)->(UIImage,Data)? {
        var str = base64String
        
        // 1、判断用户传过来的base64的字符串是否是以data开口的，如果是以data开头的，那么就获取字符串中的base代码，然后在转换，如果不是以data开头的，那么就直接转换
        if str.hasPrefix("data:image") {
            guard let newBase64String = str.components(separatedBy: ",").last else {
                return nil
            }
            str = newBase64String
        }
        // 2、将处理好的base64String代码转换成NSData
        guard let imgData = Data(base64Encoded: str, options: .ignoreUnknownCharacters) else {
            return nil
        }
        // 3、将NSData的图片，转换成UIImage
        guard let codeImage = UIImage(data: imgData) else {
            return nil
        }
        return (codeImage,imgData)
    }
    
    //复制内容到剪切板
    class func copyStrToPasteboard(str:String,complete:((_ result:Bool)->())?=nil){
        if str != "" {
            UIPasteboard.general.string = str
            complete?(true)
        }else{
            complete?(false)
        }
    }
    
}
