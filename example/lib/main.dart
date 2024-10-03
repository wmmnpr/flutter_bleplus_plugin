import 'dart:async';

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
        uuid: 'CE061801-43E5-11E4-916C-0800200C9A66',
        characteristics: characteristics);
    List<BLEService> services = [service];
    BLEPeripheral peripheral = BLEPeripheral(
        name: 'PM Test',
        uuid: 'bf277777-860a-4e09-889c-2d8b6a9e0fe7',
        services: services);
    _blePeripheralApi.startAdvertising(peripheral);
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
                  'Press me',
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
