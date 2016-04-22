//
//  MeasureStepCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 30..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class MeasureStepCell: UICollectionViewCell {
    
    
    @IBOutlet weak var ovalView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    private var ovalLayer : CAShapeLayer!
    override func awakeFromNib() {
        ovalLayer =  CAShapeLayer()
        ovalLayer.path = UIBezierPath(ovalInRect: CGRect(x: 0, y: 0, width: 13, height: 13)).CGPath
        ovalLayer.fillColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1.0).CGColor
        ovalView.layer.addSublayer(ovalLayer)
    }
    
    func changeOvalColor(write : Bool, active: Bool)  {
        let activeColor = UIColor(red: 241/255, green: 107/255, blue: 38/255, alpha: 1.0)
        let unwriteColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1.0)
        
        if active == true {
            ovalLayer.fillColor = activeColor.CGColor
        } else {
            if write == true {
                ovalLayer.fillColor = UIColor.blackColor().CGColor
            } else {
                ovalLayer.fillColor = unwriteColor.CGColor
            }
        }
    }
}
