//
//  CardTabBarController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 5..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

struct Card {
    var title : String
    var color : String
}


class CardTabBarController: UITabBarController {

    var cardStackView : UICollectionView!
    
    var cardData : [Card]!
    var cardIsExpanded : Bool!  // true : expanded  , false : folded

    override func viewDidLoad() {
        super.viewDidLoad()
        
                
        //fold Tabbarbutton
        cardIsExpanded = false
        
        //setcollectionview
        setCollectionView()
        //gesture Recognizer
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CardTabBarController.panning(_:)))
        panGestureRecognizer.delegate = self
        self.cardStackView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardTabBarController.tapping(_:)))
        tapGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        //set card
        cardData = setCard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        cardStackView.frame =  CGRectMake(0, view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)        
    }
    
    func setCollectionView() {
        cardStackView = UICollectionView(frame: CGRectMake(0, view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8), collectionViewLayout: CardStackLayout())
        cardStackView.delegate = self
        cardStackView.dataSource = self
        cardStackView.registerClass(CardStackCell.self, forCellWithReuseIdentifier: "CardStackCell")
        cardStackView.backgroundColor = UIColor.clearColor()
        cardStackView.reloadData()
        cardStackView.userInteractionEnabled = true
        view.addSubview(cardStackView)
        
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setCard() -> [Card] {
        var cardSet = [Card]()
        cardSet.append(Card(title: "MY BODY", color: "green"))
        cardSet.append(Card(title: "MY CLOSET", color: "red"))
        cardSet.append(Card(title: "MY STYLE", color: "yellow"))
        
        return cardSet
    }
    func getColor(color: String) -> UIColor{
        let Green = UIColor(red: 98 / 255, green: 214 / 255, blue: 181 / 255, alpha: 1)
        let Red = UIColor(red: 240 / 255, green: 118 / 255, blue: 131 / 255, alpha: 1)
        let yellow = UIColor(red: 249 / 255, green: 202 / 255, blue: 70 / 255, alpha: 1)
        
        if color == "green" {
            return Green
            
        } else if color == "red" {
            return Red
        } else if color == "yellow" {
            return yellow
        } else {
            return UIColor.clearColor()
        }
        
    }
    
    //MARK : gesture recognizer handler
    func tapping(recognizer: UITapGestureRecognizer) {
        let location = recognizer.locationInView(view)
        
        if CGRectContainsPoint(cardStackView.frame, location) {
            if cardIsExpanded == false {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.cardStackView.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 2 * CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    
                    
                    
                    self.cardIsExpanded = true
                    
                    }, completion: nil)
            }
        } else {
            if cardIsExpanded == true {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.cardStackView.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    self.cardIsExpanded = false
                    
                    }, completion: nil)
            }
        }
    }
    
    func panning(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        
        let actualHeight = CardStackLayoutConstant.Cell().actualCellHeight
        let visibleHeight = CardStackLayoutConstant.Cell().visibleCellHeight
        
        recognizer.view?.center = CGPoint(x: recognizer.view!.center.x,
                                          y: max(recognizer.view!.center.y + translation.y, view.frame.height - ((visibleHeight*2 + actualHeight + 8)/2 - visibleHeight*3) ))
        recognizer.setTranslation(CGPoint(x: 0, y: 0), inView: view)
        
        if recognizer.state == .Ended {
            
            UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                if self.cardIsExpanded == false {
                    recognizer.view?.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 2 * CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    self.cardIsExpanded = true
                } else {
                    recognizer.view?.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    self.cardIsExpanded = false
                }
                }, completion: nil)
            
        }
        
    }
    
    

}

extension CardTabBarController : UICollectionViewDelegate, UICollectionViewDataSource , UIGestureRecognizerDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardStackCell", forIndexPath: indexPath) as! CardStackCell
        
        cell.title.text = cardData[indexPath.row].title
        cell.cardView.backgroundColor = getColor(cardData[indexPath.row].color)
        
        if indexPath.row != 0 {
            cell.dragIconView.hidden = true
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        print("select \(indexPath.row)")
        self.selectedIndex = indexPath.row
    }
    
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if cardIsExpanded == true {
            
            if let _ = gestureRecognizer as? UITapGestureRecognizer {
                
                if CGRectContainsPoint(cardStackView.frame, touch.locationInView(view)) {
                    
                    return false
                } else {
                    return true
                }
                
            } else if let _ = gestureRecognizer as? UIPanGestureRecognizer {
                if CGRectContainsPoint(cardStackView.frame, touch.locationInView(view)) {
                    return true
                } else {
                    return false
                }
                
                
            } else {
                return false
            }
            
        } else {
            
            if CGRectContainsPoint(cardStackView.frame, touch.locationInView(view)) {
                return true
            } else {
                return false
            }
            
            
        }
 
        
    }
    
    
}
