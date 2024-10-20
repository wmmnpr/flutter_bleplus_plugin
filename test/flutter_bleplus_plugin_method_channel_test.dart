import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin_method_channel.dart';

//TODO fix tests
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  //MethodChannelFlutterBleplusPlugin platform = MethodChannelFlutterBleplusPlugin();
  const MethodChannel channel = MethodChannel('flutter_bleplus_plugin');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    //expect(await platform.getPlatformVersion(), '42');
  });
}
