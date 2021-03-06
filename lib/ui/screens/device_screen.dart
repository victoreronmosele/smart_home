import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/providers/routines_provider.dart';
import 'package:smart_home/ui/screens/routine_screen.dart';
import 'package:smart_home/ui/widgets/routine_widget.dart';
import 'package:smart_home/view_models/device_view_model.dart';

class DeviceScreen extends ConsumerStatefulWidget {
  final Device device;
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  ConsumerState<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends ConsumerState<DeviceScreen> {
  DeviceViewModel get viewModel =>
      DeviceViewModel(ref: ref, device: widget.device);

  @override
  Widget build(BuildContext context) {
    final List<Routine> deviceRoutineList = ref
        .watch(routinesProvider)
        .where((routine) => routine.deviceId == widget.device.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.device.longName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text(
                      'Power',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    CupertinoSwitch(
                      value: viewModel.isDeviceOn,
                      onChanged: (newOnState) {
                        setState(() {
                          viewModel.toggleDevicePower();
                        });
                      },
                      activeColor: Colors.black,
                      trackColor: Colors.black26,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Center(
                    child: Image.asset(
                  widget.device.imageUrl,
                  height: 300,
                  fit: BoxFit.fitWidth,
                )),
                Text(
                  'Running Routines (${deviceRoutineList.length})',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Column(
                  children: [
                    ...deviceRoutineList.map((routine) => Column(
                          children: [
                            const SizedBox(height: 12.0),
                            RoutineWidget(
                              routine: routine,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RoutineScreen(
                                        routineId: routine.routineId),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 12.0),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
