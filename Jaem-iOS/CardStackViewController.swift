//
//  CardStackViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 21..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct Card {
    var title : String
    var color : String
}

class CardStackViewController: UIViewController {

    var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    @IBOutlet weak var CardStackView: UICollectionView!
    var cardIsExpanded : Bool!  // true : expanded  , false : folded
    
    var cardData : [Card]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //fold Tabbarbutton
        cardIsExpanded = false
        
        //collectionView delegate
        CardStackView.delegate = self
        CardStackView.dataSource = self
        
        //segue to first Tab VC
        let firstIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        performSegueWithIdentifier("GoMyBody", sender: CardStackView.cellForItemAtIndexPath(firstIndexPath))
        
        //gesture Recognizer
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(CardStackViewController.panning(_:)))
        self.CardStackView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CardStackViewController.tapping(_:)))
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        //set card
        cardData = setCard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        CardStackView.frame = CGRectMake(0, view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)

    }
    
    //MARK: Setting
    
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
        
        if CGRectContainsPoint(CardStackView.frame, location) {
            if cardIsExpanded == false {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.CardStackView.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 2 * CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    

                    
                    self.cardIsExpanded = true
                    
                    }, completion: nil)
            }
        } else {
            if cardIsExpanded == true {
                UIView.animateWithDuration(0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.CardStackView.frame = CGRectMake(0, self.view.frame.height - CardStackLayoutConstant.Cell().visibleCellHeight - 8 , self.view.frame.width , 2 * CardStackLayoutConstant.Cell().visibleCellHeight + CardStackLayoutConstant.Cell().actualCellHeight  + 8)
                    self.cardIsExpanded = false
                    
                    }, completion: nil)
            }
        }
    }
    
    func panning(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(view)
        
        recognizer.view?.center = CGPoint(x: recognizer.view!.center.x, y: recognizer.view!.center.y + translation.y)
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    

    
}

extension CardStackViewController : UICollectionViewDelegate, UICollectionViewDataSource , UIGestureRecognizerDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardStackCell", forIndexPath: indexPath) as! CardStackCell
        
        cell.title.text = cardData[indexPath.row].title
        cell.cardView.backgroundColor = getColor(cardData[indexPath.row].color)
        
        return cell
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        
        if cardIsExpanded == true {
            
            if let _ = gestureRecognizer as? UITapGestureRecognizer {
                
                if touch.view != CardStackView {
                    return true
                } else {
                    return false
                }
                
            } else if let _ = gestureRecognizer as? UIPanGestureRecognizer {
                
                if touch.view == CardStackView {
                    return true
                } else {
                    return false
                }
                
            } else {
                return false
            }
            
        } else {
            
            if touch.view == CardStackView {
                return true
            } else {
                return false
            }
            
        }
    }
    
}
