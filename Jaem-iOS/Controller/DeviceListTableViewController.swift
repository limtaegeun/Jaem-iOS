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
        centralManager = btDiscoverySharedInstance.centralManager
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
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        centralManager?.connectPeripheral(btDiscoverySharedInstance.peripheralList[indexPath.row].peripheral, options: nil)
    }
    
    func BTDiscovery(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        tableView.reloadData()
    }
    
    func BTDiscovery(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        performSegueWithIdentifier("GoMeasure", sender: self)
    }
    
    func BTdiscovery(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        Alert.networkErrorAlertPresent(self, title: "연결에 실패했습니다", message: "디바이스 상태를 확인한 후 다시 시도해보세요.")
    }
    
    
}
