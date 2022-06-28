import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';

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
