//
//  BLEPeripheralImpl.swift
//  Runner
//
//  Created by William Pennoyer on 03.10.24.
//

import Foundation
import CoreBluetooth
import CoreLocation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif



class BlePlusPlatformImpl: NSObject, BLEPeripheralApi, CBPeripheralManagerDelegate {

    var peripheralManager : CBPeripheralManager!
    var advertisedServices: [CBMutableService]
    
    override init() {
        self.advertisedServices = []
        super.init()
        self.peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: [CBPeripheralManagerOptionShowPowerAlertKey : true])
    }
    
    
    func updateValue(svcUuid: String, charUuid: String, data: FlutterStandardTypedData) throws -> Bool  {
        let targetUuid = CBUUID(string: svcUuid)
        if let foundService = advertisedServices.first(where: { $0.uuid.isEqual(targetUuid) }) {
            let targetCharUuid = CBUUID(string: charUuid)
            if let foundChar = foundService.characteristics?.first(where: { $0.uuid.isEqual(targetCharUuid) }){
                let mutableChar = foundChar as! CBMutableCharacteristic
                return peripheralManager.updateValue(data.data, for: mutableChar, onSubscribedCentrals: nil)
            }
        }
        return false;
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    
    }
    
    func getDeviceName() -> String {
        return "don know"//UIDevice.current.name
    }

    func startAdvertising(peripheral: BLEPeripheral) throws {
        var dataToBeAdvertised: [String: Any]! = [:]
        dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: peripheral.uuid)]
        dataToBeAdvertised[CBAdvertisementDataLocalNameKey] = peripheral.name
        peripheralManager.startAdvertising(dataToBeAdvertised)
        peripheral.services.forEach {serviceEntry in
            let isPrimary = serviceEntry.isPrimary ?? false
            let newService = CBMutableService(type: CBUUID(string: serviceEntry.uuid), primary: isPrimary)
            newService.characteristics = []
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
                newService.characteristics?.append(newCharacteristic)
            }
            advertisedServices.append(newService)
            peripheralManager.add(newService)
        }
        
    }
    
    func stopAdvertising() throws {
        
        
    
    }
}

