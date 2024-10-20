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



class BlePlusPeripheralManager: NSObject, FlutterBlePlusPlugin, CBPeripheralManagerDelegate {
    func getPlatformVersion() throws -> String {
        #if os(iOS)
             return UIDevice.current.name
        #elseif os(macOS)
            return ProcessInfo.processInfo.operatingSystemVersionString
        #else
            return "Unsupported platform."
        #endif
    }
    
    var binaryMessenger: FlutterBinaryMessenger;
    var peripheralManager : CBPeripheralManager!
    var advertisedServices: [CBMutableService]
    var bLECallback: BLECallback;
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.advertisedServices = []
        self.binaryMessenger = binaryMessenger
        self.bLECallback = BLECallback(binaryMessenger: binaryMessenger)
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
        let v: CBManagerState = CBManagerState.poweredOn
        notifyApi(eventType: String(describing: peripheral.state))
    }
    
    func getDeviceName() -> String {
        return "don know"//UIDevice.current.name
    }
    
    func startAdvertising(peripheral: BLEPeripheral) throws {
        
        if(self.peripheralManager.state != CBManagerState.poweredOn){
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
                var properties: CBCharacteristicProperties = [];
                charEntry.properties?.data.forEach({ prop in
                    properties.insert(CBCharacteristicProperties.Element(rawValue: UInt(prop)))
                })
                var permissions: CBAttributePermissions = []
                charEntry.permissions?.data.forEach({ perm in
                    permissions.insert(CBAttributePermissions.Element(rawValue: UInt(perm)))
                })
                let data: Data? = charEntry.value?.data
                let newCharacteristic = CBMutableCharacteristic(type: CBUUID(string: charEntry.uuid), properties: properties, value: data, permissions: permissions)
                newService.characteristics?.append(newCharacteristic)
            }
            
            advertisedServices.append(newService)
            peripheralManager.add(newService)
        }
        
    }
    
    func stopAdvertising() throws {
        notifyApi(eventType: "ADVERTISE_STOP")
    }
    
    func notifyApi(eventType: String){
        let bleEvent = BLEEvent(eventType: eventType)
        self.bLECallback.onBLEEvent(event: bleEvent) { result in
            switch result {
            case .success:
                print("notifyApi: Success= no errors.")
            case .failure(let error):
                print("notifyApi: Error= \(error.localizedDescription)")
            }
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request: CBATTRequest in requests {
            if let value = request.value {
                let flutterData = FlutterStandardTypedData(bytes: value)
                let writeRequest: WriteRequest = WriteRequest(characteristicUuid: request.characteristic.uuid.uuidString, value: flutterData)
                let writeRequests:[WriteRequest] = [writeRequest]
                self.bLECallback.onDidReceiveWrite(requests: writeRequests) { result in
                    switch result {
                    case .success:
                        print("didReceiveWrite Success= no errors.")
                        self.peripheralManager?.respond(to: request, withResult: .success);
                    case .failure(let error):
                        print("didReceiveWrite: Error= \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveRead request: CBATTRequest){
        let readRequest: ReadRequest = ReadRequest(deviceId: request.central.identifier.uuidString, characteristicUuid: request.characteristic.uuid.uuidString)
        self.bLECallback.onDidReceiveRead(request: readRequest, completion: { result in
            switch result {
            case .success(let readResponse):
                if let flutterData = readResponse.data as? FlutterStandardTypedData {
                    // Extract the raw data from FlutterStandardTypedData
                    let swiftData = flutterData.data

                    // Set the value of the read request with the data returned from Flutter
                    request.value = swiftData

                    // Respond to the central device with success
                    peripheral.respond(to: request, withResult: .success)
                } else {
                    // If no data is available, respond with an error
                    peripheral.respond(to: request, withResult: .unlikelyError)
                }
            case .failure(let error):
                // Handle the PigeonError if there is a failure
                print("Error: \(error.localizedDescription)")
                peripheral.respond(to: request, withResult: .unlikelyError)
            }
        })
    }
    
}
