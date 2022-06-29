import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/providers/routines_provider.dart';
import 'package:smart_home/ui/widgets/routine_widget.dart';

class DeviceScreen extends ConsumerStatefulWidget {
  final Device device;
  const DeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  ConsumerState<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends ConsumerState<DeviceScreen> {
  bool isOn = true;

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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.device.name,
                  style: const TextStyle(
                    fontSize: 36.0,
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                CupertinoSwitch(
                  value: isOn,
                  onChanged: (newOnState) {
                    setState(() {
                      isOn = newOnState;
                    });
                  },
                  activeColor: Colors.black,
                  trackColor: Colors.black26,
                ),
                const SizedBox(
                  height: 48.0,
                ),
                const Text(
                  'Routines',
                  style: TextStyle(
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
