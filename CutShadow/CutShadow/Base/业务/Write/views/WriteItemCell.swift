//
//  WriteItemCell.swift
//  CutShadow
//
//  Created by 冯才凡 on 2019/12/2.
//  Copyright © 2019 冯才凡. All rights reserved.
//

import UIKit

class WriteItemCell: UICollectionViewCell {

    @IBOutlet weak var cardBg: UIView!
    @IBOutlet weak var titleL: UILabel!
    @IBOutlet weak var detailL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cardBg.backgroundColor = UIColor.hex(textColor).withAlphaComponent(CGFloat(0.1 * Double(2 + arc4random() % 10)))
        
        self.layer.cornerRadius = 4
        self.layer.masksToBounds = true
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.hex("dbdbdb").cgColor
    }
    
}
