// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon

import Foundation

#if os(iOS)
  import Flutter
#elseif os(macOS)
  import FlutterMacOS
#else
  #error("Unsupported platform.")
#endif

/// Error class for passing custom error details to Dart side.
final class PigeonError: Error {
  let code: String
  let message: String?
  let details: Any?

  init(code: String, message: String?, details: Any?) {
    self.code = code
    self.message = message
    self.details = details
  }

  var localizedDescription: String {
    return
      "PigeonError(code: \(code), message: \(message ?? "<nil>"), details: \(details ?? "<nil>")"
      }
}

private func wrapResult(_ result: Any?) -> [Any?] {
  return [result]
}

private func wrapError(_ error: Any) -> [Any?] {
  if let pigeonError = error as? PigeonError {
    return [
      pigeonError.code,
      pigeonError.message,
      pigeonError.details,
    ]
  }
  if let flutterError = error as? FlutterError {
    return [
      flutterError.code,
      flutterError.message,
      flutterError.details,
    ]
  }
  return [
    "\(error)",
    "\(type(of: error))",
    "Stacktrace: \(Thread.callStackSymbols)",
  ]
}

private func createConnectionError(withChannelName channelName: String) -> PigeonError {
  return PigeonError(code: "channel-error", message: "Unable to establish connection on channel: '\(channelName)'.", details: "")
}

private func isNullish(_ value: Any?) -> Bool {
  return value is NSNull || value == nil
}

private func nilOrValue<T>(_ value: Any?) -> T? {
  if value is NSNull { return nil }
  return value as! T?
}

