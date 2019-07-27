//
//  StringExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/6/4.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

extension String {
    /**
     计算文字宽高
     - returns:
     //使用：
     let projectText="我是一段字符串，来计算我的高度吧";
     
     let projectSize=projectText.textSizeWithFont(UIFont.systemFontOfSize(14), constrainedToSize:CGSizeMake(100, 200))
     let comProjectW:CGFloat=projectSize.width;
     let comProjectH:CGFloat=projectSize.height;
     //记得要在计算的字符串UILable中加上
     UIlable.font=UIFont.systemFontOfSize(14);
     //显示几行
     UIlable.numberOfLines=1;
     */
    func textSizeWithFont(_ font:UIFont,constrainedToSize size:CGSize) -> CGSize{
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font,forKey: NSAttributedString.Key.font as NSCopying)
            textSize = self.size(withAttributes: attributes as? [NSAttributedString.Key : Any])
        }else{
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font,forKey: NSAttributedString.Key.font as NSCopying)
            let stringRect = self.boundingRect(with: size,options: option,attributes: attributes as? [NSAttributedString.Key : Any],context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
    
    //是否整型
    var isPurnInt:Bool {
        let scan: Scanner = Scanner(string: self)
        var val:Int = 0
        return scan.scanInt(&val) && scan.isAtEnd // scanFloat是否float
    }
    
    //344显示
    var phone344:String {
        var tempStr = self
        if tempStr.phoneNoBlank.count > 3 {
            let start = tempStr.index(tempStr.startIndex, offsetBy: 3)
            let end = tempStr.index(tempStr.startIndex, offsetBy: 3 + 1)
            let char:String = String(tempStr[start..<end])
            if char != " " {
                //不是空格，插入空格
                tempStr.insert(Character.init(" "), at: tempStr.index(tempStr.startIndex, offsetBy: 3))
            }
            
            if tempStr.phoneNoBlank.count > 7 {
                let start = tempStr.index(tempStr.startIndex, offsetBy: 8)
                let end = tempStr.index(tempStr.startIndex, offsetBy: 8 + 1)
                let char:String = String(tempStr[start..<end])
                if char != " " {
                    //不是空格，插入空格
                    tempStr.insert(Character.init(" "), at: tempStr.index(tempStr.startIndex, offsetBy: 8))
                }
            }
        }
        return tempStr
    }
    
    // 手机号无空格
    var phoneNoBlank:String {
        let tempStr = self
        var str = String()
        for i in 0..<tempStr.count {
            let start = tempStr.index(tempStr.startIndex, offsetBy: i)
            let end = tempStr.index(tempStr.startIndex, offsetBy: i + 1)
            let char:String = String(tempStr[start..<end])
            if char != " " {
                str.append(char)
            }
        }
        return str
    }
    
    //6-16位 数字和字母密码
    var if6and16pw:Bool{
        let passwordRule = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
        let regexPassword = NSPredicate(format: "SELF MATCHES %@",passwordRule)
        if regexPassword.evaluate(with: self) == true {
            return true
        }else{
            return false
        }
    }
    
    //中间4位星号 344 187****3456
    var midle4StarString:String {
        var tempStr = self
        if tempStr.count > 7 {
            let start = tempStr.index(tempStr.startIndex, offsetBy: 3)
            let end = tempStr.index(tempStr.startIndex, offsetBy: 6)
            tempStr.replaceSubrange(start..<end, with: "****")
        }
        return tempStr
    }
    
    //String转dictionary扩展
    var stringToDic : NSDictionary?{
        do {
            let data:Data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)! as Data
            let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? Dictionary<String, Any>
            guard let dic = dict else {
                //获取授权信息异常
                return nil
            }
            return dic as NSDictionary
        }catch{
            //获取授权信息异常
            return nil
        }
    }
    
    //将原始的url编码为合法的url，例如把中文、空格、特殊符号进行转义
    func urlEncode() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    func StrEncode()->String{
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "\"\'[]:/?&=;+!@#$()',*{}\\<>%^`").inverted)
        return encodeUrlString ?? ""
    }
    
    //将转义后的URL转换为带中文、空格、特殊符号的原始url
    func urlDecode() -> String{
        return self.removingPercentEncoding ?? ""
    }
    
    
    /*
    
    //给string添加索引:get:var a = str[7,3] , set:str[7,3] = "COM"
    subscript(start:Int,length:Int) -> String{
        get{
            let index1 = self.index(self.startIndex, offsetBy: start)
            let index2 = self.index(index1, offsetBy: length)
            let range = Range(uncheckedBounds: (lower: index1, upper: index2))
            return self.substring(with: range)
        }
        set{
            let tmp = self
            var s = ""
            var e = ""
            for (idx,item) in tmp.characters.enumerated() {
                if idx < start {
                    s += "\(item)"
                }
                if idx >= start + length {
                    e += "\(item)"
                }
            }
            self = s + newValue + e
        }
    }
    //给string添加索引:get:var a = str[3] , set:str[3] = "F"
    subscript(index:Int) -> String {
        get{
            return String(self[self.index(self.startIndex, offsetBy: index)])
        }
        set{
            let tmp = self
            self = ""
            for (idx,item) in tmp.characters.enumerated() {
                if idx == index {
                    self += "\(newValue)"
                }else{
                    self += "\(item)"
                }
            }
        }
    }
    
    //将字符串转成MD5
    var md5:String{
        let str = self.cString(using: .utf8)
        let strLen = CC_LONG(self.lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        CC_MD5(str!,strLen,result)
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        result.deinitialize()
        return String.init(format: hash as String)
    }
    
    // 从字符串中提取数字
    var getInt:String{
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }
    
    /**
     3DES的加密过程 和 解密过程
     
     - parameter op : CCOperation： 加密还是解密
     CCOperation（kCCEncrypt）加密
     CCOperation（kCCDecrypt) 解密
     
     - parameter key: 加解密key
     - parameter iv : 可选的初始化向量，可以为nil
     - returns      : 返回加密或解密的参数
     */
    func tripleDESEncryptOrDecrypt(op: CCOperation,key: String,iv: String?="01234567") -> String? {
        
        // Key
        let keyData: NSData = key.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData!
        let keyBytes         = UnsafeMutableRawPointer(mutating: keyData.bytes)
        
        var data: NSData!
        if op == CCOperation(kCCEncrypt) {//加密内容
            data  = self.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData!
        }
        else {//解密内容
            data =  NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        }
        
        let dataLength    = size_t(data.length)
        let dataBytes     = UnsafeMutableRawPointer(mutating: data.bytes)
        
        // 返回数据
        let cryptData    = NSMutableData(length: Int(dataLength) + kCCBlockSize3DES)
        let cryptPointer = UnsafeMutableRawPointer(mutating: cryptData?.bytes)
        let cryptLength  = size_t(cryptData!.length)
        
        //  可选 的初始化向量
        //        let viData :NSData = iv.data(using: String.Encoding.utf8, allowLossyConversion: true) as NSData!
        //        let viDataBytes    = UnsafeMutableRawPointer(mutating: viData.bytes)
        
        // 特定的几个参数
        let keyLength              = size_t(kCCKeySize3DES)
        let operation: CCOperation = UInt32(op)
        let algoritm:  CCAlgorithm = UInt32(kCCAlgorithm3DES)
        let options:   CCOptions   = CCOptions(kCCOptionECBMode + kCCOptionPKCS7Padding) //UInt32(kCCOptionPKCS7Padding)
        
        var numBytesCrypted :size_t = 0
        
        let cryptStatus = CCCrypt(operation, // 加密还是解密
            algoritm, // 算法类型
            options,  // 密码块的设置选项
            keyBytes, // 秘钥的字节
            keyLength, // 秘钥的长度
            nil,//viDataBytes, // 可选初始化向量的字节
            dataBytes, // 加解密内容的字节
            dataLength, // 加解密内容的长度
            cryptPointer, // output data buffer
            cryptLength,  // output data length available
            &numBytesCrypted) // real output data length
        
        
        if UInt32(cryptStatus) == UInt32(kCCSuccess) {
            
            cryptData!.length = Int(numBytesCrypted)
            if op == CCOperation(kCCEncrypt)  {
                let base64cryptString = cryptData?.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters)
                return base64cryptString
            }
            else {
                
                let base64cryptString = String.init(data: cryptData! as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                return base64cryptString
            }
        } else {
            print("Error: \(cryptStatus)")
        }
        return nil
    }
    
    //AES 加密
    func aes(operation: CCOperation,key: String) -> String{
        let keyData             = key.data(using: String.Encoding.utf8)! as NSData
        let keyLen              = Int(kCCKeySizeAES128)
        let keyBytes            = keyData.bytes
        
        let strData             = self.data(using: String.Encoding.utf8)! as NSData
        let dataLen             = strData.length
        let dataBytes           = strData.bytes
        
        let cryptLength         = Int(dataLen + kCCBlockSizeAES128)
        let cryptPointer        = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: cryptLength)
        
        let algoritm            = CCAlgorithm(kCCAlgorithmAES128)
        let option              = CCOptions(kCCOptionPKCS7Padding|kCCOptionECBMode)
        
        let numBytesEncrypted   = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        numBytesEncrypted.initialize(to: 1)
        
        let cryptStatus         = CCCrypt(operation, algoritm, option, keyBytes, keyLen, nil, dataBytes, dataLen, cryptPointer, cryptLength, numBytesEncrypted)
        
        
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess){
            let len = Int(numBytesEncrypted.pointee)
            let digest = stringFromResult(result: cryptPointer, length: len)
            numBytesEncrypted.deallocate(capacity: 1)
            return digest
        }else{
            return ""
        }
    }
    
    //十六进制转换
    private func stringFromResult(result: UnsafeMutablePointer<CUnsignedChar>, length: Int) -> String {
        let hash = NSMutableString()
        for i in 0..<length {
            hash.appendFormat("%02x", result[i])
        }
        return String(hash)
    }
    
    /// 替换手机号中间四位
    /// - Returns: 替换后的值
    func replacePhone() -> String {
        if self.characters.count > 8 {
            let start = self.index(self.startIndex, offsetBy: 3)
            let end = self.index(self.startIndex, offsetBy: 7)
            let range = Range(uncheckedBounds: (lower: start, upper: end))
            return self.replacingCharacters(in: range, with: "****")
        }
        return self
    }
    
    //将部分文字替换成*
    func replaceWord()->String {
        if self.characters.count > 1 {
            let start = self.index(self.startIndex, offsetBy: 1)
            let end = self.endIndex
            let range = Range(uncheckedBounds: (lower: start, upper: end))
            var star = ""
            for i in 0..<self.characters.count - 1 {
                star.append("*")
            }
            return self.replacingCharacters(in: range, with: star)
        }
        return self
    }
     
     
    */
    
    
    //替换字符串
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    //获取下标对应的字符
    func charAt(pos: Int) -> Character? {
        if pos < 0 || pos >= count {
            return nil   //判断边界条件
        }
        let index = self.index(self.startIndex, offsetBy: pos)
        let str = self[index]
        return Character(String(str))
    }
    
    //
    var isPhoneStr:Bool{
        let phoneNum = self
        let judgeStr = "^1[3,8]\\d{9}|14[5,7,9]\\d{8}|15[^4]\\d{8}|17[^2,4,9]\\d{8}$"
        do {
            let regex = try NSRegularExpression(pattern: judgeStr)
            let nsString = phoneNum as NSString
            let results = regex.matches(in: phoneNum, range: NSRange(location: 0, length: nsString.length))
            let resultArray = results.map { nsString.substring(with: $0.range) }
            print(resultArray.count)
            if resultArray.count > 0 {
                return true
            } else {
                return false
            }
        } catch let error {
            print("无效正则表达式: \(error.localizedDescription)")
            return false
        }
    }
    
}
