//import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin_method_channel.dart';
//import 'package:plugin_platform_interface/plugin_platform_interface.dart';

//TODO fix tests
import '../pigeons/ble_peripheral_api.dart';

class MockFlutterBleplusPluginPlatform
    //with MockPlatformInterfaceMixin
    //implements FlutterBleplusPluginPlatform
{

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  //final FlutterBleplusPluginPlatform initialPlatform = FlutterBleplusPluginPlatform.instance;

  test(' is the default instance', () {
    //expect(initialPlatform, isInstanceOf<MethodChannelFlutterBleplusPlugin>());
  });

  test('getPlatformVersion', () async {

  });
}
