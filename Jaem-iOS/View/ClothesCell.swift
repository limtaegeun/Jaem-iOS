//
//  ClothesCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 7..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ClothesCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var fittingLabel: UILabel!
    
    
    var targetClothes : Clothes!
    
    var labels = [UILabel]()
    func addLabels() {
        let LeftOffsetX = titleLabel.frame.origin.x
        let RightOffsetX = self.frame.maxX - 65
        var offsetY = CGRectGetMaxY(sizeLabel.frame)
        
        for dic in targetClothes.sizeRequired {
            let label = UILabel(frame: CGRect(x: LeftOffsetX, y: offsetY + 17, width: 100, height: 18))
            label.font = UIFont(name: "OpenSans", size: 15)!
            label.textColor = titleLabel.textColor
            label.text = dic.title
            
            let label2 = UILabel(frame: CGRect(x: RightOffsetX, y: offsetY + 17, width: self.frame.maxX - RightOffsetX, height: 18))
            label2.font = UIFont(name: "OpenSans", size: 15)!
            label2.textColor = titleLabel.textColor
            
            let attributeString : NSMutableAttributedString
            
            attributeString =  NSMutableAttributedString(string:dic.value.description + "CM")
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans", size: 10)!, range: NSMakeRange(attributeString.length - 2 , 2))
            label2.attributedText = attributeString
            addSubview(label2)
            labels.append(label2)
            
            
            addSubview(label)
            labels.append(label)
            offsetY = CGRectGetMaxY(label.frame)
        }
    }
}
