//
//  NoDeviceViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 27..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class NoDeviceViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var explainImageView: UIImageView!
    
    var measureStep : [MeasureTerm]?
    var requireStep = true
    
    var picker : UIPickerView?
    var indexs = [CGFloat]()
    
    var presentRow = [0,0,0,0,0,0,0,0,0,0,0,0]
    
    var textfields = [UITextField]()
    var nowTextfield : UITextField?
    
    var gender : Gender?
    
    var dataToSave = MyBodySize()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setMeasureTerm(true)
        
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let realm = try! Realm()
        gender = Gender(rawValue: (realm.objects(UserInfo).first?.gender)!)
        
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "SKIP")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0,4))
        skipButton.titleLabel!.attributedText = attributeString
        
        dataToSave.index = dataToSave.IncrementaID()
        
        explainImageView.image = UIImage(named: "noDeviceDefault")
    }

    
    
    override func viewDidAppear(animated: Bool) {
        let width = (CGRectGetWidth(view.frame) - 32 - 10) / 2
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: 45)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationItem.title = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setMeasureTerm(require : Bool)  {
        var set = [MeasureTerm]()
        if require == true {
            set.append(MeasureTerm(title: "SHOULDER",write: false))
            set.append(MeasureTerm(title: "WAIST",write: false))
            set.append(MeasureTerm(title: "CHEST", write: false))
            set.append(MeasureTerm(title: "HIPS",write: false))
            set.append(MeasureTerm(title: "THIGH",write: false))
            
        } else {
            textfields.removeAll()
            set.append(MeasureTerm(title: "HEAD",write: false))
            set.append(MeasureTerm(title: "UPPERARM",write: false))
            set.append(MeasureTerm(title: "NECK",write: false))
            set.append(MeasureTerm(title: "CALF",write: false))
            set.append(MeasureTerm(title: "PELVIS",write: false))
            set.append(MeasureTerm(title: "REACH",write: false))
            set.append(MeasureTerm(title: "LEG LENGTH",write: false))
            requireStep = false
        }
        
        measureStep = set
        collectionView?.reloadData()
        
    }
    
    func setPickerView(textField: UITextField) {
        picker = UIPickerView()
        textfields.append(textField)
        if let picker = self.picker {
            picker.sizeToFit()
            picker.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            picker.delegate = self
            picker.dataSource = self
            picker.showsSelectionIndicator = true
            
            textField.inputView = picker
            
            //add a done button
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.Default
            toolbar.translucent = true
            toolbar.tintColor = nil
            toolbar.sizeToFit()
            
            let doneButton  = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.dismissPicker) )
            toolbar.setItems([doneButton], animated: false)
            
            textField.inputAccessoryView = toolbar
            // set Notification
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.pickerViewWillshow(_:)), name: "UITextFieldTextDidBeginEditingNotification", object: nil)
            
            //creat ages Array
            for index in 0...250 {
                indexs.append(CGFloat(index))
                indexs.append(CGFloat(index) + 0.5)
            }
            
        }
    }
    
    func dismissPicker() {
        if ((nowTextfield?.isFirstResponder()) != nil) {
            nowTextfield!.resignFirstResponder()
        }
        
        chackData()
        
    }
    
    
   
    
    func pickerViewWillshow(notification : NSNotification) {
        if let textfield =  notification.object as? UITextField {
            nowTextfield = textfield
        }
        if nowTextfield!.isFirstResponder() {
        
            if let textfield =  notification.object as? UITextField {
                
                if let textfieldIndex = textfields.indexOf(textfield) {
                
                    picker?.reloadAllComponents()
                    picker?.selectRow(requireStep ? presentRow[textfieldIndex] : presentRow[textfieldIndex + 5], inComponent: 0, animated: true)
                    
                    if requireStep == true {
                        stepLabel.text = "\(textfieldIndex + 1) OF 5 STEPS"
                    } else {
                        stepLabel.text = "\(textfieldIndex + 1) OF 7 STEPS"
                    }
                    
                    //change image 
                    if gender == .Male {
                        if requireStep == true {
                            explainImageView.image = UIImage(named: "NM\(textfieldIndex + 1).png")
                        } else {
                            explainImageView.image = UIImage(named: "NM\(textfieldIndex + 6).png")

                        }
                    } else {
                        if requireStep == true {
                            explainImageView.image = UIImage(named: "NF\(textfieldIndex + 1).png")
                        } else {
                            explainImageView.image = UIImage(named: "NF\(textfieldIndex + 6).png")
                            
                        }
                    }
                    
                    
                    //set init value
                    let pickerString = "\(indexs[requireStep ? presentRow[textfieldIndex] : presentRow[textfieldIndex + 5]])CM"
                    let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
                    
                    attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
                    
                    nowTextfield?.attributedText = attributeString
                
                }
            }
        }
    }
    
    func askNextStep() {
        let alert = UIAlertController(title: "조금 더 상세하게 기록하시겠어요?" , message: "더욱 정밀한 추천을 위해 몸의 몇 부분을 추가로 기록합니다.", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "추가 기록하기", style: .Default, handler: {(_) in
            self.requireStep = false
            self.setMeasureTerm(self.requireStep)
            self.stepLabel.text = "1 OF 7 STEPS"
            self.chackData()
        })
        alert.addAction(action)
        let skipAction = UIAlertAction(title: "건너뛰기", style: .Default, handler: { (_) in
            self.performSegueWithIdentifier("GetAnotherSizeFromNoDevice", sender: self)
        })
        alert.addAction(skipAction)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "GetAnotherSizeFromNoDevice" {
            let dv = segue.destinationViewController as! AdditionInfoViewController
            dv.dataToSave = self.dataToSave
        }
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    

    func saveData() {
        for i in 0...11 {
            switch i {
            case 0:
                dataToSave.shoulder = Double(presentRow[i])/2
            case 1:
                dataToSave.waist = Double(presentRow[i])/2
            case 2:
                dataToSave.chest = Double(presentRow[i])/2
            case 3:
                dataToSave.hips = Double(presentRow[i])/2
            case 4:
                dataToSave.thigh = Double(presentRow[i])/2
            case 5:
                dataToSave.head = Double(presentRow[i])/2
            case 6:
                dataToSave.upperArm = Double(presentRow[i])/2
            case 7:
                dataToSave.neck = Double(presentRow[i])/2
            case 8:
                dataToSave.calf = Double(presentRow[i])/2
            case 9:
                dataToSave.pelvis = Double(presentRow[i])/2
            case 10:
                dataToSave.reach = Double(presentRow[i])/2
            case 11:
                dataToSave.legLength = Double(presentRow[i])/2
            default:
                return
            }
            
        }
        print(dataToSave)
        
    }
    
    func chackData() {
        //check if there is value zero
        var thereIsZeroValue = false
        for i in 0...4 {
            if presentRow[i] == 0 {
                thereIsZeroValue = true
            }
        }
        
        if !thereIsZeroValue && requireStep {
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "NEXT")
            
            attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0,4))
            skipButton.setAttributedTitle(attributeString, forState: .Normal)
        }
    }
    
    //MAKR : ACTION
    
    @IBAction func tapSkip(sender: AnyObject) {
        var thereIsZeroValue = false
        for i in 0...4 {
            if presentRow[i] == 0 {
                thereIsZeroValue = true
            }
        }
        saveData()
        if !thereIsZeroValue && requireStep {
            askNextStep()
        } else {
            self.performSegueWithIdentifier("GetAnotherSizeFromNoDevice", sender: self)
        }
    }
    
}

