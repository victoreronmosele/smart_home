import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/enums/routine_status.dart';
import 'package:smart_home/models/normal_level.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/ui/screens/device_screen.dart';
import 'package:smart_home/ui/widgets/device_card.dart';
import 'package:smart_home/ui/widgets/routine_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final routineList = [
    Routine(
        name: 'Temperature',
        status: RoutineStatus.allright,
        value: 21.0,
        unit: ' °C',
        normalLevel: NormalLevel(minimum: 18, maximum: 25),
        deviceId: 3),
    Routine(
        name: 'Humidity',
        status: RoutineStatus.moderate,
        value: 24.0,
        unit: '%',
        normalLevel: NormalLevel(minimum: 30, maximum: 60),
        deviceId: 2),
  ];

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double screenWidth = screenSize.width;

    const double screenPaddingSize = 16.0;

    final double availableScreenWidth = screenWidth - screenPaddingSize;

    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              screenPaddingSize, screenPaddingSize, screenPaddingSize, 0.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome Home',
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Routines',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Column(
                children: [
                  ...routineList.map((routine) => Column(
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
              const SizedBox(
                height: 48.0,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Devices',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Wrap(
                  spacing: screenPaddingSize,
                  runSpacing: screenPaddingSize,
                  children: [
                    ...Device.values.map(
                      (device) => SizedBox(
                        width: (availableScreenWidth * 0.5) - screenPaddingSize,
                        child: DeviceCard(
                          device: device,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DeviceScreen(device: device),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
