import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';

class DeviceScreen extends StatelessWidget {
  final Device device;
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(device.name),
      ),
    );
  }
}
