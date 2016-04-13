//
//  FitSearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class FitSearchViewController: UIViewController {

    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var searchedClothesCollectionView: UICollectionView!
    
    @IBOutlet weak var exitButton: UIButton!
    
    var clothesSet = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set collectionView delegate
        fitCollectionView.delegate = self
        fitCollectionView.dataSource = self
        
        searchedClothesCollectionView.delegate = self
        searchedClothesCollectionView.dataSource = self
        
        fitCollectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        searchedClothesCollectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
        exitButton.tintColor = UIColor.whiteColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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

extension FitSearchViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == fitCollectionView {
            return 1
        } else {
            return clothesSet.count + 1
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == fitCollectionView {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
                return cell
            } else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath) as! AddCell
                return cell
            }
            
            
        } else {
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
            return cell
        
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
