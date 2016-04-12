//
//  AddButtonView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 7..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class AddButtonView: UIView {

    @IBInspectable var white : Bool = false
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        if white == true {
            JaemIconStyleKit.drawAddButton(frame: bounds)
        } else {
            JaemIconStyleKit.drawAddButton2(frame: bounds)

        }
    }
    

}
