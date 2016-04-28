//
//  BodyViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 24..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import HidingNavigationBar
import RealmSwift

struct ParsingData {
    var section : String
    var title : String
    var value : CGFloat
    var require : Bool
    var unit : String
    
}

var test = true

class BodyViewController: UIViewController {

    @IBOutlet weak var AvatarView: UIView!
    var hidingNavBarManager: HidingNavigationBarManager?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    var SizeDataSet : [ParsingData]?
    
    @IBOutlet weak var LeftCircleView: UIView!
    @IBOutlet weak var RightCircleView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var graphButton: UIButton!
    @IBOutlet weak var measureButton: UIButton!
    
    var userName : String!
    
    
    var interactionController : PanGestureInteractionController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.tabBar.hidden = true
        //test
        
        if test == true {
            let realm = try! Realm()
            
            let testSize = MyBodySize()
            testSize.index = 0
            testSize.shoulder = 90
            testSize.chest = 99
            testSize.waist = 90
            testSize.hips = 88
            testSize.thigh = 48
            testSize.head = 40
            testSize.neck = 33
            testSize.pelvis = 44
            testSize.upperArm = 33
            testSize.calf = 40
            testSize.height = 176
            testSize.weight = 70
            
            try! realm.write({
                
                realm.create(UserInfo.self, value: ["email":"imori333@gmail.com","userName":"fuckingOri"], update: true)
                
                realm.add(testSize, update:  true)
                /*
                realm.create(MyBodySize.self, value:["index" : 0,
                    "shoulder": 90.0,
                    "chest":99.0,
                    "waist":88.0,
                    "hips":99.0,
                    "head":33.0,
                    "neck":33.0,
                    "pelvis": 33.0,
                    "legLength":33.0,
                    "height":176.0,
                    "weight":70.0] , update:)
                 */
            })
 
            
        }
        
        let realm = try! Realm()
        userName = realm.objects(UserInfo).first!.userName
        
                
        //set hidingNavBar
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: scrollView)
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        // Do any additional setup after loading the view.
        
        sizeCollectionView.dataSource = self
        sizeCollectionView.delegate = self
        
        //interactionController = PanGestureInteractionController(view: AvatarView, direction: .Right)
        //interactionController?.delegate = self
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)
        
        //set SizeData
        let realm = try! Realm()
        if let bodySize = realm.objects(MyBodySize).last {
            //avatarImageView.image =
            SizeDataSet = makeParsingData(bodySize)
            
            //set recently Measure Time
            let recentDate = bodySize.date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy'.'MM'.'dd"
            
            dateLabel.text = dateFormatter.stringFromDate(recentDate)
            
        } else {
            avatarImageView.image = JaemViewStyleKit.imageOfEmptyAvatar
            
            //set recently Measure Time
            let recentDate = NSDate()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy'.'MM'.'dd"
            dateLabel.text = dateFormatter.stringFromDate(recentDate)
            
            let zero = MyBodySize()
            SizeDataSet = makeParsingData(zero)
        }
        
        //set Views
        graphButton.setImage(JaemIconStyleKit.imageOfGraphIcon, forState: .Normal)
        measureButton.setImage(JaemIconStyleKit.imageOfMeasureButton, forState: .Normal)
        userNameLabel.text = "HI " + userName.uppercaseString
        
        
        sizeCollectionView.reloadData()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //print("viewDidAppear")
        
        let realm = try! Realm()
        if let _ = realm.objects(UserInfo).first {
            print("realm userinfo exist")
            
        } else {
            print("segue")

            performSegueWithIdentifier("GoRegister", sender: self)
        }
        
        if let _ = realm.objects(MyBodySize).first {
            print("realm mybodySize exist")
            
        } else {
            print("dont have size")
        }
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeParsingData(object : MyBodySize?) -> [ParsingData] {
        var set = [ParsingData]()
        if object != nil {
            set.append(ParsingData(section: "body", title: "HEIGHT", value: CGFloat( object!.height ) , require: true, unit: "cm"))
            set.append(ParsingData(section: "body", title: "WEIGHT", value: CGFloat( object!.weight) , require: true, unit: "kg"))
            
            set.append(ParsingData(section: "top", title: "SHOULDER", value: CGFloat( object!.shoulder) , require: true, unit: "cm"))
            set.append(ParsingData(section: "top", title: "CHEST", value: CGFloat( object!.chest) , require: true, unit: "cm"))
            set.append(ParsingData(section: "top", title: "WAIST", value: CGFloat( object!.waist), require: true, unit: "cm"))
            set.append(ParsingData(section: "top", title: "HEAD", value: CGFloat( object!.head) , require: false, unit: "cm"))
            set.append(ParsingData(section: "top", title: "NECK", value: CGFloat( object!.neck) , require: false, unit: "cm"))
            set.append(ParsingData(section: "top", title: "PELVIS", value: CGFloat( object!.pelvis) , require: false, unit: "cm"))
            set.append(ParsingData(section: "top", title: "UPPERARM", value: CGFloat( object!.upperArm) , require: false, unit: "cm"))
            set.append(ParsingData(section: "top", title: "REACH", value: CGFloat( object!.reach), require: false, unit: "cm"))
            
            set.append(ParsingData(section: "bottom", title: "HIPS", value: CGFloat( object!.hips), require: true, unit: "cm"))
            set.append(ParsingData(section: "bottom", title: "THIGH", value: CGFloat( object!.thigh), require: true, unit: "cm"))
            set.append(ParsingData(section: "bottom", title: "CALF", value: CGFloat( object!.calf), require: false, unit: "cm"))
            set.append(ParsingData(section: "bottom", title: "LEG LENGTH", value: CGFloat( object!.legLength), require: false, unit: "cm"))
        }
        return set
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        
        
    }
    
    
    //MARK: - Action
    
    @IBAction func tapSearch(sender: AnyObject) {
        performSegueWithIdentifier("GoSearch", sender: self)
    }
    
    @IBAction func tapMeasureButton(sender: AnyObject) {
        performSegueWithIdentifier("GoMeasure", sender: self)
        /*
        let navi = MeasureNaviController()
        let rootVC = self.view.window?.rootViewController as! CardStackViewController
        rootVC.presentViewController(navi, animated: true, completion: nil)
        */
        
        
    }

    @IBAction func tapGraphButton(sender: AnyObject) {
    }
    
    
}

