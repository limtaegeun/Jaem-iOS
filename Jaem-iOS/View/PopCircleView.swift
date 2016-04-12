//
//  PopCircleView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class PopCircleView: UIView {

    override func awakeFromNib() {
        let circleLayer = CAShapeLayer()
        circleLayer.path = UIBezierPath(ovalInRect: CGRect(x: self.bounds.width / 2 - 7, y: self.bounds.height / 2 - 7, width: 14, height: 14)).CGPath
        circleLayer.fillColor = UIColor.blackColor().CGColor
        
        layer.addSublayer(circleLayer)
    }
    
}
