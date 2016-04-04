//
//  DeviceListTableViewController.swift
//  Jaem-iOS
//
//  Created by 임태근 on 2016. 3. 29..
//  Copyright © 2016년 whataday. All rights reserved.
//

import UIKit
import CoreBluetooth

class DeviceListTableViewController: UITableViewController ,BTDiscoveryDelegate {

    var centralManager : CBCentralManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btDiscoverySharedInstance.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return btDiscoverySharedInstance.peripheralList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PeripheralCell", forIndexPath: indexPath) as! PeripheralCell
        cell.localNameLabel.text = btDiscoverySharedInstance.peripheralList[indexPath.row].localName
        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        centralManager?.connectPeripheral(btDiscoverySharedInstance.peripheralList[indexPath.row].peripheral, options: nil)
    }
    
    func BTDiscovery(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        performSegueWithIdentifier("GoMeasure", sender: self)
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
