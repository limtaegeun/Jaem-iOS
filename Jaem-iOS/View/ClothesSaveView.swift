//
//  ClothesSaveView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 29..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ClothesSaveView: UIView {

    var buttons = [UIButton]()
    var sizes = [String]()
    
    init(frame: CGRect, sizes : [String] ) {
        super.init(frame: frame)
        self.sizes = sizes
        setButton()
        self.backgroundColor = UIColor.blackColor()
        self.alpha = 0.75
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setButton() {
        //init button
        
        var wholeWidth :CGFloat = 0
        
        for i in 0...(sizes.count - 1) {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22 , height: 22))
            button.setTitle(sizes[i], forState: .Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Bold", size: 14)!
            buttons.append(button)
            wholeWidth += button.bounds.width
        }
        
        //add to View
        var stackX : CGFloat = 60.0
        let offsetX = (self.frame.width - wholeWidth - stackX * 2 ) / CGFloat(buttons.count + 1)
        let midY = self.bounds.height/2
        
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
    
    func tapButton(sender: AnyObject) {
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
