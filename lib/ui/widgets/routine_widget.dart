import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/utils/display_strings_util.dart';

/// A widget that displays a [Routine].
class RoutineWidget extends StatelessWidget {
  final Routine routine;
  final void Function() onTap;

  const RoutineWidget({Key? key, required this.routine, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String imageUrl = Device.values
        .firstWhere((device) => device.id == routine.deviceId,
            orElse: () => Device.values.first)
        .imageUrl;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        /// This makes the empty space in the widget a touch target
        color: Colors.transparent,
        child: IntrinsicHeight(
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
                    DisplayStringsUtil.getFullUnitAndValue(
                      value: routine.value,
                      unit: routine.unit,
                      showUnitFirst: routine.showUnitFirst,
                      showDecimal: routine.showDecimal,
                    ),
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
                      DisplayStringsUtil.getNormalLevelInformation(
                        minimum: routine.normalLevel.minimum,
                        maximum: routine.normalLevel.maximum,
                        unit: routine.unit,
                        showUnitFirst: routine.showUnitFirst,
                        showDecimal: routine.showDecimal,
                      ),
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
        ),
      ),
    );
  }
}
