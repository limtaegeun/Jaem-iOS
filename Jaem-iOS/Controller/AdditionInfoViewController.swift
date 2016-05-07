//
//  AdditionInfoViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 4..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift
import CoreBluetooth

class AdditionInfoViewController: UIViewController {

    
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var birthTextField: UITextField!
    
    @IBOutlet weak var completeButton: UIButton!
    
    @IBOutlet weak var topSizeClickView: SizeClickView!
    @IBOutlet weak var bottomSizeClickView: SizeClickView!
    
    var picker : UIPickerView?
    var datePicker : UIDatePicker?
    
    var indexs = [Int]()
    
    var presentHeightRow = 170
    var presentWeightRow = 70
    
    var dataToSave : MyBodySize!
    
    var loaded = false
    
    var targetPeripheral : CBPeripheral?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setPickerView()
        setDatePickerView()
        
        birthTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded == false {
            loaded = true
            
            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "기록 완료")
            
            attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 5))
            completeButton.titleLabel?.attributedText = attributeString2
            
            topSizeClickView.setButton(85, max: 115, term: 5)
            bottomSizeClickView.setButton(28, max: 36, term: 1)
            
        }
        /*
        let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = NSTextAlignment.Center
        
        let attributes = [
            NSForegroundColorAttributeName : UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1),
            NSFontAttributeName : UIFont(name: "AppleSDGothicNeo-Regular", size: 12)!,
            NSParagraphStyleAttributeName : paragraphStyle
        ]
        
        let placeHolder = NSAttributedString(string: "CLCIK HERE !", attributes: attributes)
        heightTextField.attributedPlaceholder = placeHolder
        weightTextField.attributedPlaceholder = placeHolder
        birthTextField.attributedPlaceholder = placeHolder
        */
        
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if targetPeripheral != nil {
            btDiscoverySharedInstance.peripheralList.removeAll()
            btDiscoverySharedInstance.bleService?.reset()
            btDiscoverySharedInstance.centralManager?.cancelPeripheralConnection(targetPeripheral!)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPickerView() {
        picker = UIPickerView()
        
        if let picker = self.picker {
            picker.sizeToFit()
            picker.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            picker.delegate = self
            picker.dataSource = self
            picker.showsSelectionIndicator = true
            
            heightTextField.inputView = picker
            weightTextField.inputView = picker
            
            //add a done button
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.Default
            toolbar.translucent = true
            toolbar.tintColor = nil
            toolbar.sizeToFit()
            
            let doneButton  = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.dismissPicker) )
            toolbar.setItems([doneButton], animated: false)
            
            heightTextField.inputAccessoryView = toolbar
            weightTextField.inputAccessoryView = toolbar
            // set Notification
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.pickerViewWillshow(_:)), name: "UITextFieldTextDidBeginEditingNotification", object: nil)
            
            //creat ages Array
            for index in 1...250 {
                indexs.append(index)
            }
            
        }
    }
    
    func setDatePickerView() {
        datePicker = UIDatePicker()
        datePicker?.addTarget(self, action: #selector(self.dateIsChanged(_:)), forControlEvents: UIControlEvents.ValueChanged)
        if let picker = self.datePicker {
            picker.sizeToFit()
            picker.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
            picker.datePickerMode = .Date
            birthTextField.inputView = picker
            
            let toolbar = UIToolbar()
            toolbar.barStyle = UIBarStyle.Default
            toolbar.translucent = true
            toolbar.tintColor = nil
            toolbar.sizeToFit()
            
            let doneButton  = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(self.dismissPicker) )
            toolbar.setItems([doneButton], animated: false)
            
            birthTextField.inputAccessoryView = toolbar
        }
    }
    func dismissPicker() {
        if heightTextField.isFirstResponder() {
            heightTextField.resignFirstResponder()
            dataToSave.height = Double( presentHeightRow )
        }
            
        else if weightTextField.isFirstResponder() {
            weightTextField.resignFirstResponder()
            dataToSave.weight = Double(presentWeightRow)
        } else {
            birthTextField.resignFirstResponder()
            
            let realm =  try! Realm()
            let me = realm.objects(UserInfo).first
            
            try! realm.write({
                me?.birthDay = datePicker!.date
            })
            
            
        }
        
    }
    func dateIsChanged(sender: AnyObject) {
        // change birth nsdate to string
        let birthNSDate = datePicker?.date
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = " yy'.'MM'.'dd"
        let birthString = dateFormatter.stringFromDate(birthNSDate!)
        
        birthTextField.text = birthString
        
    }
    func checkData(){
        //check
    }
    
    func pickerViewWillshow(notification : NSNotification) {
        
        if heightTextField.isFirstResponder() {
            picker?.reloadAllComponents()
            picker?.selectRow(presentHeightRow, inComponent: 0, animated: true)
            
            
            //set init value
            let pickerString = "\(indexs[presentHeightRow])CM"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
            
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
            
            heightTextField.attributedText = attributeString
            //self.DataToSend["gender"] = indexs[presentGenderPickerRow]
            
        }
            
        else if weightTextField.isFirstResponder() {
            picker?.reloadAllComponents()
            picker?.selectRow(presentWeightRow, inComponent: 0, animated: true)
            
            let pickerString = "\(indexs[presentWeightRow])KG"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
            
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
            
            weightTextField.attributedText = attributeString
            //self.DataToSend["age"] =  "\(ages[presentAgePickerRow])"
            
            
        } else if birthTextField.isFirstResponder() {
            // change birth nsdate to string
            let birthNSDate = datePicker?.date
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = " yy'.'MM'.'dd"
            let birthString = dateFormatter.stringFromDate(birthNSDate!)
            
            birthTextField.text = birthString
        }
        
        
    }
    
    func parseDataToSend() -> Dictionary<String,AnyObject>  {
        var dic = Dictionary<String,AnyObject>()
        
        dic["ShoulderWidth"] = dataToSave.shoulder
        dic["BreastPeripheral"] = dataToSave.chest
        dic["WaistCircumference"] = dataToSave.waist
        dic["HipCircumference"] = dataToSave.hips
        dic["ThighCircumference"] = dataToSave.thigh
        
        
        return dic
    }
    
    //MARK : - ACTION
    
    @IBAction func tapComplete(sender: AnyObject) {
        
        var dataToSend : Dictionary<String,AnyObject>?
        dataToSend = parseDataToSend()
        
        //설정되지 않는 값을 기존 값으로 채워 넣기
        print(dataToSave)
        let realm = try! Realm()
        if let lastData = realm.objects(MyBodySize).last {
            if dataToSave.shoulder == 0 {
                dataToSave.shoulder = lastData.shoulder
            }
            if dataToSave.chest == 0 {
                dataToSave.chest = lastData.chest
            }
            if dataToSave.waist == 0 {
                dataToSave.waist = lastData.waist
            }
            if dataToSave.hips == 0 {
                dataToSave.hips = lastData.hips
            }
            if dataToSave.thigh == 0 {
                dataToSave.thigh = lastData.thigh
            }
            if dataToSave.head == 0 {
                dataToSave.head = lastData.head
            }
            if dataToSave.neck == 0 {
                dataToSave.neck = lastData.neck
            }
            if dataToSave.pelvis == 0 {
                dataToSave.pelvis = lastData.pelvis
            }
            if dataToSave.upperArm == 0 {
                dataToSave.upperArm = lastData.upperArm
            }
            if dataToSave.calf == 0 {
                dataToSave.calf = lastData.calf
            }
            if dataToSave.reach == 0 {
                dataToSave.reach = lastData.reach
            }
            if dataToSave.legLength == 0 {
                dataToSave.legLength = lastData.legLength
            }
            if dataToSave.height == 0 {
                dataToSave.height = lastData.height
            }
            if dataToSave.weight == 0 {
                dataToSave.weight = lastData.weight
            }
        }
        
        //서버에 사이즈 값 등록
        
        //ToDo: network request
        
        
        
        
        
        
        try! realm.write {
            realm.add(dataToSave)
            //To Do: network
            dismissViewControllerAnimated(true, completion: nil)
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

extension AdditionInfoViewController : UITextFieldDelegate , UIPickerViewDelegate, UIPickerViewDataSource {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == birthTextField {
            
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if heightTextField.isFirstResponder() {
            return "\(indexs[row])"
        }
            
        else if weightTextField.isFirstResponder() {
            return "\(indexs[row])"
        } else {
            return ""
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if heightTextField.isFirstResponder() {
            //get value of pickerView
            let pickerString = "\(indexs[row])CM"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
            
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
            
            heightTextField.attributedText = attributeString
            //self.DataToSend["gender"] = genders[row]
            presentHeightRow = row
            checkData()
        }
        else {
            //get value of pickerView
            let pickerString = "\(indexs[row])KG"
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: pickerString)
            
            attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "AppleSDGothicNeo-Regular", size: 13)!, range: NSMakeRange(pickerString.characters.count - 2, 2))
            
            weightTextField.attributedText = attributeString
            //self.DataToSend["age"] =  "\(indexs[row])"
            presentWeightRow = row
            checkData()
            
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if weightTextField.isFirstResponder() || heightTextField.isFirstResponder() {
            return indexs.count
        } else {
            return 1
        }
    }
    
}


