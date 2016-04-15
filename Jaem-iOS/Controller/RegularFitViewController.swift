//
//  RegularFitViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 7..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift



class RegularFitViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var clothesCollectionView: UICollectionView!
    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var compareCollectionView: UICollectionView!
    
    @IBOutlet weak var circleView: UIView!
    
    var interactionController : PanGestureInteractionController!
    
    var clothesSet = [AnyObject]()
    var types : [ClothesType]!
    var userName : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        types = setDefaultTypes()
        
        //set uicollectionView delegate
        clothesCollectionView.delegate = self
        clothesCollectionView.dataSource = self
        fitCollectionView.delegate = self
        fitCollectionView.dataSource = self
        compareCollectionView.delegate = self
        compareCollectionView.dataSource = self
        
        //set collectionViewFlowlayout
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 4 - 8
        layout.itemSize = CGSize(width: width, height: width)
        
        clothesCollectionView.collectionViewLayout = layout
        
        titleLabel.text = userName + "'S REGULAR FIT"
        
        fitCollectionView.alpha = 0
        compareCollectionView.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //set collectionViewFlowlayout
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 4 - 8
        layout.itemSize = CGSize(width: width, height: width)
        
        clothesCollectionView.collectionViewLayout = layout
        
        exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
        exitButton.tintColor = UIColor.whiteColor()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func setDefaultTypes() -> [ClothesType]{
        
        var set = [ClothesType]()
        set.append(ClothesType.runningShirt)
        set.append(ClothesType.Tshirts)
        set.append(ClothesType.sweater)
        set.append(ClothesType.shirts)
        set.append(ClothesType.vest)
        set.append(ClothesType.jacket)
        set.append(ClothesType.jumper)
        set.append(ClothesType.coats)
        set.append(ClothesType.padding)
        set.append(ClothesType.pants)
        set.append(ClothesType.shorts)
        set.append(ClothesType.skirt)
        return set

    }
    
    // MARK: ACTION
    
    @IBAction func tapExit(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
extension RegularFitViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == clothesCollectionView {
            return 12
        } else if collectionView == fitCollectionView {
            return 1
        } else {
            return clothesSet.count + 1
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == clothesCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TypeCell", forIndexPath: indexPath) as! TypeCell
            cell.icon.image =  UIImage(named: types[indexPath.row].rawValue)
            return cell
        } else if collectionView == fitCollectionView {
           
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
            return cell
            
            
            
        } else {
            if indexPath.row < clothesSet.count {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath) as! AddCell
                return cell
            }
        }
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == clothesCollectionView {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseOut, animations: { 
                self.fitCollectionView.alpha = 1.0
                self.compareCollectionView.alpha = 1.0
                }, completion: nil)
            
            let type = types[indexPath.row]
            
            
        }
    }
    
    
    
    //MARK : UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimationController(present: true)
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CircleTransitionAnimationController(present: false)
    }
    /*
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
    */
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        return CirclePresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
}
