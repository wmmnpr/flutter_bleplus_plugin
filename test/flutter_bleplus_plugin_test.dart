import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin.dart';
import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin_platform_interface.dart';
import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterBleplusPluginPlatform
    with MockPlatformInterfaceMixin
    implements FlutterBleplusPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterBleplusPluginPlatform initialPlatform = FlutterBleplusPluginPlatform.instance;

  test('$MethodChannelFlutterBleplusPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterBleplusPlugin>());
  });

  test('getPlatformVersion', () async {
    FlutterBleplusPlugin flutterBleplusPlugin = FlutterBleplusPlugin();
    MockFlutterBleplusPluginPlatform fakePlatform = MockFlutterBleplusPluginPlatform();
    FlutterBleplusPluginPlatform.instance = fakePlatform;

    expect(await flutterBleplusPlugin.getPlatformVersion(), '42');
  });
}
