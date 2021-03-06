import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/providers/routines_provider.dart';
import 'package:smart_home/ui/screens/edit_routine_screen.dart';
import 'package:smart_home/utils/display_strings_util.dart';

class RoutineScreen extends ConsumerStatefulWidget {
  final int routineId;
  const RoutineScreen({Key? key, required this.routineId}) : super(key: key);

  @override
  ConsumerState<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends ConsumerState<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    final Routine routine = ref.watch(routinesProvider).firstWhere(
          (element) => element.routineId == widget.routineId,
        );

    final routineDevice =
        Device.values.firstWhere((device) => device.id == routine.deviceId);

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
          routine.name,
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          /// Show Edit button if the routine is not a default one
          if (!routine.isSystemRoutine)
            Center(
                child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EditRoutineScreen(routine: routine),
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: const Text('Edit',
                      style: TextStyle(color: Colors.black))),
            )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Current Value:  ',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Container(
                padding: const EdgeInsets.all(64.0),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.black),
                child: Text(
                  DisplayStringsUtil.getFullUnitAndValue(
                      value: routine.value,
                      unit: routine.unit,
                      showUnitFirst: routine.showUnitFirst,
                      showDecimal: routine.showDecimal),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              const Text(
                'Running on: ',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                routineDevice.longName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
              Center(
                  child: Image.asset(
                routineDevice.imageUrl,
                height: 300,
                fit: BoxFit.fitWidth,
              )),
              Text.rich(
                TextSpan(
                    text: 'Status: ',
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                    children: [
                      TextSpan(
                        text: '(${DisplayStringsUtil.getNormalLevelInformation(
                          maximum: routine.normalLevel.maximum,
                          minimum: routine.normalLevel.minimum,
                          unit: routine.unit,
                          showUnitFirst: routine.showUnitFirst,
                          showDecimal: routine.showDecimal,
                        )})',
                        style: const TextStyle(fontStyle: FontStyle.italic),
                      ),
                    ]),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                routine.status.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: routine.status.color,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
