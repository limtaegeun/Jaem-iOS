//
//  MeasureViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 28..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import AKPickerView_Swift

class MeasureViewController: UIViewController {

    @IBOutlet weak var pickerView: AKPickerView!
    
    var containerViewController : MeasureContainerViewController!
    var minNumber : Int = 0
    var maxNumber : Int = 150
    
    var currentStep : Int!
    
    var size = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStep = 0
        
        setPickerViewCell()
        // Do any additional setup after loading the view.
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPickerViewCell()  {
        for index in minNumber...maxNumber {
            let mm : CGFloat = CGFloat(index) + 0.5
            
            size.append("  " + index.description + "  ")
            size.append("  " + mm.description + "  ")
            
        }
        setPickerView()
    }
    
    func setPickerView()  {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.font = UIFont(name: "HelveticaNeue", size:30)!
        pickerView.textColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        pickerView.highlightedFont =  UIFont(name: "HelveticaNeue", size:30)!
        pickerView.highlightedTextColor = UIColor.blackColor()
        pickerView.pickerViewStyle = .Flat
        pickerView.maskDisabled = true
        pickerView.reloadData()
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "ViewEmbed" {
            containerViewController = segue.destinationViewController as! MeasureContainerViewController
            
        }
    }
    
    @IBAction func nextStep(sender: AnyObject) {
        currentMeasureStep(currentStep + 1)
        pickerView.selectItem(50, animated: true)
    }
    
    func currentMeasureStep(step : Int)  {
        currentStep = step
        let collectionView = containerViewController.collectionView
        
        containerViewController.selectStep(collectionView!, step: step)
        
    }
    
}

extension MeasureViewController : AKPickerViewDelegate, AKPickerViewDataSource {
    //MARK: AKPickerViewDataSource
    func numberOfItemsInPickerView(pickerView: AKPickerView) -> Int {
        return size.count
    }
    
    func pickerView(pickerView: AKPickerView, titleForItem item: Int) -> String {
        return size[item]
    }
    
    
    
    //MARK: AKPickerViewDelegate
    
    func pickerView(pickerView: AKPickerView, didSelectItem item: Int) {
        print("select \(size[item])")
    }
    
    
    
    
}
