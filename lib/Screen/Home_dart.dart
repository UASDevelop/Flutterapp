import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'Profiles_dart.dart';

class HoemScreen extends StatefulWidget {
  const HoemScreen({Key? key}) : super(key: key);

  @override
  _HoemScreenState createState() => _HoemScreenState();
}

class _HoemScreenState extends State<HoemScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scanDevices();
    initPlatformState();
  }

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var _deviceData = '';

  Future<void> initPlatformState() async {
    var deviceData = '';

    try {
      if (Platform.isAndroid) {
        deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.product;
  }

  _readIosDeviceInfo(IosDeviceInfo data) {
    return data.identifierForVendor;
  }

  FlutterBlue flutterBlue = FlutterBlue.instance;
  List devices = [];
  scanDevices() {
    // Start scanning
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print(
            '${r.device.name} found! rssi: ${r.device.name}');

        devices.add(r.device.id.toString());
      }
    });

// Stop scanning
    flutterBlue.stopScan();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_deviceData),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: ListView(
            children: devices.map((e) => Text(e)).toList(),
          )),
    );
  }
}
