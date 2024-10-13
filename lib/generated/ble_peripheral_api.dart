// Autogenerated from Pigeon (v22.4.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

PlatformException _createConnectionError(String channelName) {
  return PlatformException(
    code: 'channel-error',
    message: 'Unable to establish connection on channel: "$channelName".',
  );
}

List<Object?> wrapResponse({Object? result, PlatformException? error, bool empty = false}) {
  if (empty) {
    return <Object?>[];
  }
  if (error == null) {
    return <Object?>[result];
  }
  return <Object?>[error.code, error.message, error.details];
}

class BLEService {
  BLEService({
    required this.uuid,
    required this.characteristics,
    this.isPrimary,
  });

  String uuid;

  List<BLECharacteristic> characteristics;

  bool? isPrimary;

  Object encode() {
    return <Object?>[
      uuid,
      characteristics,
      isPrimary,
    ];
  }

  static BLEService decode(Object result) {
    result as List<Object?>;
    return BLEService(
      uuid: result[0]! as String,
      characteristics: (result[1] as List<Object?>?)!.cast<BLECharacteristic>(),
      isPrimary: result[2] as bool?,
    );
  }
}

class BLEPeripheral {
  BLEPeripheral({
    required this.name,
    required this.uuid,
    required this.services,
  });

  String name;

  String uuid;

  List<BLEService> services;

  Object encode() {
    return <Object?>[
      name,
      uuid,
      services,
    ];
  }

  static BLEPeripheral decode(Object result) {
    result as List<Object?>;
    return BLEPeripheral(
      name: result[0]! as String,
      uuid: result[1]! as String,
      services: (result[2] as List<Object?>?)!.cast<BLEService>(),
    );
  }
}

class BLECharacteristic {
  BLECharacteristic({
    required this.uuid,
    this.value,
    this.isRead,
    this.isWrite,
    this.isNotify,
    this.isReadable,
    this.isWritable,
  });

  String uuid;

  Uint8List? value;

  bool? isRead;

  bool? isWrite;

  bool? isNotify;

  bool? isReadable;

  bool? isWritable;

  Object encode() {
    return <Object?>[
      uuid,
      value,
      isRead,
      isWrite,
      isNotify,
      isReadable,
      isWritable,
    ];
  }

  static BLECharacteristic decode(Object result) {
    result as List<Object?>;
    return BLECharacteristic(
      uuid: result[0]! as String,
      value: result[1] as Uint8List?,
      isRead: result[2] as bool?,
      isWrite: result[3] as bool?,
      isNotify: result[4] as bool?,
      isReadable: result[5] as bool?,
      isWritable: result[6] as bool?,
    );
  }
}

class BLEEvent {
  BLEEvent({
    required this.eventType,
    this.deviceId,
    this.state,
  });

  String eventType;

  String? deviceId;

  String? state;

  Object encode() {
    return <Object?>[
      eventType,
      deviceId,
      state,
    ];
  }

  static BLEEvent decode(Object result) {
    result as List<Object?>;
    return BLEEvent(
      eventType: result[0]! as String,
      deviceId: result[1] as String?,
      state: result[2] as String?,
    );
  }
}


class _PigeonCodec extends StandardMessageCodec {
  const _PigeonCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is int) {
      buffer.putUint8(4);
      buffer.putInt64(value);
    }    else if (value is BLEService) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    }    else if (value is BLEPeripheral) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    }    else if (value is BLECharacteristic) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    }    else if (value is BLEEvent) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 129: 
        return BLEService.decode(readValue(buffer)!);
      case 130: 
        return BLEPeripheral.decode(readValue(buffer)!);
      case 131: 
        return BLECharacteristic.decode(readValue(buffer)!);
      case 132: 
        return BLEEvent.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class BLECallback {
  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  void onBLEEvent(BLEEvent event);

  static void setUp(BLECallback? api, {BinaryMessenger? binaryMessenger, String messageChannelSuffix = '',}) {
    messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
    {
      final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.flutter_bleplus_plugin.BLECallback.onBLEEvent$messageChannelSuffix', pigeonChannelCodec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        pigeonVar_channel.setMessageHandler(null);
      } else {
        pigeonVar_channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.flutter_bleplus_plugin.BLECallback.onBLEEvent was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final BLEEvent? arg_event = (args[0] as BLEEvent?);
          assert(arg_event != null,
              'Argument for dev.flutter.pigeon.flutter_bleplus_plugin.BLECallback.onBLEEvent was null, expected non-null BLEEvent.');
          try {
            api.onBLEEvent(arg_event!);
            return wrapResponse(empty: true);
          } on PlatformException catch (e) {
            return wrapResponse(error: e);
          }          catch (e) {
            return wrapResponse(error: PlatformException(code: 'error', message: e.toString()));
          }
        });
      }
    }
  }
}

class BLEPeripheralApi {
  /// Constructor for [BLEPeripheralApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  BLEPeripheralApi({BinaryMessenger? binaryMessenger, String messageChannelSuffix = ''})
      : pigeonVar_binaryMessenger = binaryMessenger,
        pigeonVar_messageChannelSuffix = messageChannelSuffix.isNotEmpty ? '.$messageChannelSuffix' : '';
  final BinaryMessenger? pigeonVar_binaryMessenger;

  static const MessageCodec<Object?> pigeonChannelCodec = _PigeonCodec();

  final String pigeonVar_messageChannelSuffix;

  Future<void> startAdvertising(BLEPeripheral peripheral) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_bleplus_plugin.BLEPeripheralApi.startAdvertising$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[peripheral]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> updateValue(String svcUuid, String charUuid, Uint8List data) async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_bleplus_plugin.BLEPeripheralApi.updateValue$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(<Object?>[svcUuid, charUuid, data]) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else if (pigeonVar_replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (pigeonVar_replyList[0] as bool?)!;
    }
  }

  Future<void> stopAdvertising() async {
    final String pigeonVar_channelName = 'dev.flutter.pigeon.flutter_bleplus_plugin.BLEPeripheralApi.stopAdvertising$pigeonVar_messageChannelSuffix';
    final BasicMessageChannel<Object?> pigeonVar_channel = BasicMessageChannel<Object?>(
      pigeonVar_channelName,
      pigeonChannelCodec,
      binaryMessenger: pigeonVar_binaryMessenger,
    );
    final List<Object?>? pigeonVar_replyList =
        await pigeonVar_channel.send(null) as List<Object?>?;
    if (pigeonVar_replyList == null) {
      throw _createConnectionError(pigeonVar_channelName);
    } else if (pigeonVar_replyList.length > 1) {
      throw PlatformException(
        code: pigeonVar_replyList[0]! as String,
        message: pigeonVar_replyList[1] as String?,
        details: pigeonVar_replyList[2],
      );
    } else {
      return;
    }
  }
}
