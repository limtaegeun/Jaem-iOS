//
//  FindPasswordViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import Alamofire

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var SendButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var buttonBorderView : TextFieldBorderView!
    var loaded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        SendButton.userInteractionEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if loaded == false {
            loaded = true
            
            let borderView1 = TextFieldBorderView(frame: CGRect(x: emailTextField.frame.origin.x - 10, y: emailTextField.frame.origin.y, width: emailTextField.frame.width + 20, height: emailTextField.frame.height ))
            
            buttonBorderView = TextFieldBorderView(frame: SendButton.frame)
            
            borderView1.backgroundColor = UIColor.clearColor()
            buttonBorderView.backgroundColor = UIColor.clearColor()
            
            subView.insertSubview(borderView1, belowSubview: emailTextField)
            subView.insertSubview(buttonBorderView, belowSubview: SendButton)
            
            SendButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
            
            let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "다른 문제가 있나요? jaem 고객센터를 이용해보세요")
            
            attributeString1.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(12, 9))
            helpButton.titleLabel?.attributedText = attributeString1
            
            let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "로그인으로 돌아가기")
            
            attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 10))
            BackButton.titleLabel?.attributedText = attributeString2
        }
        
        
    }

    @IBAction func tapSendButton(sender: AnyObject) {
        let  email = emailTextField.text
        
        if let url = MyHost().urlWtihPathNameAboutMainServer("user/password/search?email=\(email)") {
            Alamofire.request(.GET, url, encoding: .JSON).responseJSON(completionHandler: { (response) in
                debugPrint(response)
                
                switch response.result {
                case .Success(let json):
                    
                    if let dic = Parse.parseJSONToDictionary(json) {
                        
                        if dic["stat"] as! String == "success" {
                            if let message = dic["message"] as? String {
                                if message == "blank" {
                                    Alert.networkErrorAlertPresent(self, title: "공란", message: "공란입니다.")
                                }
                            } else {
                                Alert.networkErrorAlertPresent(self, title: "로그인 링크 전송", message: "요청하신 이메일 주소로 로그인 링크를 전송했습니다. 메일함을 확인해주세요")
                            }
                        } else {
                            Alert.networkErrorAlertPresent(self, title: "서버오류", message: "서버에서 오류가 발생했습니다. 잠시후 다시 시도해보세요")
                        }
                        
                    }
                    
                    
                case .Failure(_):
                    
                    Alert.networkErrorAlertPresent(self, title: "네트워크오류", message: "네트워크 오류가 발생했습니다. 네트워크 상태를 확인한 후 다시 시도해보세요")
                }
                
                
                
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

}

extension FindPasswordViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(textField: UITextField) {
        if textField.text?.characters.count != 0  {
            buttonBorderView.changeFillAlpha(true)
            SendButton.userInteractionEnabled = true
            SendButton.titleLabel?.textColor = UIColor.whiteColor()
        } else {
            buttonBorderView.changeFillAlpha(false)
            SendButton.userInteractionEnabled = false
            SendButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)
            
            
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
