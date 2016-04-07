//
//  RegularFitViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 7..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

struct ClothesType {
    var title : String
    
    
}

class RegularFitViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var clothesCollectionView: UICollectionView!
    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var compareCollectionView: UICollectionView!
    
    @IBOutlet weak var circleView: UIView!
    
    var clothesSet = [AnyObject]()
    var types : [ClothesType]!
    
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
        set.append(ClothesType(title: "runningShirt"))
        set.append(ClothesType(title: "Tshirts"))
        set.append(ClothesType(title: "sweater"))
        set.append(ClothesType(title: "shirts"))
        set.append(ClothesType(title: "vest"))
        set.append(ClothesType(title: "jacket"))
        set.append(ClothesType(title: "jumper"))
        set.append(ClothesType(title: "coats"))
        set.append(ClothesType(title: "padding"))
        set.append(ClothesType(title: "pants"))
        set.append(ClothesType(title: "shorts"))
        set.append(ClothesType(title: "skirt"))
        return set

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
extension RegularFitViewController : UICollectionViewDelegate, UICollectionViewDataSource , UIViewControllerTransitioningDelegate{
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
            cell.icon.image =  UIImage(named: types[indexPath.row].title)
            return cell
        } else if collectionView == fitCollectionView {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
            return cell
        }
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return CircleTransitionAnimationController()
    }
}
