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
    
    var mySize : MyBodySize?
    var mySizeArray : [Dictionary<String,String>]?
    var clothesSet = [Clothes]()
    var clothesFromCloset = [Clothes]()
    var checkOtherClothes : Bool!
    
    var loaded = false
    
    var dummyArray = [String]()
    var dummySize = [MyBodySize]()
    var dummyDic = [[Dictionary<String,String>]]()
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
        if mySize != nil {
            mySizeArray = parseToArray(mySize!)
        } else {
            mySize = MyBodySize()
            mySizeArray = parseToArray(mySize!)
        }
        
        // Do any additional setup after loading the view.
        if checkOtherClothes == true {
            dummyData()
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded == false {
            loaded = true
            
            exitButton.setImage(JaemIconStyleKit.imageOfExitButton, forState: UIControlState.Normal)
            exitButton.tintColor = UIColor.whiteColor()
            
            let layout = UICollectionViewFlowLayout()
            let width = view.frame.width / 2
            layout.itemSize = CGSize(width: width, height: 200)
            
            fitCollectionView.collectionViewLayout = layout
            
            let layout2 = UICollectionViewFlowLayout()
            
            layout2.itemSize = CGSize(width: width - 10, height: 200)
            searchedClothesCollectionView.collectionViewLayout = layout2
        } else {
            fitCollectionView.reloadData()
        }
        
        
        
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

    func dummyData() {
        dummyArray.append(105.description)
        dummyArray.append(105.description)
        dummyArray.append(100.description)
        dummyArray.append("딱 내 사이즈에요")
        dummyArray.append("좀 작은 편이에요")
        dummyArray.append("좀 큰 편이에요")
        
        let size = MyBodySize()
        size.shoulder = 46.5
        size.calf = 96
        size.waist = 65
        size.upperArm = 37
        size.reach = 63
        
        dummySize.append(size)
        
        let size2 = MyBodySize()
        size2.shoulder = 49
        size2.calf = 96
        size2.waist = 67
        size2.upperArm = 40.5
        size2.reach = 63
        dummySize.append(size2)
        
        let size3 = MyBodySize()
        size3.shoulder = 45
        size3.calf = 92.5
        size3.waist = 63
        size3.upperArm = 39
        size3.reach = 62
        dummySize.append(size3)
        
        for size in dummySize {
            dummyDic.append( parseToArray(size))
        }
        
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
            return 1 + clothesFromCloset.count
        } else {
            if checkOtherClothes == true {
                return 3
            } else {
                return clothesSet.count
            }
            
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if collectionView == fitCollectionView {
            
            if checkOtherClothes == true {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
                
                //present SizeData
                cell.sizeArray = mySizeArray
                cell.defaultLabel.text = clothesSet.first?.category
                cell.addLabels()
                return cell
            } else {
                if indexPath.row < clothesFromCloset.count {
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MyRegularFitCell", forIndexPath: indexPath) as! MyRegularFitCell
                    
                    cell.targetClothes = clothesFromCloset[indexPath.row]
                    cell.titleLabel.text = clothesFromCloset[indexPath.row].name
                    cell.defaultLabel.text = clothesFromCloset[indexPath.row].typicalSize
                    
                    cell.addLabelsWithClothes()
                    return cell
                } else {
                    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("AddCell", forIndexPath: indexPath) as! AddCell
                    if clothesFromCloset.count != 0{
                        cell.titleLabel.hidden = true
                    }
                    
                    return cell
                }
            }
            
            
            
            
        } else {
            if checkOtherClothes == true {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
                
                cell.sizeArray = dummyDic[indexPath.row]
                cell.titleLabel.text = clothesSet[indexPath.row].name
                cell.sizeLabel.text = dummyArray[indexPath.row]
                cell.fittingLabel.text = dummyArray[indexPath.row + 3]
                cell.addLabelsFromOthers()
                return cell
                
            } else {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ClothesCell", forIndexPath: indexPath) as! ClothesCell
                
                cell.targetClothes = clothesSet[indexPath.row]
                cell.titleLabel.text = clothesSet[indexPath.row].name
                cell.sizeLabel.text = clothesSet[indexPath.row].typicalSize
                cell.addLabels()
                return cell
            }
            
            
            
        }
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if collectionView == fitCollectionView {
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) as? AddCell {
                performSegueWithIdentifier("ShowCloset", sender: cell)
            }
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
