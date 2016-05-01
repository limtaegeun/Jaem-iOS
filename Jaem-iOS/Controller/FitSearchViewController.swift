//
//  FitSearchViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 12..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class FitSearchViewController: UIViewController {

    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var searchedClothesCollectionView: UICollectionView!
    
    @IBOutlet weak var exitButton: UIButton!
    
    var mySize : MyBodySize!
    var mySizeArray : [Dictionary<String,String>]!
    var clothesSet = [Clothes]()
    
    var checkOtherClothes : Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set collectionView delegate
        fitCollectionView.delegate = self
        fitCollectionView.dataSource = self
        
        searchedClothesCollectionView.delegate = self
        searchedClothesCollectionView.dataSource = self
        
        fitCollectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        searchedClothesCollectionView.contentInset = UIEdgeInsets(top: 60, left: 0, bottom: 0, right: 0)
        
        let realm = try! Realm()
        let data = realm.objects(MyBodySize)
        mySize = data.last
        
        mySizeArray = parseToArray(mySize)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
        exitButton.tintColor = UIColor.whiteColor()
        
        let layout = UICollectionViewFlowLayout()
        let width = view.frame.width / 2
        layout.itemSize = CGSize(width: width, height: 250)
        
        fitCollectionView.collectionViewLayout = layout
        searchedClothesCollectionView.collectionViewLayout = layout
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

    func parseToArray(object :MyBodySize) -> [Dictionary<String,String>] {
        var array = [Dictionary<String,String>]()
        var dic = [String:String]()
        let targetClothes = clothesSet.first
        if targetClothes!.category == ClothesCategory.TOP.rawValue || targetClothes!.category == ClothesCategory.OUTER.rawValue || targetClothes!.category == ClothesCategory.SUIT.rawValue || targetClothes!.category == ClothesCategory.DRESS.rawValue {
            if object.shoulder != 0 {
                dic["title"] = "어깨너비"
                dic["value"] = "\(object.shoulder)"
                array.append(dic)
            }
            if object.chest != 0 {
                dic["title"] = "가슴둘레"
                dic["value"] = "\(object.chest)"
                array.append(dic)
                
            }
            if object.waist != 0 {
                dic["title"] = "허리둘레"
                dic["value"] = "\(object.waist)"
                array.append(dic)
            }
            if object.upperArm != 0 {
                dic["title"] = "팔둘레"
                dic["value"] = "\(object.upperArm)"
                array.append(dic)
                
            }
            if object.reach != 0 {
                dic["title"] = "팔길이"
                dic["value"] = "\(object.reach)"
                array.append(dic)
                
            }
        } else if targetClothes!.category == ClothesCategory.BOTTOM.rawValue {
            if object.waist != 0 {
                dic["title"] = "허리둘레"
                dic["value"] = "\(object.waist)"
                array.append(dic)
            }
            if object.pelvis != 0 {
                dic["title"] = "골반둘레"
                dic["value"] = "\(object.pelvis)"
                array.append(dic)
                
            }
            if object.hips != 0 {
                dic["title"] = "엉덩이둘레"
                dic["value"] = "\(object.hips)"
                array.append(dic)
                
            }
            if object.thigh != 0 {
                dic["title"] = "허벅지둘레"
                dic["value"] = "\(object.thigh)"
                array.append(dic)
                
            }
            
            if object.calf != 0 {
                dic["title"] = "종아리둘레"
                dic["value"] = "\(object.calf)"
                array.append(dic)
                
            }
            
            if object.legLength != 0 {
                dic["title"] = "다리길이"
                dic["value"] = "\(object.legLength)"
                array.append(dic)
                
            }
        }
        
        
        
        return array
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
            return clothesSet.count
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == fitCollectionView {
            if indexPath.row == 0 {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
                cell.sizeArray = mySizeArray
                cell.defaultLabel.text = clothesSet.first?.category
                //present SizeData
                cell.addLabels()
                return cell
            } else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath) as! AddCell
                
                return cell
            }
            
            
        } else {
        
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
            
            cell.targetClothes = clothesSet[indexPath.row]
            cell.titleLabel.text = clothesSet[indexPath.row].name
            cell.sizeLabel.text = clothesSet[indexPath.row].typicalSize
            cell.addLabels()
            return cell
        
        }
        
        
    }
    
    
    
    
    
    
    //MARK : UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AppearAnimationController()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimationController()
    }
    
    func presentationControllerForPresentedViewController(presented: UIViewController, presentingViewController presenting: UIViewController, sourceViewController source: UIViewController) -> UIPresentationController? {
        
        return DimmingPresentationController(presentedViewController: presented, presentingViewController: presenting)
    }
    
}
