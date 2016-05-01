//
//  FitInfoView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class FitInfoView: UIView {

    var sizes = [String]()
    var labels = [UILabel]()
    
    func setLabel() {
        //init button
        sizes.insert("•", atIndex: 0)
        sizes.insert("•", atIndex: sizes.count)
        
        let defaultColor = UIColor.blackColor()
        var wholeWidth :CGFloat = 0
        
        for i in 0...(sizes.count - 1) {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            label.text = sizes[i]
            label.textColor = defaultColor
            label.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 16)!
            labels.append(label)
            wholeWidth += label.bounds.width
        }
        
        //add to View
        
        let offsetX = (self.frame.width - wholeWidth ) / CGFloat(labels.count + 1)
        let midY = self.bounds.height/2
        var stackX : CGFloat = 0.0
        for i in 0...(labels.count - 1) {
            self.addSubview(labels[i])
            
            labels[i].center = CGPoint(x: stackX + offsetX * CGFloat(i + 1) + labels[i].bounds.width/2, y: midY)
            stackX += labels[i].bounds.width
        }
        
        
        //set action
       
    }
    
    
    
    
    
    
    

}
