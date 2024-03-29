//
//  ClosetDetailViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 25..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift
import HCSStarRatingView

class ClosetDetailViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    
    @IBOutlet weak var fitCollectionView: UICollectionView!
    @IBOutlet weak var compareCollectionView: UICollectionView!
    
    @IBOutlet weak var sizeRatingView: SizeRatingView!
    @IBOutlet weak var heartRatingView: HCSStarRatingView!
    
    
    @IBOutlet weak var fittingLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var mySize : MyBodySize?
    var mySizeArray : [Dictionary<String,String>]!
    var targetClothes : Clothes!
    var loaded = false
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        fitCollectionView.delegate = self
        fitCollectionView.dataSource = self
        compareCollectionView.delegate = self
        compareCollectionView.dataSource = self
        
        sizeRatingView.delegate = self
        
        let realm = try! Realm()
        let data = realm.objects(MyBodySize)
        mySize = data.last
        
        if mySize != nil {
            mySizeArray = parseToArray(mySize!)
        } else {
            mySize = MyBodySize()
            mySizeArray = parseToArray(mySize!)
        }
        
        
        
        
        heartRatingView.value = CGFloat( targetClothes.rating)
        
        
        // Do any additional setup after loading the view.
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .Custom
        transitioningDelegate = self
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded == false {
            loaded = true
            
            let layout2 = UICollectionViewFlowLayout()
            let width2 = view.frame.width / 2
            layout2.itemSize = CGSize(width: width2, height: 250)
            
            fitCollectionView.collectionViewLayout = layout2
            compareCollectionView.collectionViewLayout = layout2
            
            exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
            exitButton.tintColor = UIColor.whiteColor()
            
            sizeRatingView.setButton()
            
            
        }
        
        if targetClothes.fitting != 0 {
            sizeRatingView.selectValue(targetClothes.fitting)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func parseToArray(object :MyBodySize) -> [Dictionary<String,String>] {
        var array = [Dictionary<String,String>]()
        var dic = [String:String]()
        
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
    
    func tapFitting(value : Int) {
        
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

    @IBAction func heartValueChanged(sender: AnyObject) {
        if heartRatingView.value > 0 && heartRatingView.value <= 1 {
            ratingLabel.text = "완전 별로에요"
            
        } else if heartRatingView.value > 1 && heartRatingView.value <= 2 {
            ratingLabel.text = "마음에 안들어요"
        } else if heartRatingView.value > 2 && heartRatingView.value <= 3 {
            ratingLabel.text = "그럭저럭 괜찮아요"
        } else if heartRatingView.value > 3 && heartRatingView.value <= 4 {
            ratingLabel.text = "마음에 들어요"
        } else if heartRatingView.value > 4 && heartRatingView.value <= 5 {
            ratingLabel.text = "완전 내 스타일이에요"
        }
        
        let realm = try! Realm()
        try! realm.write({ 
            targetClothes.rating = Double( heartRatingView.value)
        })
        
    }
}

extension ClosetDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIViewControllerTransitioningDelegate , SizeRatingViewDelegate {
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
            
            cell.targetClothes = targetClothes
            cell.titleLabel.text = targetClothes.name
            cell.sizeLabel.text = targetClothes.typicalSize
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
    
    //SizeRatingViewDelegate
    
    func sizeRatingTapButton(value : Int) {
        switch value {
        case 1:
            fittingLabel.text = "너무 작아요"
        case 2:
            fittingLabel.text = "좀 작은 편이에요"
        case 3:
            fittingLabel.text = "딱 내 사이즈에요"
        case 4:
            fittingLabel.text = "좀 큰 편이에요"
        case 5:
            fittingLabel.text = "너무 커요"
        default:
            fittingLabel.text = "..."
        }
        
        let realm = try! Realm()
        try! realm.write({
            targetClothes.fitting = value
        })
    }
}
