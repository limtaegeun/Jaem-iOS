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
    
    @IBOutlet weak var dragIconView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        /*
        cardView = UIView(frame: CGRectMake(0.0, 0.0, UIScreen.mainScreen().bounds.width, frame.height))
        cardView.backgroundColor = self.getRandomColor()
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        self.contentView.addSubview(cardView)
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: -2)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10.0).CGPath
        self.clipsToBounds = false
*/
    }
    
    
    override func applyLayoutAttributes(layoutAttributes: UICollectionViewLayoutAttributes) {
        print("applylayout")
        /*
        cardView.frame = frame
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 10.0).CGPath
*/
        
        cardView = UIView(frame: CGRectMake(5.0, 0.0, frame.width - (2 * 5) , frame.height))
        cardView.backgroundColor = self.getRandomColor()
        cardView.layer.cornerRadius = 10.0
        cardView.clipsToBounds = true
        self.contentView.insertSubview(cardView, belowSubview: dragIconView)
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOffset = CGSize(width: 0, height: -1)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = UIBezierPath(roundedRect: CGRectMake(bounds.origin.x + 3, bounds.origin.y, bounds.width - 6, bounds.height - 6) , cornerRadius: 10.0).CGPath
        self.layer.shadowRadius = 3
        self.clipsToBounds = false
        
    }
    
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue:CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
