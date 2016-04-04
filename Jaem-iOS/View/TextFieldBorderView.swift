//
//  TextFieldBorderView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class TextFieldBorderView: UIView {

    private var rectLayer = CAShapeLayer()
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override init(frame: CGRect) {
        super.init(frame: frame)
        setShapeLayer(bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setShapeLayer(frame : CGRect) {
        let filColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 1.000)

        rectLayer.path = UIBezierPath(roundedRect: CGRect(x: bounds.minX + 1, y: bounds.minY + 1, width: bounds.width - 2, height: bounds.height - 2), cornerRadius: 10).CGPath
        rectLayer.strokeColor = filColor.CGColor
        rectLayer.fillColor = UIColor.clearColor().CGColor
        rectLayer.lineWidth = 1
        layer.addSublayer(rectLayer)
    }
    
    func changeFillAlpha(tureOn : Bool) {
        
        var toColor = UIColor()
        
        if tureOn == true {
            toColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 1.000)
        } else {
            toColor = UIColor(red: 0.530, green: 0.530, blue: 0.530, alpha: 0.000)
        }
        
        
        let colorAni = CABasicAnimation(keyPath: "fillColor")
        colorAni.duration = 0.3
        colorAni.toValue = toColor.CGColor
        colorAni.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        
        
            
        rectLayer.addAnimation(colorAni, forKey: "Ani")
        rectLayer.fillColor = toColor.CGColor
        
        
    }
    
    

}
