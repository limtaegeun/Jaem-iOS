//
//  MyRegularFitCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 7..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class MyRegularFitCell: UICollectionViewCell {
    
    @IBOutlet weak var defaultLabel: UILabel!
    var sizeArray : [Dictionary<String,String>]?
    var labels = [UILabel]()
    func addLabels() {
        let LeftOffsetX = defaultLabel.frame.origin.x
        let RightOffsetX = self.frame.maxX - 65
        var offsetY = CGRectGetMaxY(defaultLabel.frame)
        
        for dic in sizeArray! {
            let label = UILabel(frame: CGRect(x: LeftOffsetX, y: offsetY + 17, width: 100, height: 18))
            label.font = UIFont(name: "OpenSans", size: 15)!
            label.textColor = defaultLabel.textColor
            label.text = dic["title"]
            
            let label2 = UILabel(frame: CGRect(x: RightOffsetX, y: offsetY + 17, width: self.frame.maxX - RightOffsetX, height: 18))
            label2.font = UIFont(name: "OpenSans", size: 15)!
            label2.textColor = defaultLabel.textColor
            
            let attributeString : NSMutableAttributedString
            if dic["value"] != "" {
                attributeString =  NSMutableAttributedString(string:dic["value"]! + "CM")
                attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "OpenSans", size: 10)!, range: NSMakeRange(attributeString.length - 2 , 2))
                label2.attributedText = attributeString
                addSubview(label2)
                labels.append(label2)
            }
            
            addSubview(label)
            labels.append(label)
            offsetY = CGRectGetMaxY(label.frame)
        }
    }
    
    override func prepareForReuse() {
        for label in labels {
            label.removeFromSuperview()
        }
    }
    
}
