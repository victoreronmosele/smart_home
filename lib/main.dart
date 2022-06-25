import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.white),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                        child: DeviceCard(device: device),
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

/// A widget that displays a [Device].
class DeviceCard extends StatefulWidget {
  final Device device;
  const DeviceCard({Key? key, required this.device}) : super(key: key);

  @override
  State<DeviceCard> createState() => _DeviceCardState();
}

class _DeviceCardState extends State<DeviceCard> {
  bool isOn = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          alignment: const Alignment(-1.2, 0.0),
          child: Image.asset(
            widget.device.imageUrl,
            height: 80,
            width: 80,
          ),
        ),
      ],
    );
  }
}

/// Holds information about a device
enum Device {
  tv(name: 'TV', id: 1, imageUrl: 'assets/tv.png'),
  humidifier(name: 'Humidifier', id: 2, imageUrl: 'assets/humidifier.png'),
  airConditioner(name: 'AC', id: 3, imageUrl: 'assets/air_conditioner.png');

  final String name;
  final int id;
  final String imageUrl;

  const Device({required this.name, required this.id, required this.imageUrl});
}

/// Holds the status of the routines
enum RoutineStatus {
  moderate(title: 'Moderate', color: Colors.amber),
  allright(title: 'Alright', color: Colors.red),
  problematic(title: 'Probiematic', color: Colors.green);

  const RoutineStatus({required this.title, required this.color});

  final String title;
  final Color color;
}

/// Holds information about a routine
class Routine {
  final String name;
  final RoutineStatus status;
  final double value;
  final String unit;
  final NormalLevel normalLevel;
  final int deviceId;

  Routine(
      {required this.name,
      required this.status,
      required this.value,
      required this.unit,
      required this.normalLevel,
      required this.deviceId});
}

/// Holds information about the normal level of a routine
class NormalLevel {
  /// The highest normal threshold for a routine
  double? maximum;

  /// The lowest normal threshold for a routine
  double? minimum;

  NormalLevel({required this.maximum, required this.minimum})
      : assert(maximum != null && minimum != null,
            'maximum and minimum can not both be null');
}

/// A widget that displays a [Routine].
class RoutineWidget extends StatelessWidget {
  final Routine routine;

  const RoutineWidget({Key? key, required this.routine}) : super(key: key);

  String getNormalLevelInformation() {
    final maximum = routine.normalLevel.maximum;
    final minimum = routine.normalLevel.minimum;
    final unit = routine.unit;

    if (maximum == null && minimum == null) {
      return '';
    }

    String stringRepresentation = 'Normal';

    if (routine.normalLevel.maximum == routine.normalLevel.minimum) {
      stringRepresentation += ': $minimum$unit';
      return stringRepresentation;
    }

    if (routine.normalLevel.maximum == null) {
      stringRepresentation += ' above $minimum$unit';
      return stringRepresentation;
    }

    if (routine.normalLevel.minimum == null) {
      stringRepresentation += ' below $maximum$unit';
      return stringRepresentation;
    }

    stringRepresentation += ':  $minimum$unit - $maximum$unit';
    return stringRepresentation;
  }

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Device.values
        .firstWhere((device) => device.id == routine.deviceId,
            orElse: () => Device.values.first)
        .imageUrl;

    return IntrinsicHeight(
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                height: 40,
                width: 40,
                child: Card(
                  color: Colors.white,
                ),
              ),
              Image.asset(
                imageUrl,
                width: 40,
              ),
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                routine.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w200, fontSize: 12.0),
              ),
              Text(
                '${routine.value}${routine.unit}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28.0,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              )
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getNormalLevelInformation(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w200, fontSize: 12.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: routine.status.color,
                      radius: 4.0,
                    ),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        routine.status.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
