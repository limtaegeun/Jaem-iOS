//
//  RegisterViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var regiButton: UIButton!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorView: UIView!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var errorViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var subViewCenterYConstraint: NSLayoutConstraint!
    var DataToSend = Dictionary<String,String>()

    var userNameFlag = false
    var emailFlag = false
    var passwordFlag = false
    
    var buttonBorderView : TextFieldBorderView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        regiButton.userInteractionEnabled = false
        
        //attributeLabel
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "가입하면 jaem의 약관 및 개인정보취급방침에 동의하게 됩니다")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(11, 13))
        agreeLabel.attributedText = attributeString
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegisterViewController.tapping(_:)))
        subView.addGestureRecognizer(tapGestureRecognizer)
        
    }

    override func viewDidAppear(animated: Bool) {
        let borderView1 = TextFieldBorderView(frame: CGRect(x: userNameTextField.frame.origin.x - 10, y: userNameTextField.frame.origin.y, width: userNameTextField.frame.width + 20, height: userNameTextField.frame.height ))
        let borderView2 = TextFieldBorderView(frame: CGRect(x: passwordTextField.frame.origin.x - 10, y: passwordTextField.frame.origin.y, width: passwordTextField.frame.width + 20, height: passwordTextField.frame.height ))
        let borderView3 = TextFieldBorderView(frame: CGRect(x: emailTextField.frame.origin.x - 10, y: emailTextField.frame.origin.y, width: emailTextField.frame.width + 20, height: emailTextField.frame.height ))
        
        buttonBorderView = TextFieldBorderView(frame: regiButton.frame)
        
        borderView1.backgroundColor = UIColor.clearColor()
        borderView2.backgroundColor = UIColor.clearColor()
        borderView3.backgroundColor = UIColor.clearColor()
        buttonBorderView.backgroundColor = UIColor.clearColor()
        
        subView.insertSubview(borderView1, belowSubview: userNameTextField)
        subView.insertSubview(borderView2, belowSubview: passwordTextField)
        subView.insertSubview(borderView3, belowSubview:  emailTextField)
        subView.insertSubview(buttonBorderView, belowSubview: regiButton)
        
        regiButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "이미 계정이 있으신가요?   로그인")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(16, 3))
        loginButton.titleLabel?.attributedText = attributeString2

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isValidEmail(testStr:String) -> Bool {
        // println("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }

    func appearErrorView(message: String)  {
        errorView.hidden = false
        errorViewTopConstraint.constant = 0
        errorMessageLabel.text = message
        UIView.animateWithDuration(0.33, delay: 0, options: .CurveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (_) in
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, __int64_t(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
                self.errorViewTopConstraint.constant = -60
                UIView.animateWithDuration(0.33, animations: {
                    self.view.layoutIfNeeded()
                })
            })
            
            
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "GoAgreement" {
            let destinationVC = segue.destinationViewController as! AgreementViewController
            destinationVC.webSite = ""
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

    //MARK: action
    
    @IBAction func tapRegister(sender: AnyObject) {
        
        let me = UserInfo()
        if userNameFlag && emailFlag && passwordFlag {
            
        
            if DataToSend["name"] != nil {
                me.userName = DataToSend["name"]!
            }
            if DataToSend["email"] != nil {
                me.email = DataToSend["email"]!
            }
            
            let session = MySessionTask(sender: self)
            if let url = MyHost().urlWtihPathNameAboutMainServer("user/regi") {
                session.uploadTask(DataToSend, url: url, complete: { (data) in
                    if data != nil {
                        
                        if data!["stat"] as? String == "regi_success" {
                            if let realm = try? Realm() {
                                try! realm.write({
                                    realm.add(me)
                                })
                                self.dismissViewControllerAnimated(true, completion: nil)
                            }

                        } else {
                            self.appearErrorView("회원가입에 문제가 있습니다.")
                        }
                        
                        
                    } else {
                        self.appearErrorView("회원가입에 문제가 있습니다.")
                    }
                    }, errorHandler: { 
                        self.appearErrorView("네트워크에 문제가 있습니다.")
                })
            }
            
            
            
            
        
        }
        
    }
    
    @IBAction func tapLogin(sender: AnyObject) {
    }
    
    func tapping(recognizer : UITapGestureRecognizer)  {
        let location = recognizer.locationInView(self.subView)
        
        if CGRectContainsPoint(agreeLabel.frame, location) {
            performSegueWithIdentifier("GoAgreement", sender: self)
        }
    }
}

extension RegisterViewController : UITextFieldDelegate , UIGestureRecognizerDelegate{
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField == passwordTextField {
            subViewCenterYConstraint.constant = -50
            UIView.animateWithDuration(0.3, animations: { 
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == emailTextField {
            if isValidEmail(textField.text!) {
                DataToSend["email"] = textField.text
                emailFlag = true
            } else {
                appearErrorView("이 이메일은 사용할 수 없습니다.")
                
            }
        } else if textField == userNameTextField {
            if textField.text?.characters.count > 0 {
                DataToSend["name"] = textField.text
                userNameFlag = true
            }
        } else if textField == passwordTextField {
            if textField.text?.characters.count > 0 {
                DataToSend["password"] = textField.text
                
                subViewCenterYConstraint.constant = 0
                UIView.animateWithDuration(0.3, animations: {
                    self.view.layoutIfNeeded()
                })
                
                passwordFlag = true
            }
        }
        if userNameTextField.text?.characters.count != 0 && passwordTextField.text?.characters.count != 0 && emailTextField.text?.characters.count != 0 {
            buttonBorderView.changeFillAlpha(true)
            regiButton.userInteractionEnabled = true
            regiButton.titleLabel?.textColor = UIColor.whiteColor()
        } else {
            buttonBorderView.changeFillAlpha(false)
            regiButton.userInteractionEnabled = false
            regiButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
            
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
        
    }
    
    
    
    
    //MARK: UIGesgureRecognizer Delegate 
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        if CGRectContainsPoint(agreeLabel.frame, touch.locationInView(subView)) {
            return true
        } else {
            return false
        }
    }
    
    
}