extension NoDeviceViewController : UICollectionViewDelegate, UICollectionViewDataSource, UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource  {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (measureStep?.count ?? 0) + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("NoDeviceCell", forIndexPath: indexPath) as! NoDeviceCell
        
        if measureStep != nil {
            if indexPath.row == measureStep!.count - 1 {
                cell.titleLabel.text = ""
                cell.sizeTextField.placeholder = ""
                cell.sizeTextField.userInteractionEnabled = false
            } else if indexPath.row == measureStep!.count {
                cell.titleLabel.text = measureStep![indexPath.row - 1].title
                setPickerView(cell.sizeTextField)
            } else {
                cell.titleLabel.text = measureStep![indexPath.row].title
                setPickerView(cell.sizeTextField)

            }
        }
        
        return cell
        
        
    }
    
    
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return "\(indexs[row])"
        
            
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.nowTextfield!.isFirstResponder() {
            //get value of pickerView
            let pickerString = "\(indexs[row])CM"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
            
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
            
            nowTextfield?.attributedText = attributeString
            //self.DataToSend["gender"] = genders[row]
            let index = textfields.indexOf(nowTextfield!)
            if requireStep == true {
                presentRow[index!] = row
            } else {
                presentRow[index! + 5] = row
            }
            
            
        }
        
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return indexs.count
        
    }
    
    
}