//
//  BodyViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 24..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import HidingNavigationBar

struct dummyData {
    var section : String
    var title : String
    
    var value : CGFloat
    
    var require : Bool
    
    var unit : String
    
    
}

class BodyViewController: UIViewController {

    var hidingNavBarManager: HidingNavigationBarManager?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    var SizeDataSet : [dummyData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //test 
        
        SizeDataSet =  makeDummyData()
        
        //set hidingNavBar
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: scrollView)
        
        //navigationBar background clearColor
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.translucent = true
        
        // Do any additional setup after loading the view.
        
        sizeCollectionView.dataSource = self
        sizeCollectionView.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hidingNavBarManager?.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeDummyData() -> [dummyData] {
        var set = [dummyData]()
        
        set.append(dummyData(section: "body", title: "HEIGHT", value: 181, require: true, unit: "cm"))
        set.append(dummyData(section: "body", title: "WEIGHT", value: 76, require: true, unit: "kg"))
        set.append(dummyData(section: "top", title: "HEAD", value: 22, require: true, unit: "cm"))
        set.append(dummyData(section: "top", title: "NECK", value: 20.5, require: true, unit: "cm"))
        set.append(dummyData(section: "top", title: "SHOULDER", value: 54, require: true, unit: "cm"))
        set.append(dummyData(section: "top", title: "CHEST", value: 92, require: true, unit: "cm"))
        set.append(dummyData(section: "top", title: "UPPERARM", value: 33, require: true, unit: "cm"))
        set.append(dummyData(section: "top", title: "WRIST", value: 18, require: false, unit: "cm"))
        set.append(dummyData(section: "top", title: "STOMACH", value: 81, require: false, unit: "cm"))
        set.append(dummyData(section: "top", title: "SHIRT LENGTH", value: 106, require: false, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "WAIST", value: 86, require: true, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "HIPS", value: 98, require: true, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "THIGH", value: 56.5, require: true, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "RISE", value: 33, require: false, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "CUFF", value: 24, require: false, unit: "cm"))
        set.append(dummyData(section: "bottom", title: "LEG LENGTH", value: 93, require: false, unit: "cm"))
        
        return set
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GoMeasure" {
            
        }
        
        
    }
    
    
    //MARK: - Action
    
    
    @IBAction func tapMeasureButton(sender: AnyObject) {
        performSegueWithIdentifier("GoMeasure", sender: self)
        /*
        let navi = MeasureNaviController()
        let rootVC = self.view.window?.rootViewController as! CardStackViewController
        rootVC.presentViewController(navi, animated: true, completion: nil)
        */
        
        
    }

}

extension BodyViewController : UIScrollViewDelegate , UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK : Scrollview delegate
    func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        
        return true
    }
    
    
    
    //MARK: collectionView delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 8
        } else {
            return 6
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
            let datas = SizeDataSet?.filter({ (data : dummyData) -> Bool in
                data.section == "body"
                
            })
            
            let data = datas![indexPath.row]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell
            cell.title.text = data.title
            cell.value.text = "\(data.value)"
            return cell
        } else if indexPath.section == 1 {
            let datas = SizeDataSet?.filter({ (data : dummyData) -> Bool in
                data.section == "top"
            })
            
            let data = datas![indexPath.row]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell
            cell.title.text = data.title
            cell.value.text = "\(data.value)"
            if data.require == false {
                cell.title.alpha = 0.5
                cell.value.alpha = 0.5
            }
            return cell
        } else {
            let datas = SizeDataSet?.filter({ (data : dummyData) -> Bool in
                data.section == "bottom"
            })
            
            let data = datas![indexPath.row]
            
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CMCell", forIndexPath: indexPath) as! SizeDataCell
            cell.title.text = data.title
            cell.value.text = "\(data.value)"
            if data.require == false {
                cell.title.alpha = 0.5
                cell.value.alpha = 0.5
            }
            
            return cell
        }
        
        
    }
    
    
}