/// Generated class from Pigeon that represents data sent in messages.
struct BLEService {
  var uuid: String
  var characteristics: [BLECharacteristic]
  var isPrimary: Bool? = nil



  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> BLEService? {
    let uuid = pigeonVar_list[0] as! String
    let characteristics = pigeonVar_list[1] as! [BLECharacteristic]
    let isPrimary: Bool? = nilOrValue(pigeonVar_list[2])

    return BLEService(
      uuid: uuid,
      characteristics: characteristics,
      isPrimary: isPrimary
    )
  }
  func toList() -> [Any?] {
    return [
      uuid,
      characteristics,
      isPrimary,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BLEPeripheral {
  var name: String
  var uuid: String
  var services: [BLEService]



  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> BLEPeripheral? {
    let name = pigeonVar_list[0] as! String
    let uuid = pigeonVar_list[1] as! String
    let services = pigeonVar_list[2] as! [BLEService]

    return BLEPeripheral(
      name: name,
      uuid: uuid,
      services: services
    )
  }
  func toList() -> [Any?] {
    return [
      name,
      uuid,
      services,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BLECharacteristic {
  var uuid: String
  var value: FlutterStandardTypedData? = nil
  var properties: FlutterStandardTypedData? = nil
  var permissions: FlutterStandardTypedData? = nil



  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> BLECharacteristic? {
    let uuid = pigeonVar_list[0] as! String
    let value: FlutterStandardTypedData? = nilOrValue(pigeonVar_list[1])
    let properties: FlutterStandardTypedData? = nilOrValue(pigeonVar_list[2])
    let permissions: FlutterStandardTypedData? = nilOrValue(pigeonVar_list[3])

    return BLECharacteristic(
      uuid: uuid,
      value: value,
      properties: properties,
      permissions: permissions
    )
  }
  func toList() -> [Any?] {
    return [
      uuid,
      value,
      properties,
      permissions,
    ]
  }
}

/// Generated class from Pigeon that represents data sent in messages.
struct BLEEvent {
  var eventType: String
  var deviceId: String? = nil
  var state: String? = nil



  // swift-format-ignore: AlwaysUseLowerCamelCase
  static func fromList(_ pigeonVar_list: [Any?]) -> BLEEvent? {
    let eventType = pigeonVar_list[0] as! String
    let deviceId: String? = nilOrValue(pigeonVar_list[1])
    let state: String? = nilOrValue(pigeonVar_list[2])

    return BLEEvent(
      eventType: eventType,
      deviceId: deviceId,
      state: state
    )
  }
  func toList() -> [Any?] {
    return [
      eventType,
      deviceId,
      state,
    ]
  }
}

private class PigeonBlePlusPluginApiPigeonCodecReader: FlutterStandardReader {
  override func readValue(ofType type: UInt8) -> Any? {
    switch type {
    case 129:
      return BLEService.fromList(self.readValue() as! [Any?])
    case 130:
      return BLEPeripheral.fromList(self.readValue() as! [Any?])
    case 131:
      return BLECharacteristic.fromList(self.readValue() as! [Any?])
    case 132:
      return BLEEvent.fromList(self.readValue() as! [Any?])
    default:
      return super.readValue(ofType: type)
    }
  }
}

private class PigeonBlePlusPluginApiPigeonCodecWriter: FlutterStandardWriter {
  override func writeValue(_ value: Any) {
    if let value = value as? BLEService {
      super.writeByte(129)
      super.writeValue(value.toList())
    } else if let value = value as? BLEPeripheral {
      super.writeByte(130)
      super.writeValue(value.toList())
    } else if let value = value as? BLECharacteristic {
      super.writeByte(131)
      super.writeValue(value.toList())
    } else if let value = value as? BLEEvent {
      super.writeByte(132)
      super.writeValue(value.toList())
    } else {
      super.writeValue(value)
    }
  }
}

private class PigeonBlePlusPluginApiPigeonCodecReaderWriter: FlutterStandardReaderWriter {
  override func reader(with data: Data) -> FlutterStandardReader {
    return PigeonBlePlusPluginApiPigeonCodecReader(data: data)
  }

  override func writer(with data: NSMutableData) -> FlutterStandardWriter {
    return PigeonBlePlusPluginApiPigeonCodecWriter(data: data)
  }
}

class PigeonBlePlusPluginApiPigeonCodec: FlutterStandardMessageCodec, @unchecked Sendable {
  static let shared = PigeonBlePlusPluginApiPigeonCodec(readerWriter: PigeonBlePlusPluginApiPigeonCodecReaderWriter())
}

/// Generated protocol from Pigeon that represents Flutter messages that can be called from Swift.
protocol BLECallbackProtocol {
  func onBLEEvent(event eventArg: BLEEvent, completion: @escaping (Result<Void, PigeonError>) -> Void)
}
class BLECallback: BLECallbackProtocol {
  private let binaryMessenger: FlutterBinaryMessenger
  private let messageChannelSuffix: String
  init(binaryMessenger: FlutterBinaryMessenger, messageChannelSuffix: String = "") {
    self.binaryMessenger = binaryMessenger
    self.messageChannelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
  }
  var codec: PigeonBlePlusPluginApiPigeonCodec {
    return PigeonBlePlusPluginApiPigeonCodec.shared
  }
  func onBLEEvent(event eventArg: BLEEvent, completion: @escaping (Result<Void, PigeonError>) -> Void) {
    let channelName: String = "dev.flutter.pigeon.flutter_bleplus_plugin.BLECallback.onBLEEvent\(messageChannelSuffix)"
    let channel = FlutterBasicMessageChannel(name: channelName, binaryMessenger: binaryMessenger, codec: codec)
    channel.sendMessage([eventArg] as [Any?]) { response in
      guard let listResponse = response as? [Any?] else {
        completion(.failure(createConnectionError(withChannelName: channelName)))
        return
      }
      if listResponse.count > 1 {
        let code: String = listResponse[0] as! String
        let message: String? = nilOrValue(listResponse[1])
        let details: String? = nilOrValue(listResponse[2])
        completion(.failure(PigeonError(code: code, message: message, details: details)))
      } else {
        completion(.success(Void()))
      }
    }
  }
}
/// Generated protocol from Pigeon that represents a handler of messages from Flutter.
protocol FlutterBlePlusPlugin {
  func getPlatformVersion() throws -> String
  func startAdvertising(peripheral: BLEPeripheral) throws
  func updateValue(svcUuid: String, charUuid: String, data: FlutterStandardTypedData) throws -> Bool
  func stopAdvertising() throws
}

/// Generated setup class from Pigeon to handle messages through the `binaryMessenger`.
class FlutterBlePlusPluginSetup {
  static var codec: FlutterStandardMessageCodec { PigeonBlePlusPluginApiPigeonCodec.shared }
  /// Sets up an instance of `FlutterBlePlusPlugin` to handle messages through the `binaryMessenger`.
  static func setUp(binaryMessenger: FlutterBinaryMessenger, api: FlutterBlePlusPlugin?, messageChannelSuffix: String = "") {
    let channelSuffix = messageChannelSuffix.count > 0 ? ".\(messageChannelSuffix)" : ""
    let getPlatformVersionChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_bleplus_plugin.FlutterBlePlusPlugin.getPlatformVersion\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      getPlatformVersionChannel.setMessageHandler { _, reply in
        do {
          let result = try api.getPlatformVersion()
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      getPlatformVersionChannel.setMessageHandler(nil)
    }
    let startAdvertisingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_bleplus_plugin.FlutterBlePlusPlugin.startAdvertising\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      startAdvertisingChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let peripheralArg = args[0] as! BLEPeripheral
        do {
          try api.startAdvertising(peripheral: peripheralArg)
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      startAdvertisingChannel.setMessageHandler(nil)
    }
    let updateValueChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_bleplus_plugin.FlutterBlePlusPlugin.updateValue\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      updateValueChannel.setMessageHandler { message, reply in
        let args = message as! [Any?]
        let svcUuidArg = args[0] as! String
        let charUuidArg = args[1] as! String
        let dataArg = args[2] as! FlutterStandardTypedData
        do {
          let result = try api.updateValue(svcUuid: svcUuidArg, charUuid: charUuidArg, data: dataArg)
          reply(wrapResult(result))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      updateValueChannel.setMessageHandler(nil)
    }
    let stopAdvertisingChannel = FlutterBasicMessageChannel(name: "dev.flutter.pigeon.flutter_bleplus_plugin.FlutterBlePlusPlugin.stopAdvertising\(channelSuffix)", binaryMessenger: binaryMessenger, codec: codec)
    if let api = api {
      stopAdvertisingChannel.setMessageHandler { _, reply in
        do {
          try api.stopAdvertising()
          reply(wrapResult(nil))
        } catch {
          reply(wrapError(error))
        }
      }
    } else {
      stopAdvertisingChannel.setMessageHandler(nil)
    }
  }
}
