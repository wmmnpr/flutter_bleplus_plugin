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
    var cbManagerState : CBManagerState = CBManagerState.unknown
    
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
        self.cbManagerState = peripheral.state
        switch peripheral.state {
         case .poweredOn:
             print("Bluetooth is powered on, ready to use")
         case .poweredOff:
             print("Bluetooth is powered off")
         case .resetting:
             print("Bluetooth is resetting")
         case .unauthorized:
             print("Bluetooth is unauthorized")
         case .unsupported:
             print("Bluetooth is unsupported")
         case .unknown:
             print("Bluetooth state is unknown")
         @unknown default:
             fatalError("Unhandled state: \(peripheral.state.rawValue)")
         }
     }
    
    func getDeviceName() -> String {
        return "don know"//UIDevice.current.name
    }

    func startAdvertising(peripheral: BLEPeripheral) throws {
        
        if(self.cbManagerState != CBManagerState.poweredOn){
            throw PigeonError(code: "ERR_001", message: "BLE not powered on", details: "BLE not powered on")
        }
        self.peripheralManager.removeAllServices();
        
        var dataToBeAdvertised: [String: Any]! = [:]
        dataToBeAdvertised[CBAdvertisementDataServiceUUIDsKey] = [CBUUID(string: peripheral.uuid)]
        dataToBeAdvertised[CBAdvertisementDataLocalNameKey] = peripheral.name
        peripheralManager.startAdvertising(dataToBeAdvertised)
        peripheral.services.forEach {serviceEntry in
            let isPrimary = serviceEntry.isPrimary ?? false
            let newService = CBMutableService(type: CBUUID(string: serviceEntry.uuid), primary: isPrimary)
            newService.characteristics = []
            serviceEntry.characteristics.forEach { charEntry in
                let canRead = charEntry.isRead ?? false
                let canWrite = charEntry.isWrite ?? false
                let canNotify = charEntry.isNotify ?? false;
                let properties: CBCharacteristicProperties = [
                    canRead ? .read : [],
                    canWrite ? .write : [],
                    canNotify ? .notify : []
                ]
                
                let isReadable = charEntry.isReadable ?? false
                let isWritable = charEntry.isWritable ?? false
                let permissions: CBAttributePermissions = [
                    isReadable ? .readable : [],
                    isWritable ? .writeable : []
                ]
       
                let data: Data? = charEntry.value?.data
                let newCharacteristic = CBMutableCharacteristic(type: CBUUID(string: charEntry.uuid), properties: properties, value: data, permissions: permissions)
                newService.characteristics?.append(newCharacteristic)
                
            }
            advertisedServices.append(newService)
            do {
                peripheralManager.add(newService)
            }catch let error {
                let pigeonError = PigeonError(code:"ERR_002", message:"add service error", details: error.localizedDescription)
            }
        }
        
    }
    
    func stopAdvertising() throws {
        
        
    
    }
}

