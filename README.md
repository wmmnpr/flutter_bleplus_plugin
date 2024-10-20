# Welcome to flutter_bleplus_plugin
A Flutter plugin to support BLE functionality on macOS and on iOS.
<br/>The project uses Pigeon for communication between the Flutter and the underlying platform.
<br/>See the example folder for a quick overview of how-to use the plugin.

## Functionality overview
| Functionality                                  | iOS | macOS | Android | Windows | linux |
|------------------------------------------------|-----|-------|---------|---------|-------|
| **Central Role (Scanning and Connecting)**     |     |       |         |         |       |
| Scanning for Devices                           | ❌   | ❌     | ❌       | ❌       | ❌     |
| Connection Management                          | ❌   | ❌     | ❌       | ❌       | ❌     |
| Discover Services and Characteristics          | ❌   | ❌     | ❌       | ❌       | ❌     |
| Read/Write Characteristics                     | ❌   | ❌     | ❌       | ❌       | ❌     |
| Characteristic Notifications/Indications       | ❌   | ❌     | ❌       | ❌       | ❌     |
| RSSI Monitoring                                | ❌   | ❌     | ❌       | ❌       | ❌     |
| Handling Encryption and Bonding                | ❌   | ❌     | ❌       | ❌       | ❌     |
| **Peripheral Role (Advertising and Handling)** |     |       |         |         |       |
| Advertising Services                           | ✅   | ✅     | ❌       | ❌       | ❌     |
| GATT Server Setup                              | ✅   | ✅     | ❌       | ❌       | ❌     |
| Responding to Read/Write Requests              | ✅   | ✅     | ❌       | ❌       | ❌     |
| Notify Characteristics from Peripheral         | ✅   | ✅     | ❌       | ❌       | ❌     |
| Handling Connections and Disconnections        | ❌   | ❌     | ❌       | ❌       | ❌     |
| Peripheral Configuration                       | ❌   | ❌     | ❌       | ❌       | ❌     |
| **General Utilities**                          |     |       |         |         |       |
| Permission Management                          | ✅   | ✅     | ❌       | ❌       | ❌     |
| Error Handling and Event Monitoring            | ❌   | ❌     | ❌       | ❌       | ❌     |
| State Management                               | ❌   | ❌     | ❌       | ❌       | ❌     |

# Development notes
Flutter [documentation](https://docs.flutter.dev/) <br/>
Dart [documentation](https://dart.dev/language)<br/>
Core Bluetooth [documentation](https://developer.apple.com/documentation/corebluetooth) <br/>
Swift [documentation](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/) <br/>
Markdown [documentation](https://docs.github.com/en/get-started) <br/>

### Characteristic Property names and values
| Characteristic Property name  (iOS/macOS)          | value |
|----------------------------------------------------|-------|
| CBCharacteristicPropertyBroadcast                  | 0x01  |
| CBCharacteristicPropertyRead                       | 0x02  |
| CBCharacteristicPropertyWriteWithoutResponse       | 0x04  |
| CBCharacteristicPropertyWrite                      | 0x08  |
| CBCharacteristicPropertyNotify                     | 0x10  |
| CBCharacteristicPropertyIndicate                   | 0x20  |
| CBCharacteristicPropertyAuthenticatedSignedWrites  | 0x40  |
| CBCharacteristicPropertyExtendedProperties         | 0x80  |
| CBCharacteristicPropertyNotifyEncryptionRequired   | 0x10  |,
| CBCharacteristicPropertyIndicateEncryptionRequired | 0x20  |,

### Characteristic Permission values
| Characteristic Permission name   (iOS/macOS)  |      |
|-----------------------------------------------|------|
| CBAttributePermissionsReadable                | 0x01 |
| CBAttributePermissionsWriteable               | 0x02 |
| CBAttributePermissionsReadEncryptionRequired  | 0x04 |
| CBAttributePermissionsWriteEncryptionRequired | 0x08 |

## Miscellaneous 
### To fix XCode project also run:
flutter pub get
flutter clean
flutter pub get

cd example
flutter build ios

cd ios/     # or 'cd macos/'
pod install

