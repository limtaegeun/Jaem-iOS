//
//  BTDiscovery.swift
//  Arduino_Servo
//
//  Created by Owen L Brown on 9/24/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

let btDiscoverySharedInstance = BTDiscovery();

struct PeripheralInfo {
    let localName :String
    let peripheral : CBPeripheral
    let RSSI : NSNumber
}

@objc protocol BTDiscoveryDelegate : class {
    optional func BTDiscovery(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber)
    optional func BTDiscovery(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral)
}

class BTDiscovery: NSObject, CBCentralManagerDelegate {
    
    private var centralManager: CBCentralManager?
    private var peripheralBLE: CBPeripheral?
    
    var delegate : BTDiscoveryDelegate?
    
    var peripheralList = [PeripheralInfo]()
    
    override init() {
        super.init()
        
        //let centralQueue = dispatch_queue_create("com.whataday", DISPATCH_QUEUE_SERIAL)
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func startScanning() {
        if let central = centralManager {
            central.scanForPeripheralsWithServices([DeviceInfoUUID,CUST1_SVC_UUID_128], options: nil)
        }
    }
    
    var bleService: BTService? {
        didSet {
            if let service = self.bleService {
                service.startDiscoveringServices()
            }
        }
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral, advertisementData: [String : AnyObject], RSSI: NSNumber) {
        // Be sure to retain the peripheral or it will fail during connection.
        
        
        print("there is aleast one device")
        
        let localName = advertisementData[CBAdvertisementDataLocalNameKey]
        
        if localName?.length > 0 {
            print("Found the Jaem : \(localName)")
            
            let peripheral = PeripheralInfo(localName: localName as! String, peripheral: peripheral,RSSI: RSSI)
            peripheralList.append(peripheral)
            
        }
        delegate?.BTDiscovery?(central, didDiscoverPeripheral: peripheral, advertisementData: advertisementData, RSSI: RSSI)
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        print("didConnectPeripheral")
        // Create new service class
        self.peripheralBLE = peripheral
        self.bleService = BTService(initWithPeripheral: peripheral)
        
        
        // Stop scanning for new devices
        central.stopScan()
        
        delegate?.BTDiscovery?(central, didConnectPeripheral: peripheral)
    }
    
    func centralManager(central: CBCentralManager, didFailToConnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("didFailToconnectPeripheral")
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        
        // See if it was our peripheral that disconnected
        if (peripheral == self.peripheralBLE) {
            self.bleService = nil;
            self.peripheralBLE = nil;
        }
        
        // Start scanning for new devices
        self.startScanning()
    }
    
    
    
    
    // MARK: - Private
    
    func clearDevices() {
        self.bleService = nil
        self.peripheralBLE = nil
    }
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch (central.state) {
        case CBCentralManagerState.PoweredOff:
            self.clearDevices()
            print("CoreBluetooth BLE hardware is powred off")
        case CBCentralManagerState.Unauthorized:
            // Indicate to user that the iOS device does not support BLE.
            print("CoreBluetooth Ble hardware is unauthorized")
            break
            
        case CBCentralManagerState.Unknown:
            // Wait for another event
            print("CoreBluetooth Ble hardware is unknown")
            break
            
        case CBCentralManagerState.PoweredOn:
            print("CoreBluetooth Ble hardware is powered On and ready")
            self.startScanning()
            
        case CBCentralManagerState.Resetting:
            print("Corebluetooth ble hardware is resetting")
            self.clearDevices()
            
        case CBCentralManagerState.Unsupported:
            print("CoreBluetooth ble hardware is unsupported on this platform")
            break
        }
    }
    
}
