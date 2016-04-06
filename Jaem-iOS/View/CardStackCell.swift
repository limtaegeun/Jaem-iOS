//
//  CardStackCell.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 23..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CardStackCell: UICollectionViewCell {
    
    var cardView : UIView!
    var layerColor : String?
    
    var dragIconView: UIView!
    var title: UILabel!

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //set views
        dragIconView = CardStackIcon(frame: CGRect(x: self.center.x - 6.5 , y: 8, width: 13, height: 6))
        dragIconView.backgroundColor = UIColor.clearColor()
        
        title = UILabel(frame: CGRect(x: center.x - 100 , y: CGRectGetMaxY(dragIconView.frame) + 5, width: 200, height: 15))
        title.textAlignment = NSTextAlignment.Center
        title.textColor = UIColor.whiteColor()
        addSubview(dragIconView)
        addSubview(title)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {

        cardView = UIView(frame: CGRectMake(5.0, 0.0, frame.width - (2 * 5) , frame.height))
        cardView.backgroundColor = UIColor.clearColor()
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        cardView.userInteractionEnabled = false
        self.contentView.insertSubview(cardView, belowSubview: dragIconView)
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRectMake(bounds.origin.x + 3, bounds.origin.y, bounds.width - 6, bounds.height - 6) , cornerRadius: 10.0).CGPath
        self.layer.shadowRadius = 3
        self.clipsToBounds = false
        
    }
    
    
    
}
