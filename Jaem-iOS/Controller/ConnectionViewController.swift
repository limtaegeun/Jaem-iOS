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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        performSegueWithIdentifier("SkipConnection", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let dv = segue.destinationViewController as! DeviceListTableViewController
        dv.centralManager = centralManager
        
    }
    

}
