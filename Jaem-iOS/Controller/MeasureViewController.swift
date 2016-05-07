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
import RealmSwift


class MeasureViewController: UIViewController {

    @IBOutlet weak var pickerView: AKPickerView!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var exitButton: UIBarButtonItem!
    
    @IBOutlet weak var explainImageView: UIImageView!
    
    var dataToSave = MyBodySize()
    
    var containerViewController : MeasureContainerViewController!
    var minNumber : Int = 0
    var maxNumber : Int = 150
    
    var currentStep : Int!
    var requireStep = true
    
    var size = [String]()
    
    var length : Double = 0
    var targetPeripheral : CBPeripheral?
    var gender : Gender?
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
        
        //get my gender
        let realm = try! Realm()
        if let me = realm.objects(UserInfo).first {
            gender = Gender(rawValue: me.gender)
            
            //first image
            if gender == .Male {
                explainImageView.image = UIImage(named: "M1.png")
                
            } else {
                explainImageView.image = UIImage(named: "F1.png")
            }
        }
        
        
        dataToSave.index = dataToSave.IncrementaID()
        
    }

    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
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
        
        if segue.identifier == "GetAnotherSize" {
            let dv = segue.destinationViewController as! AdditionInfoViewController
            dv.dataToSave = self.dataToSave
        }
    }
    
    //MARK  : ACTION
    
    
    
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
        containerViewController.measureStep?[currentStep].write = true
        containerViewController.collectionView!.performBatchUpdates({
            self.containerViewController.collectionView!.reloadSections(NSIndexSet(index: 0))
            }, completion: nil)
    }
    
    @IBAction func tapExit(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func currentMeasureStep(step : Int)  {
        currentStep = step
        let collectionView = containerViewController.collectionView
        pickerView.selectItem(0, animated: true)
        if gender == .Male {
            if requireStep == true {
                explainImageView.image = UIImage(named: "M\(step + 1).png")
            } else {
                explainImageView.image = UIImage(named: "M\(step + 6).png")
                
            }
        } else {
            if requireStep == true {
                explainImageView.image = UIImage(named: "F\(step + 1).png")
            } else {
                explainImageView.image = UIImage(named: "F\(step + 6).png")
                
            }
        }
        
        //question if you want skip?
        if requireStep == true {
            stepLabel.text = "\(currentStep + 1) OF 5 STEPS"
            if step == 4 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "NEXT")
                
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
                skipButton.setAttributedTitle(attributeString, forState: .Normal)
                
            }
            if step == 5 {
                askNextStep()
                
                return
            }
        } else {
            stepLabel.text = "\(currentStep + 1) OF 7 STEPS"
            if step == 0 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "SKIP")
                
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
                skipButton.setAttributedTitle(attributeString, forState: .Normal)
            }
            if step == 6 {
                let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "NEXT")
                
                attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 4))
                skipButton.setAttributedTitle(attributeString, forState: .Normal)
            }
            if step == 7 {
                self.performSegueWithIdentifier("GetAnotherSize", sender: self)
                return
            }
        }
        
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
    
    func saveData(data : Double, step: Int) {
        
        if requireStep == true {
            switch step {
            case 0:
                dataToSave.shoulder = data
            case 1:
                dataToSave.waist = data
            case 2:
                dataToSave.chest = data
            case 3:
                dataToSave.hips = data
            case 4:
                dataToSave.thigh = data
            default : break
            }
        } else {
            switch step {
            case 0:
                dataToSave.head = data
            case 1:
                dataToSave.upperArm = data
            case 2:
                dataToSave.neck = data
            case 3:
                dataToSave.calf = data
            case 4:
                dataToSave.pelvis = data
            case 5:
                dataToSave.reach = data
            case 6:
                dataToSave.legLength = data
            default:
                return
            }
        }
        
        
        
        
        //set write
        containerViewController.measureStep?[currentStep].write = true
        containerViewController.collectionView!.performBatchUpdates({
            self.containerViewController.collectionView!.reloadSections(NSIndexSet(index: 0))
            }, completion: nil)
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
        var out : UInt32 = 0
        
        let data = characteristic.value
        data?.getBytes(&out, length: sizeof(UInt32))
        print("getADC:")
        print(out)
        length = Double( Int(out) / 2)
        pickerView.selectItem(Int(length), animated: true)
        
        saveData(length, step: currentStep)
        
        
    }
    
    func getNextSig(characteristic: CBCharacteristic, error: NSError?) {
        var out : UInt32 = 0
        
        let data = characteristic.value
        data?.getBytes(&out, length: sizeof(UInt32))
        print("getNextSig:")
        print(out)
        
        
        
        if out == 1 {
            currentMeasureStep(currentStep + 1)
        }
    }
    
}
