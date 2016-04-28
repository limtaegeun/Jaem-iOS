//
//  SizeRatingView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 26..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

protocol SizeRatingViewDelegate {
    func sizeRatingTapButton(value : Int)
}

class SizeRatingView: UIView {

    
    var buttons = [UIButton]()
    var selectedValue = 0
    
    private var grayCharacters : [UIImage]!
    private var blueCharacters : [UIImage]!
    
    var delegate : SizeRatingViewDelegate?
    
    func setButton() {
        //init button
        
        var wholeWidth :CGFloat = 0
        
        grayCharacters = [JaemCharacterStyleKit.imageOfGray1,
                          JaemCharacterStyleKit.imageOfGray2,
                          JaemCharacterStyleKit.imageOfGray3,
                          JaemCharacterStyleKit.imageOfGray4,
                          JaemCharacterStyleKit.imageOfGray5]
        
        blueCharacters = [JaemCharacterStyleKit.imageOfBlue1,
                          JaemCharacterStyleKit.imageOfBlue2,
                          JaemCharacterStyleKit.imageOfBlue3,
                          JaemCharacterStyleKit.imageOfBlue4,
                          JaemCharacterStyleKit.imageOfBlue5]
        
        for i in 0...4 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 35, height: 44))
            button.setImage(grayCharacters[i], forState: .Normal)
            buttons.append(button)
            
            wholeWidth += button.bounds.width
        }
        
        //add to View
        
        let offsetX = (self.frame.width - wholeWidth ) / CGFloat(buttons.count + 1)
        let midY = self.bounds.height/2
        var stackX : CGFloat = 0.0
        for i in 0...(buttons.count - 1) {
            self.addSubview(buttons[i])
            
            buttons[i].center = CGPoint(x: stackX + offsetX * CGFloat(i + 1) + buttons[i].bounds.width/2, y: midY)
            stackX += buttons[i].bounds.width
        }
        
        
        //set action
        for button in buttons {
            button.addTarget(self, action: #selector(self.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
    }
    
    func tapButton(sender : CategoryButton) {
        
        for button in buttons {
            let i = buttons.indexOf(button)
            button.setImage(grayCharacters[i!], forState: .Normal)
            button.bounds = CGRect(x: 0, y: 0, width: 35, height: 44)
        }
        
        let index = buttons.indexOf(sender)
        sender.setImage(blueCharacters[index!], forState: .Normal)
        sender.frame = CGRectInset(sender.frame, -7, -9)
        selectedValue = index! + 1
        
        delegate?.sizeRatingTapButton(selectedValue)
    }
    
}

    

