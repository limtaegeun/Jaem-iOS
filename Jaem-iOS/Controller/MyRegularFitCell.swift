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
    var sizeArray : [Dictionary<String,String>]!
    override func awakeFromNib() {
        let offsetX = defaultLabel.frame.origin.x
        var offsetY = CGRectGetMaxY(defaultLabel.frame)
        
        for dic in sizeArray {
            let label = UILabel(frame: CGRect(x: offsetX, y: offsetY + 17, width: self.frame.maxX - offsetX, height: 18))
            label.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 10)!
            label.textColor = defaultLabel.textColor
            
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string:dic["title"]! + "     " + dic["value"]!)
            
            attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(16, 3))
            label.attributedText = attributeString
            
            offsetY = CGRectGetMaxY(label.frame)
        }
        
    }
    
}
