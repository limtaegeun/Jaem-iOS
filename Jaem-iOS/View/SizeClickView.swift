//
//  SizeClickView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 24..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class SizeClickView: UIView {

    var buttons = [UIButton]()
    var selecActive = false
    var selectComplete = false
    
    @IBInspectable var min : Int = 85
    @IBInspectable var max : Int = 115
    @IBInspectable var term : Int = 5
    
    var selectSize = [Int]()
    var firstIndex : Int!
    private var saveValue : Int {
        get {
            
            return 0
        }
        set(newVal) {
            if selectSize.count != 0 {
                if selectSize[0] > newVal {
                    selectSize.insert(newVal, atIndex: 0)
                    
                } else {
                    selectSize.append(newVal)
                }
            } else {
                selectSize.append(newVal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //setButton(min, max: max, term: term)
    }
    
    
    
    func setButton(min: Int, max:Int, term : Int) {
        //init button
        
        let defaultColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        var wholeWidth :CGFloat = 0
        
        for i in 0...((max - min)/term) {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 10 * CGFloat("\(min + term * i)".characters.count), height: 22))
            button.setTitle("\(min + term * i)", forState: .Normal)
            button.setTitleColor(defaultColor, forState: .Normal)
            button.titleLabel?.font =  UIFont(name: "AppleSDGothicNeo-Regular", size: 14)!
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
    
    func tapButton(sender :AnyObject) {
        let blueColor = UIColor(red: 97/255, green: 198/255, blue: 230/255, alpha: 1)
        let defaultColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        let nonSelectColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        
        if selectComplete == true {
            selectSize.removeAll()
            firstIndex = nil
            selectComplete = false
            tapButton(sender)
            return
        }
        
        if selecActive == false {
            selecActive = true
            let selectButton = sender as! UIButton
            let value = selectButton.titleLabel?.text
            saveValue = Int(value!)!
            let index = buttons.indexOf(sender as! UIButton)
            firstIndex = index
            UIView.animateWithDuration(0.3, animations: {
                for button in self.buttons {
                    button.setTitleColor(nonSelectColor, forState: .Normal)
                    
                }
                
                self.buttons[index!].setTitleColor(blueColor, forState: .Normal)
                if index != 0{
                    self.buttons[index! - 1].setTitleColor(defaultColor, forState: .Normal)
                }
                if index != (self.buttons.count - 1) {
                    self.buttons[index! + 1].setTitleColor(defaultColor, forState: .Normal)
                }
                }, completion: nil)
            
        } else {
            selecActive = false
            
            let index = buttons.indexOf(sender as! UIButton)
            
            if (index! - firstIndex) == 1{
                let selectButton = sender as! UIButton
                let value = selectButton.titleLabel?.text
                saveValue = Int(value!)!
                
                UIView.animateWithDuration(0.3, animations: { 
                    self.buttons[index!].setTitleColor(blueColor, forState: .Normal)
                    
                    if index >= 2 {
                        self.buttons[index! - 2].setTitleColor(nonSelectColor, forState: .Normal)
                    }
                    
                    }, completion: {_ in
                        self.selectComplete = true
                        
                })
                
                
            } else if (index! - firstIndex) == -1 {
                let selectButton = sender as! UIButton
                let value = selectButton.titleLabel?.text
                saveValue = Int(value!)!
                
                UIView.animateWithDuration(0.3, animations: {
                    self.buttons[index!].setTitleColor(blueColor, forState: .Normal)
                    
                    if index <= (self.buttons.count - 3) {
                        self.buttons[index! + 2].setTitleColor(nonSelectColor, forState: .Normal)
                    }
                    
                    }, completion: {_ in
                        self.selectComplete = true
                })
                

            }else {
                selectSize.removeAll()
                firstIndex = nil
                tapButton(sender)
            }
            
            
        }
        print(selectSize)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
