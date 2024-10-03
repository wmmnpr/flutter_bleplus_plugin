//
//  BLEPeripheralImpl.swift
//  Runner
//
//  Created by William Pennoyer on 03.10.24.
//

import Foundation
import CoreBluetooth
import CoreLocation



class BlePlusPlatformImpl: NSObject, BLEPeripheralApi, CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    
    }
    
    
    var peripheralManager : CBPeripheralManager!
    var txCharacteristic: CBMutableCharacteristic?
    var rxCharacteristic: CBMutableCharacteristic?
    
    override init() {
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey : true])
       
    }
    
    func getDeviceName() -> String {
        return UIDevice.current.name
    }
    
    func startAdvertising(peripheral: BLEPeripheral) throws {
        var dataToBeAdvertised: [String: Any]! = [:]
        dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: peripheral.uuid)]
        dataToBeAdvertised[CBAdvertisementDataLocalNameKey] = peripheral.name
        peripheralManager.startAdvertising(dataToBeAdvertised)
        peripheral.services.forEach {serviceEntry in
            let service = CBMutableService(type: CBUUID(string: serviceEntry.uuid), primary: true)
            service.characteristics = []
            serviceEntry.characteristics.forEach { charEntry in
                let canRead = charEntry.isReadable ?? true
                let canWrite = charEntry.isWritable ?? true
                let canNotify = charEntry.isNotifiable ?? true;
                let properties: CBCharacteristicProperties = [
                    canRead ? .read : [],
                    canWrite ? .write : [],
                    canNotify ? .notify : []
                ]
                let newCharacteristic = CBMutableCharacteristic(type: CBUUID(string: charEntry.uuid), properties: properties, value: nil, permissions: [.readable, .writeable])
                service.characteristics?.append(newCharacteristic)
            }
            peripheralManager.add(service)
        }
        
    }
    
    func stopAdvertising() throws {
        
        
    
    }
}

