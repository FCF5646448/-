//
//  CSSelectPicHeadView.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/9/19.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

enum SelectActionType {
    case takePhoto
    case takeVideo
}

protocol CSSelectPicHeadViewDelegate:NSObjectProtocol {
    func csselectPicHeadAction(type:SelectActionType)
}

class CSSelectPicHeadView: UICollectionReusableView {

    weak var delegate:CSSelectPicHeadViewDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func videoBtnAction(_ sender: Any) {
        self.delegate?.csselectPicHeadAction(type: .takeVideo)
    }
    
    @IBAction func photoAction(_ sender: Any) {
        self.delegate?.csselectPicHeadAction(type: .takePhoto)
    }
}
