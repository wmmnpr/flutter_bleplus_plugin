

import 'flutter_bleplus_plugin_platform_interface.dart';

class FlutterBleplusPlugin {
  Future<String?> getPlatformVersion() {
    return FlutterBleplusPluginPlatform.instance.getPlatformVersion();
  }
}
