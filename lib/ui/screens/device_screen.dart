import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';

class DeviceScreen extends StatelessWidget {
  final Device device;
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(CupertinoIcons.arrow_left, color: Colors.black,),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  device.name,
                  style: const TextStyle(
                    fontSize: 36.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
