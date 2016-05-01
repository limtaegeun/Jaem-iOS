//
//  FindPasswordViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 4. 2..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {

    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var explainLabel: UILabel!
    @IBOutlet weak var UserNameTextField: UITextField!
    
    @IBOutlet weak var SendButton: UIButton!
    
    @IBOutlet weak var helpButton: UIButton!
    @IBOutlet weak var BackButton: UIButton!
    
    var buttonBorderView : TextFieldBorderView!
    override func viewDidLoad() {
        super.viewDidLoad()

        UserNameTextField.delegate = self
        SendButton.userInteractionEnabled = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let borderView1 = TextFieldBorderView(frame: CGRect(x: UserNameTextField.frame.origin.x - 10, y: UserNameTextField.frame.origin.y, width: UserNameTextField.frame.width + 20, height: UserNameTextField.frame.height ))
        
        buttonBorderView = TextFieldBorderView(frame: SendButton.frame)
        
        borderView1.backgroundColor = UIColor.clearColor()
        buttonBorderView.backgroundColor = UIColor.clearColor()

        subView.insertSubview(borderView1, belowSubview: UserNameTextField)
        subView.insertSubview(buttonBorderView, belowSubview: SendButton)

        SendButton.titleLabel?.textColor = UIColor(red: 153/255, green: 153/255, blue: 153/255, alpha: 1)

        let attributeString1: NSMutableAttributedString =  NSMutableAttributedString(string: "다른 문제가 있나요? jaem 고객센터를 이용해보세요")
        
        attributeString1.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(12, 9))
        helpButton.titleLabel?.attributedText = attributeString1
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "로그인으로 돌아가기")
        
        attributeString2.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, 10))
        BackButton.titleLabel?.attributedText = attributeString2
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
