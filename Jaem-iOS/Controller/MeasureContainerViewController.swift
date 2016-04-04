//
//  MeasureContainerViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 30..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

struct MeasureTerm {
    var title : String
    var require : Bool
    var top : Bool
}

class MeasureContainerViewController: UICollectionViewController {

    var measureStep : [MeasureTerm]!
    var currentStep : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        measureStep = setMeasureTerm()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func setMeasureTerm() -> [MeasureTerm] {
        var set = [MeasureTerm]()
        
        set.append(MeasureTerm(title: "HEAD", require: true, top: true))
        set.append(MeasureTerm(title: "NECK", require: true, top: true))
        set.append(MeasureTerm(title: "SHOULDER", require: true, top: true))
        set.append(MeasureTerm(title: "CHEST", require: true, top: true))
        set.append(MeasureTerm(title: "UPPERARM", require: true, top: true))
        set.append(MeasureTerm(title: "WRIST", require: false, top: true))
        set.append(MeasureTerm(title: "STOMACH", require: false, top: true))
        set.append(MeasureTerm(title: "SHIRT LENGTH", require: false, top: true))
        set.append(MeasureTerm(title: "WAIST", require: true, top: false))
        set.append(MeasureTerm(title: "HIPS", require: true, top: false))
        set.append(MeasureTerm(title: "THIGH", require: true, top: false))
        set.append(MeasureTerm(title: "RISE", require: false, top: false))
        set.append(MeasureTerm(title: "CUFF", require: false, top: false))
        set.append(MeasureTerm(title: "LEG LENGTH", require: false, top: false))
        
        return set
        
        
    }
    
    func selectStep(collectionView : UICollectionView  , step : Int ){
        currentStep = step
        
        collectionView.performBatchUpdates({
            collectionView.reloadSections(NSIndexSet(index: 0))
            }, completion: nil)
        
    
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 14
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MeasureStepCell", forIndexPath: indexPath) as! MeasureStepCell
        
        cell.titleLabel.text = measureStep[indexPath.row].title
        if currentStep == indexPath.row {
            cell.changeOvalColor(measureStep[indexPath.row].require, active: true)
        } else {
            cell.changeOvalColor(measureStep[indexPath.row].require, active: false)
        }
        
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        selectStep(collectionView, step: indexPath.row)
        
                
    }

}
