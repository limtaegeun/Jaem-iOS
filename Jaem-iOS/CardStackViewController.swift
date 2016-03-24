//
//  CardStackViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 21..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class CardStackViewController: UIViewController {

    var currentViewController: UIViewController?
    @IBOutlet var placeholderView: UIView!
    @IBOutlet weak var CardStackView: UICollectionView!
    var naviBar : UINavigationBar?
    var cardIsExpanded : Bool!  // true : expanded  , false : folded
    
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
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "panning:")
        self.CardStackView.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapping:")
        self.view.addGestureRecognizer(tapGestureRecognizer)
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let availableIdentifiers = ["GoMyBody", "GoMyCloset"]
        
        if availableIdentifiers.contains(segue.identifier!)  {
            
            //
            
        }
    }

    
}

extension CardStackViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CardStackCell", forIndexPath: indexPath)
        
        return cell
    }
    
    
    
}
