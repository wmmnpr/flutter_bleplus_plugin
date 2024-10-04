import 'dart:async';
import 'package:hex/hex.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bleplus_plugin/flutter_bleplus_plugin.dart';
import 'package:flutter_bleplus_plugin/generated/ble_peripheral_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterBleplusPlugin = FlutterBleplusPlugin();
  final _blePeripheralApi = BLEPeripheralApi();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> _pressMeButton() async {
    List<BLECharacteristic> characteristics = [
      BLECharacteristic(
          uuid: 'ce060035-43e5-11e4-916c-0800200c9a66',
          isReadable: true,
          isWritable: true,
          isNotifiable: true),
      BLECharacteristic(
          uuid: 'ce060035-43e6-11e4-916c-0800200c9a66',
          isReadable: true,
          isWritable: true,
          isNotifiable: true)
    ];
    BLEService service = BLEService(
        uuid: 'ce061801-43e5-11e4-916c-0800200c9a66',
        characteristics: characteristics);
    List<BLEService> services = [service];
    BLEPeripheral peripheral = BLEPeripheral(
        name: 'PM Test',
        uuid: 'bf277777-860a-4e09-889c-2d8b6a9e0fe7',
        services: services);
    _blePeripheralApi.startAdvertising(peripheral);
  }

  Future<void>_updateCharacteristic() async {

    List<String> hexDataList = [
      "00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00",
      "5f:00:00:1c:00:00:61:4f:00:00:e1:00:63:05:d9:03:00:00:01:00",
      "f3:00:00:4b:00:00:61:4f:8a:00:e1:00:63:05:d9:03:00:00:01:00",
      "44:01:00:6a:00:00:76:4c:8a:00:13:03:d3:06:4e:04:d8:09:02:00",
      "e3:01:00:a7:00:00:76:4c:92:00:13:03:d3:06:4e:04:d8:09:02:00",
      "2e:02:00:c6:00:00:76:42:92:00:8b:03:75:06:00:04:44:0f:03:00",
      "d6:02:00:09:01:00:76:42:9e:00:8b:03:75:06:00:04:44:0f:03:00",
      "22:03:00:29:01:00:79:43:9e:00:dd:03:e8:06:40:04:c7:11:04:00",
      "cd:03:00:6f:01:00:79:43:a1:00:dd:03:e8:06:40:04:c7:11:04:00",
      "17:04:00:90:01:00:79:41:a1:00:fe:03:4e:07:75:04:6c:13:05:00",
      "cb:04:00:da:01:00:79:41:aa:00:fe:03:4e:07:75:04:6c:13:05:00",
      "17:05:00:fb:01:00:7c:43:aa:00:34:04:f1:06:24:04:d6:14:06:00",
      "c8:05:00:44:02:00:7c:43:a5:00:34:04:f1:06:24:04:d6:14:06:00",
      "10:06:00:64:02:00:79:41:a5:00:13:04:c5:06:33:04:fc:13:07:00",
      "be:06:00:ab:02:00:79:41:a4:00:13:04:c5:06:33:04:fc:13:07:00",
      "07:07:00:ca:02:00:79:42:a4:00:0b:04:aa:06:0d:04:ae:13:08:00",
      "b6:07:00:11:03:00:79:42:a3:00:0b:04:aa:06:0d:04:ae:13:08:00",
      "00:08:00:32:03:00:79:42:a3:00:03:04:e9:06:38:04:5d:13:09:00",
      "b3:08:00:7a:03:00:79:42:a6:00:03:04:e9:06:38:04:5d:13:09:00",
      "fa:08:00:9a:03:00:7c:43:a6:00:1a:04:89:07:54:04:fc:13:0a:00",
      "b3:09:00:e6:03:00:7c:43:ab:00:1a:04:89:07:54:04:fc:13:0a:00",
    ];
    int i = 0;
    void tick(Timer tock) {
      //sleep(const Duration(milliseconds: 100));
      List<int> buffer =
      HEX.decode(hexDataList[i % hexDataList.length].replaceAll(":", ""));
      _blePeripheralApi.updateValue("ce061801-43e5-11e4-916c-0800200c9a66", "ce060035-43e5-11e4-916c-0800200c9a66", Uint8List.fromList(buffer));
      print("sent total: $i");
      if (i++ > 10) {
        tock.cancel();
      }
    }

    Timer.periodic(Duration(milliseconds: 5000), tick);


  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterBleplusPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Running on: $_platformVersion\n'),
              MaterialButton(
                onPressed: () => _pressMeButton(),
                child: Text(
                  'start advertising',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .labelLarge!
                      .copyWith(color: Colors.blue),
                ),
              ),
              MaterialButton(
                onPressed: () => _updateCharacteristic(),
                child: Text(
                  'send data',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .labelLarge!
                      .copyWith(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
