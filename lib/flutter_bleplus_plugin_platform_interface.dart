import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_bleplus_plugin_method_channel.dart';

abstract class FlutterBleplusPluginPlatform extends PlatformInterface {
  /// Constructs a FlutterBleplusPluginPlatform.
  FlutterBleplusPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterBleplusPluginPlatform _instance = MethodChannelFlutterBleplusPlugin();

  /// The default instance of [FlutterBleplusPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterBleplusPlugin].
  static FlutterBleplusPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterBleplusPluginPlatform] when
  /// they register themselves.
  static set instance(FlutterBleplusPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
