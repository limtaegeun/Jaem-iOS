//
//  ConnectionViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 29..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import CoreBluetooth

class ConnectionViewController: UIViewController , BTDiscoveryDelegate {

    var centralManager : CBCentralManager?
    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var noDeviceButton: UIButton!
    
    @IBOutlet weak var connectImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectImageView.image = UIImage(named: "connect")
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: "지금은 디바이스가 없어요")
        
        attributeString.addAttribute(NSUnderlineStyleAttributeName, value: 1, range: NSMakeRange(0, attributeString.length))
        noDeviceButton.titleLabel!.attributedText = attributeString
        
        let attributeString2: NSMutableAttributedString =  NSMutableAttributedString(string: "가입하면 jaem의 약관 및 개인정보취급방침에 동의하게 됩니다")
        
        attributeString2.addAttribute(NSFontAttributeName, value: UIFont(name:"TypoRoundRegularDemo",size: 17)! , range: NSMakeRange(0,4))
        connectButton.titleLabel!.attributedText = attributeString
        
        btDiscoverySharedInstance
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    @IBAction func tapConnect(sender: AnyObject) {
        performSegueWithIdentifier("GoDeviceList", sender: self)
    }
    
    @IBAction func tapNoDevice(sender: AnyObject) {
        performSegueWithIdentifier("NoDevice", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "GoDeviceList" {
            let dv = segue.destinationViewController as! DeviceListTableViewController
            dv.centralManager = centralManager
        } else if segue.identifier == "NoDevice" {
            
        }
        
        
    }
    

}
