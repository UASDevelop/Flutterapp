import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

import 'Profiles_dart.dart';

class HoemScreen extends StatefulWidget {
  const HoemScreen({Key? key}) : super(key: key);

  @override
  _HoemScreenState createState() => _HoemScreenState();
}

class _HoemScreenState extends State<HoemScreen> {
  StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
  List<BluetoothDiscoveryResult> results =
  List<BluetoothDiscoveryResult>.empty(growable: true);
  String? address='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _startDiscovery();
  }
  void _startDiscovery() {
    _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          setState(() {
            final existingIndex = results.indexWhere(
                    (element) => element.device.address == r.device.address);
            if (existingIndex >= 0)
              results[existingIndex] = r;
            else
              results.add(r);
          });
        });

    results.forEach((element) {

      final device = element.device;
       address = device.name;

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(address!),
      ),
      backgroundColor: Colors.grey.shade100,
      body: Padding(
          padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          child: Text(address.toString())),
    );
  }
}
