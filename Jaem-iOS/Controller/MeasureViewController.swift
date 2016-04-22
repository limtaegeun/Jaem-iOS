//
//  MeasureViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 28..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import AKPickerView_Swift
import CoreBluetooth



class MeasureViewController: UIViewController {

    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
    var bodySize = MyBodySize()
    
    var containerViewController : MeasureContainerViewController!
    var minNumber : Int = 0
    var maxNumber : Int = 150
    
    var currentStep : Int!
    var requireStep = true
    
    var size = [String]()
    
    var length : Int = 0
    var targetPeripheral : CBPeripheral?
    override func viewDidLoad() {
        super.viewDidLoad()
        currentStep = 0
        
        setPickerViewCell()
        
        exitButton.image = JaemIconStyleKit.imageOfExit_black
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "SKIP")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
        skipButton.titleLabel?.attributedText = attributeString
        
        btDiscoverySharedInstance.bleService?.delegate = self
        targetPeripheral = btDiscoverySharedInstance.bleService?.peripheral
    }

    override func viewDidDisappear(animated: Bool) {
        btDiscoverySharedInstance.peripheralList.removeAll()
        btDiscoverySharedInstance.bleService?.reset()
        btDiscoverySharedInstance.centralManager?.cancelPeripheralConnection(targetPeripheral!)
        
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
            containerViewController.delegate = self
        }
    }
    
    
    
    @IBAction func tapSkip(sender: AnyObject) {
        if currentStep == 4 && requireStep {
            askNextStep()
        } else {
            self.performSegueWithIdentifier("GetAnotherSize", sender: self)
        }
    }
    
    @IBAction func nextStep(sender: AnyObject) {
        currentMeasureStep(currentStep + 1)
        pickerView.selectItem(50, animated: true)
    }
    
    func currentMeasureStep(step : Int)  {
        currentStep = step
        let collectionView = containerViewController.collectionView
        
        
        
        //question if you want skip?
        if requireStep == true {
            stepLabel.text = "\(currentStep + 1) OF 5 STEPS"
            if step == 4 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "NEXT")
                
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
                skipButton.titleLabel?.attributedText = attributeString
                
            }
            if step == 5 {
                askNextStep()
                
                return
            }
        } else {
            stepLabel.text = "\(currentStep + 1) OF 7 STEPS"
            if step == 8 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "NEXT")
                
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
                skipButton.titleLabel?.attributedText = attributeString
            }
            if step == 9 {
                self.performSegueWithIdentifier("GetAnotherSize", sender: self)
                return
            }
        }
        
        explainLabel.text = presentExplainText(currentStep)
        containerViewController.selectStep(collectionView!, step: currentStep)
        
    }
    
    func askNextStep() {
        let alert = UIAlertController(title: "조금 더 상세하게 기록하시겠어요?" , message: "더욱 정밀한 추천을 위해 몸의 몇 부분을 추가로 기록합니다.", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "추가 기록하기", style: .Default, handler: {(_) in
            self.requireStep = false
            self.containerViewController.setMeasureTerm(self.requireStep)
            self.currentStep = 0
            self.containerViewController.currentStep = 0
            self.currentMeasureStep(self.currentStep)
        })
        alert.addAction(action)
        let skipAction = UIAlertAction(title: "건너뛰기", style: .Default, handler: { (_) in
            self.performSegueWithIdentifier("GetAnotherSize", sender: self)
        })
        alert.addAction(skipAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func presentExplainText(step : Int) -> String {
        let text : String
        
        if requireStep == true {
            switch step {
            case 0:
                text = "양 어깨의 끝점 사이를 측정"
            case 1:
                text = "가슴의 가장 높은 부분을 수평으로 측정"
            case 2:
                text = "배꼽 위 허리의 가장 가는 부분을 수평으로 측정"
            case 3:
                text = "엉덩이 중 가장 높은 부분을 수평으로 측정"
            case 4:
                text = "허벅지의 가장 굵은 부분을 측정"
                
            default:
                text = "..."
            }
        } else {
            switch step {
            case 0:
                text = "이마의 가장 높은 부분을 측정"
            case 1:
                text = "목젖 아래를 수평으로 측정"
            case 2:
                text = "골반뼈 부분을 수평으로 측정"
            case 3:
                text = "팔뚝에서 가장 넓은 부분을 측정"
            case 4:
                text = "종아리의 가장 굵은 부분을 측정"
            case 5:
                text = "어깨 끝점에서 손목 뼈까지 측정"
            case 6:
                text = "허리에서부터 신발 굽 윗부분까지 측정"
            default:
                text = "..."
            }
        }
        
        return text
    }
    
}

extension MeasureViewController : AKPickerViewDelegate, AKPickerViewDataSource, MeasureContainerViewDelegate, btServiceDelegate {
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
    
    func measureContainerView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        currentMeasureStep(indexPath.row)
    }
    
    func getADCData(characteristic : CBCharacteristic, error : NSError?) {
        var out : UInt8 = 0
        
        let data = characteristic.value
        data?.getBytes(&out, length: sizeof(UInt8))
        print("getADC:")
        print(out)
        length = Int(out)
        pickerView.selectItem(length, animated: true)
    }
    
    func getNextSig(characteristic: CBCharacteristic, error: NSError?) {
        var out : UInt8 = 0
        
        let data = characteristic.value
        data?.getBytes(&out, length: sizeof(UInt8))
        print("getNextSig:")
        print(out)
        
        if out == 1 {
            currentMeasureStep(currentStep + 1)
        }
    }
    
}
