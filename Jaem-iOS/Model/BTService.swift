//
//  BTService.swift
//  Arduino_Servo
//
//  Created by Owen L Brown on 10/11/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

import Foundation
import CoreBluetooth

/* Services & Characteristics UUIDs */
let DeviceInfoUUID = CBUUID(string: "180A")
let CUST1_SVC_UUID_128 = CBUUID(string: "EDFEC62E-9910-0BAC-5241-D8BDA6932A2F")

let ControlPoint_CHAR_UUID = CBUUID(string: "2D86686A-53DC-25B3-0C4A-F0E10C8DEE20")
let ADC_CHAR_UUID = CBUUID(string: "15005991-B131-3396-014C-664C9867B917")
let NEXT_SIG_CHAR_UUID = CBUUID(string: "6EB675AB-8BD1-1B9A-7444-621E52EC6823")

let BLEServiceChangedStatusNotification = "kBLEServiceChangedStatusNotification"

class BTService: NSObject, CBPeripheralDelegate {
    var peripheral: CBPeripheral?
    var positionCharacteristic: CBCharacteristic?
    
    init(initWithPeripheral peripheral: CBPeripheral) {
        super.init()
        
        self.peripheral = peripheral
        self.peripheral?.delegate = self
    }
    
    deinit {
        self.reset()
    }
    
    func startDiscoveringServices() {
        self.peripheral?.discoverServices(nil)
    }
    
    func reset() {
        if peripheral != nil {
            peripheral = nil
        }
        
        // Deallocating therefore send notification
        self.sendBTServiceNotificationWithIsBluetoothConnected(false)
    }
    
    // Mark: - CBPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        print("didDiscoverServices")
        if (peripheral != self.peripheral) {
            // Wrong Peripheral
            print("Wrong Peripheral")
            return
        }
        
        if (error != nil) {
            print("error")
            return
        }
        
        if ((peripheral.services == nil) || (peripheral.services!.count == 0)) {
            // No Services
            print("No Service")
            return
        }
        
        for service in peripheral.services! {
            print("discovered service \(service.UUID)")
            
            peripheral.discoverCharacteristics(nil, forService: service)
            
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if (peripheral != self.peripheral) {
            // Wrong Peripheral
            return
        }
        
        if (error != nil) {
            return
        }
        
        if service.UUID == DeviceInfoUUID {
            for characteristics in service.characteristics! {
                //if characteristics.UUID ==
            }
        }
        
        if service.UUID == CUST1_SVC_UUID_128 {
            for characteristics in service.characteristics! {
                if characteristics.UUID == ControlPoint_CHAR_UUID {
                    
                } else if characteristics.UUID == ADC_CHAR_UUID {
                    
                } else if characteristics.UUID == NEXT_SIG_CHAR_UUID {
                    
                }
            }
        }
        
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.UUID == DeviceInfoUUID {
                    self.positionCharacteristic = (characteristic)
                    peripheral.setNotifyValue(true, forCharacteristic: characteristic)
                    
                    // Send notification that Bluetooth is connected and all required characteristics are discovered
                    self.sendBTServiceNotificationWithIsBluetoothConnected(true)
                }
            }
        }
    }
    
    // Mark: - Private
    
    func writeValueToPeripheral(value: UInt8) {
        // See if characteristic has been discovered before writing to it
        if let TargetCharacteristic = self.positionCharacteristic {
            // Need a mutable var to pass to writeValue function
            var sendValue = value
            let data = NSData(bytes: &sendValue, length: sizeof(UInt8))
            self.peripheral?.writeValue(data, forCharacteristic: TargetCharacteristic, type: CBCharacteristicWriteType.WithResponse)
        }
    }
    
    func sendBTServiceNotificationWithIsBluetoothConnected(isBluetoothConnected: Bool) {
        let connectionDetails = ["isConnected": isBluetoothConnected]
        NSNotificationCenter.defaultCenter().postNotificationName(BLEServiceChangedStatusNotification, object: self, userInfo: connectionDetails)
    }
    
}