//
//  AdditionInfoViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 4..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setPickerView()
        setDatePickerView()
        
        birthTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
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
        
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "기록 완료")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 5))
        completeButton.titleLabel?.attributedText = attributeString2
        
        topSizeClickView.setButton(85, max: 115, term: 5)
        bottomSizeClickView.setButton(28, max: 36, term: 1)
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
            
            let doneButton  = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(AdditionInfoViewController.dismissPicker) )
            toolbar.setItems([doneButton], animated: false)
            
            heightTextField.inputAccessoryView = toolbar
            weightTextField.inputAccessoryView = toolbar
            // set Notification
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AdditionInfoViewController.pickerViewWillshow(_:)), name: "UITextFieldTextDidBeginEditingNotification", object: nil)
            
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
            
            let doneButton  = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(AdditionInfoViewController.dismissPicker) )
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
    
    //MARK : - ACTION
    
    @IBAction func tapComplete(sender: AnyObject) {
        
        //설정되지 않는 값을 기존 값으로 채워 넣기
        
        let realm = try! Realm()
        try! realm.write {
            //realm.add(dataToSave)
            //To Do: network
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


