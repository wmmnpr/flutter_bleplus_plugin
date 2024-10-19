# flutter_bleplus_plugin

A new Flutter plugin project.

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/to/develop-plugins),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# To fix Xcode project also run:
flutter pub get
flutter clean
flutter pub get

cd example
flutter build ios

cd ios/     # or 'cd macos/'
pod install

typedef NS_OPTIONS(uint8_t, CBCharacteristicProperties) {
CBCharacteristicPropertyBroadcast                    = 0x01,
CBCharacteristicPropertyRead                         = 0x02,
CBCharacteristicPropertyWriteWithoutResponse         = 0x04,
CBCharacteristicPropertyWrite                        = 0x08,
CBCharacteristicPropertyNotify                       = 0x10,
CBCharacteristicPropertyIndicate                     = 0x20,
CBCharacteristicPropertyAuthenticatedSignedWrites    = 0x40,
CBCharacteristicPropertyExtendedProperties           = 0x80,
CBCharacteristicPropertyNotifyEncryptionRequired     = 0x100,
CBCharacteristicPropertyIndicateEncryptionRequired   = 0x200,
};

typedef NS_OPTIONS(uint8_t, CBAttributePermissions) {
CBAttributePermissionsReadable                 = 0x01,
CBAttributePermissionsWriteable                = 0x02,
CBAttributePermissionsReadEncryptionRequired   = 0x04,
CBAttributePermissionsWriteEncryptionRequired  = 0x08,
};


