//
//  MeasureContainerViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 30..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit



struct MeasureTerm {
    var title : String
    var write : Bool
}

protocol MeasureContainerViewDelegate : class{
    func measureContainerView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
}

class MeasureContainerViewController: UICollectionViewController {

    var measureStep : [MeasureTerm]!
    var currentStep : Int = 0
    var requireStep = true

    var delegate : MeasureContainerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMeasureTerm(true)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        collectionView?.contentOffset.x = (collectionView!.contentSize.width - self.view.frame.width) / 2
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    func setMeasureTerm(require : Bool)  {
        var set = [MeasureTerm]()
        if require == true {
            set.append(MeasureTerm(title: "SHOULDER",write: false))
            set.append(MeasureTerm(title: "CHEST", write: false))
            set.append(MeasureTerm(title: "WAIST",write: false))
            set.append(MeasureTerm(title: "HIPS",write: false))
            set.append(MeasureTerm(title: "THIGH",write: false))

        } else {
            set.append(MeasureTerm(title: "HEAD",write: false))
            set.append(MeasureTerm(title: "NECK",write: false))
            set.append(MeasureTerm(title: "PELVIS",write: false))
            set.append(MeasureTerm(title: "UPPERARM",write: false))
            set.append(MeasureTerm(title: "CALF",write: false))
            set.append(MeasureTerm(title: "REACH",write: false))
            set.append(MeasureTerm(title: "LEG LENGTH",write: false))
            requireStep = false
        }
        
        measureStep = set
        collectionView?.reloadData()
        
    }
    
    func selectStep(collectionView : UICollectionView  , step : Int ){
        currentStep = step
        if requireStep == false {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
                collectionView.contentOffset.x = min(CGFloat( 57 * step), collectionView.contentSize.width - self.view.frame.width)
                }, completion: nil)
        }
        //to animated Change
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
        return measureStep.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("MeasureStepCell", forIndexPath: indexPath) as! MeasureStepCell
        
        cell.titleLabel.text = measureStep[indexPath.row].title
        if currentStep == indexPath.row {
            cell.changeOvalColor(measureStep[indexPath.row].write, active: true)
        } else {
            cell.changeOvalColor(measureStep[indexPath.row].write, active: false)
        }
        
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        collectionView.deselectItemAtIndexPath(indexPath, animated: true)
        
        delegate?.measureContainerView(collectionView, didSelectItemAtIndexPath: indexPath)
        
                
    }

}
