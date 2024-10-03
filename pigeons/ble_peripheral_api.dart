@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  dartOptions: DartOptions(),
  cppOptions: CppOptions(namespace: 'pigeon_example'),
  cppHeaderOut: 'windows/runner/messages.g.h',
  cppSourceOut: 'windows/runner/messages.g.cpp',
  gobjectHeaderOut: 'linux/messages.g.h',
  gobjectSourceOut: 'linux/messages.g.cc',
  gobjectOptions: GObjectOptions(),
  kotlinOut:
      'android/app/src/main/kotlin/dev/flutter/pigeon_example_app/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
  javaOut: 'android/app/src/main/java/io/flutter/plugins/Messages.java',
  javaOptions: JavaOptions(),
  swiftOut: 'ios/Runner/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  objcHeaderOut: 'macos/Runner/messages.g.h',
  objcSourceOut: 'macos/Runner/messages.g.m',
  // Set this to a unique prefix for your plugin or application, per Objective-C naming conventions.
  objcOptions: ObjcOptions(prefix: 'PGN'),
  copyrightHeader: 'pigeons/copyright.txt',
  dartPackageName: 'pigeon_example_package',
))
import 'package:pigeon/pigeon.dart';

class BLEService {
  String uuid; // UUID of the BLE service
  List<BLECharacteristic> characteristics;
  BLEService(this.uuid, this.characteristics);
}

class BLEPeripheral {
  String name;
  String uuid;
  List<BLEService> services;
  BLEPeripheral(this.name, this.uuid, this.services);
}

class BLECharacteristic {
  String uuid; // UUID of the BLE characteristic
  String? value; // Value of the characteristic
  bool? isReadable; // Is this characteristic readable?
  bool? isWritable; // Is this characteristic writable?
  bool? isNotifiable; // Is this characteristic notifiable?

  BLECharacteristic(this.uuid);

}

@HostApi()
abstract class BLEPeripheralApi {
  // Starts advertising the BLE peripheral
  void startAdvertising(BLEPeripheral peripheral);

  // Stops advertising the BLE peripheral
  void stopAdvertising();
}
