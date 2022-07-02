import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/view_models/device_view_model.dart';

/// A widget that displays a [Device].
class DeviceCard extends ConsumerStatefulWidget {
  final Device device;
  final void Function() onTap;
  const DeviceCard({Key? key, required this.device, required this.onTap})
      : super(key: key);

  @override
  ConsumerState<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends ConsumerState<DeviceCard> {
  DeviceViewModel get viewModel =>
      DeviceViewModel(ref: ref, device: widget.device);

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
                      value: viewModel.isDeviceOn,
                      onChanged: (newOnState) {
                        setState(() {
                          viewModel.toggleDevicePower();
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
