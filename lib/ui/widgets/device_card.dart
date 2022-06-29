import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';

/// A widget that displays a [Device].
class DeviceCard extends StatefulWidget {
  final Device device;
  final void Function() onTap;
  const DeviceCard({Key? key, required this.device, required this.onTap})
      : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: CupertinoSwitch(
                      value: isOn,
                      onChanged: (newOnState) {
                        setState(() {
                          isOn = newOnState;
                        });
                      },
                      activeColor: Colors.black,
                      trackColor: Colors.black26,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Text(
                    widget.device.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          Align(
            alignment: const Alignment(-1.5, 0.0),
            child: Image.asset(
              widget.device.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      ),
    );
  }
}
