//
//  CategoryButton.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 11..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CategoryButton: UIButton {

    private var rectLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setShapeLayer(bounds)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    
    func setShapeLayer(frame : CGRect) {
        titleLabel?.textColor = UIColor.whiteColor()
        rectLayer.path = UIBezierPath(roundedRect: CGRect(x: frame.minX + 1, y: frame.minY + 1, width: frame.width - 2, height: frame.height - 2), cornerRadius: 10).CGPath
        rectLayer.fillColor = UIColor.clearColor().CGColor
        layer.insertSublayer(rectLayer, below: titleLabel?.layer)
    }
    func changeFillAlpha(tureOn : Bool) {
        
        var toColor = UIColor()
        var toTitleColor = UIColor()
        if tureOn == true {
            toColor = UIColor.blackColor()
            toTitleColor = UIColor.whiteColor()
        } else {
            toColor = UIColor.clearColor()
            toTitleColor = UIColor.blackColor()
        }
        
        let colorAni = CABasicAnimation(keyPath: "fillColor")
        colorAni.duration = 0.3
        colorAni.toValue = toColor.CGColor
        colorAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        rectLayer.addAnimation(colorAni, forKey: "Ani")
        rectLayer.fillColor = toColor.CGColor
        
        UIView.animateWithDuration(0.3) { 
            self.setTitleColor(toTitleColor, forState: .Normal)
        }
        
    }
}
