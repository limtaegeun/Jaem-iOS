//
//  ClothesHeaderView.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 22..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class ClothesHeaderView: UICollectionReusableView {
        
    @IBOutlet weak var coordiCollectionViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var coordiCollectionView: UICollectionView!
    @IBOutlet weak var infoTableView: UITableView!
    @IBOutlet weak var categoryView: UIView!
    
    var categorys : [CategoryButton]!
    var currentCategory = Category.ALL
    override func awakeFromNib() {
        
    }
    
    func addExtensionView() {
        //init button
        let button1 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button1.setTitle("ALL", forState: .Normal)
        let button2 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 60, height: 22))
        button2.setTitle("OUTER", forState: .Normal)
        let button3 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button3.setTitle("TOP", forState: .Normal)
        let button4 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 70, height: 22))
        button4.setTitle("BOTTOM", forState: .Normal)
        let button5 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 55, height: 22))
        button5.setTitle("SUIT", forState: .Normal)
        let button6 = CategoryButton(frame: CGRect(x: 0, y: 0, width: 50, height: 22))
        button6.setTitle("ACC", forState: .Normal)
        
        categorys = [button1,button2,button3,button4,button5,button6]
        
        //add to View
        
        categoryView.backgroundColor = UIColor.whiteColor()
        let offsetX = (categoryView.frame.width - 335) / 7
        let midY = categoryView.bounds.height/2
        var stackX : CGFloat = 0.0
        for i in 0...5 {
            categoryView.addSubview(categorys[i])
            
            categorys[i].center = CGPoint(x: stackX + offsetX * CGFloat(i + 1) + categorys[i].bounds.width/2, y: midY)
            stackX += categorys[i].bounds.width
        }
        
        categorys[1].changeFillAlpha(true)
        
        //set action
        for button in categorys {
            button.addTarget(self, action: #selector(SearchViewController.tapButton(_:)), forControlEvents: .TouchUpInside)
        }
        
        
        
        
    }
    
    func tapButton(sender : CategoryButton) {
        for button in categorys {
            button.changeFillAlpha(false)
            
        }
        
        sender.changeFillAlpha(true)
        currentCategory = Category(rawValue: categorys.indexOf(sender)!)!
        print(currentCategory)
    }
 
}
