//
//  RegisterViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var regiButton: UIButton!
    @IBOutlet weak var agreeLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorViewTopConstraint: NSLayoutConstraint!
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

    func appearErrorView()  {
        
        errorViewTopConstraint.constant = 0
        
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: action
    
    @IBAction func tapRegister(sender: AnyObject) {
        
    }
    
    @IBAction func tapLogin(sender: AnyObject) {
    }
}

extension RegisterViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
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
    
}