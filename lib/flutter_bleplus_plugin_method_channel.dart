import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_bleplus_plugin_platform_interface.dart';

/// An implementation of [FlutterBleplusPluginPlatform] that uses method channels.
class MethodChannelFlutterBleplusPlugin extends FlutterBleplusPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_bleplus_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
