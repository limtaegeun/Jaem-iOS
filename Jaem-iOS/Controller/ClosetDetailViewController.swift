//
//  ClosetDetailViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class ClosetDetailViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var compareCollectionView: UICollectionView!
    
    @IBOutlet weak var sizeRatingView: SizeRatingView!
    @IBOutlet weak var ratingLabel: UILabel!
    var mySize : MyBodySize!
    var mySizeArray : [Dictionary<String,String>]!
    var targetClothes : JaemClothes!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if test == true {
            
            
            targetClothes = JaemClothes(category: ClothesCategory.TOP, type: ClothesType.skirt, brand: "dd", name: "dd", image: UIImage(imageLiteral:"1.png"))
        }
        
        fitCollectionView.delegate = self
        fitCollectionView.dataSource = self
        compareCollectionView.delegate = self
        compareCollectionView.dataSource = self
        
        let realm = try! Realm()
        let data = realm.objects(MyBodySize)
        mySize = data.first
        
        mySizeArray = parseToArray(mySize)
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let layout2 = UICollectionViewFlowLayout()
        let width2 = view.frame.width / 2
        layout2.itemSize = CGSize(width: width2, height: 250)
        
        fitCollectionView.collectionViewLayout = layout2
        
        exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
        exitButton.tintColor = UIColor.whiteColor()
        
        sizeRatingView.setButton()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func parseToArray(object :MyBodySize) -> [Dictionary<String,String>] {
        var array = [Dictionary<String,String>]()
        var dic = [String:String]()
        
        if targetClothes.category == .TOP && targetClothes.category == .OUTER && targetClothes.category == .SUIT && targetClothes.category == .DRESS {
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
        } else if targetClothes.category == .BOTTOM {
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

extension ClosetDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         if collectionView == fitCollectionView {
            
            return 1
            
        } else {
            return  1
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == fitCollectionView {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
            
            cell.sizeArray = mySizeArray
            //present SizeData
            cell.addLabels()
            
            return cell
            
            
            
        } else {
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
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
