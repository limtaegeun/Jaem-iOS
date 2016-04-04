//
//  LoginViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var regiButton: UIButton!
    @IBOutlet weak var helpLabel: UILabel!
    
    var buttonBorderView : TextFieldBorderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        LoginButton.userInteractionEnabled = false
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(animated: Bool) {
        let borderView1 = TextFieldBorderView(frame: CGRect(x: userNameTextField.frame.origin.x - 10, y: userNameTextField.frame.origin.y, width: userNameTextField.frame.width + 20, height: userNameTextField.frame.height ))
        let borderView2 = TextFieldBorderView(frame: CGRect(x: passwordTextField.frame.origin.x - 10, y: passwordTextField.frame.origin.y, width: passwordTextField.frame.width + 20, height: passwordTextField.frame.height ))
        buttonBorderView = TextFieldBorderView(frame: LoginButton.frame)
        
        borderView1.backgroundColor = UIColor.clearColor()
        borderView2.backgroundColor = UIColor.clearColor()
        buttonBorderView.backgroundColor = UIColor.clearColor()

        subView.insertSubview(borderView1, belowSubview: userNameTextField)
        subView.insertSubview(borderView2, belowSubview: passwordTextField)
        subView.insertSubview(buttonBorderView, belowSubview: LoginButton)
        
        LoginButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)

        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "로그인 상세 정보를 잊으셨나요? 로그인 관련 도움을 받으세요")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(18, 9))
        helpLabel.attributedText = attributeString
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "계정이 없으신가요?   가입하기")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(13, 4))
        regiButton.titleLabel!.attributedText = attributeString2
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LoginViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if userNameTextField.text?.characters.count != 0 && passwordTextField.text?.characters.count != 0 {
            buttonBorderView.changeFillAlpha(true)
            LoginButton.userInteractionEnabled = true
            LoginButton.titleLabel?.textColor = UIColor.whiteColor()
        } else {
            buttonBorderView.changeFillAlpha(false)
            LoginButton.userInteractionEnabled = false
            LoginButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)


        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
