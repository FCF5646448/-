//
//  UIImageViewExtension.swift
//  Sierra
//
//  Created by 冯才凡 on 2018/10/17.
//  Copyright © 2018年 zhuoming. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    //颜色图层
    @objc var colorLayer: CAGradientLayer {
        let layer = CAGradientLayer()
        layer.colors = [UIColor.hex(0xffffff, 0.3)]
        layer.startPoint = CGPoint(x: 0.5, y: 0)
        layer.endPoint = CGPoint(x: 0.5, y: 1)
        return layer
    }
    
    func addDKLayer(colors:[UIColor] = [UIColor.hex( 0xffffff, 0.3)]) {
        removeColorLayer()
        self.colorLayer.colors = colors
        self.layer.addSublayer(self.colorLayer)
    }
    
    func removeColorLayer() {
        if self.colorLayer.superlayer == self.layer {
            self.colorLayer.removeFromSuperlayer()
        }
    }
    
}