extension BodyViewController : UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource, PanGestureInteractionControllerDelegate {
    
    //MARK : Scrollview delegate
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        //hidingNavBarManager?.shouldScrollToTop()
        
        return true
    }
    
    
    
    //MARK: collectionView delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "body"
                
            })
            return datas!.count
        } else if section == 1 {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "top"
            })
            return datas!.count
        } else {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "bottom"
            })
            return datas!.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
            sectionHeaderView.title.text = "BODY"
            return sectionHeaderView
        } else if indexPath.section == 1 {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
            sectionHeaderView.title.text = "TOP"
            return sectionHeaderView

        } else {
            let sectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "SectionHeader", forIndexPath: indexPath) as! SectionHeaderView
            sectionHeaderView.title.text = "BOTTOM"
            return sectionHeaderView

        }
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "body"
                
            })
            let cell : SizeDataCell
            let data = datas![indexPath.row]
            if data.unit == "cm" {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell

            } else {
                cell = collectionView.dequeueReusableCellWithReuseIdentifier("KGCell", forIndexPath: indexPath) as! SizeDataCell

            }
            cell.title.text = data.title
            cell.value.text = (data.value != 0) ?  "\(data.value)" : "__"
            
            return cell
        } else if indexPath.section == 1 {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "top"
            })
            
            let data = datas![indexPath.row]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell
            cell.title.text = data.title
            cell.value.text = (data.value != 0) ?  "\(data.value)" : "__"
            if data.require == false {
                cell.title.alpha = 0.5
                cell.value.alpha = 0.5
            }
            return cell
        } else {
            let datas = SizeDataSet?.filter({ (data : ParsingData) -> Bool in
                data.section == "bottom"
            })
            
            let data = datas![indexPath.row]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell
            cell.title.text = data.title
            cell.value.text = (data.value != 0) ?  "\(data.value)" : "__"
            if data.require == false {
                cell.title.alpha = 0.5
                cell.value.alpha = 0.5
            }
            
            return cell
        }
        
        
    }
    
    //MARK : PanGestureInteractionControllerDelegate
    
    func didBeginPanning() {
        performSegueWithIdentifier("GoFit", sender: self)
    }
    
}
