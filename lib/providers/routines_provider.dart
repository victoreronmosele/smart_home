import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/routine_status.dart';
import 'package:smart_home/models/normal_level.dart';
import 'package:smart_home/models/routine.dart';

/// Holds default Routines
final routinesProvider = StateProvider((_) => [
      Routine(
          name: 'Room Temperature',
          status: RoutineStatus.problematic,
          value: 40.0,
          unit: ' °C',
          normalLevel: NormalLevel(minimum: 18, maximum: 25),
          deviceId: 3),
      Routine(
          name: 'Room Humidity',
          status: RoutineStatus.allright,
          value: 15.0,
          unit: '%',
          normalLevel: NormalLevel(minimum: 10, maximum: 20),
          deviceId: 2),
      Routine(
          name: 'TV Volume',
          status: RoutineStatus.moderate,
          value: 30.0,
          unit: 'db',
          normalLevel: NormalLevel(minimum: 0, maximum: 25),
          deviceId: 1),
      Routine(
          name: 'TV Channel',
          status: RoutineStatus.moderate,
          value: 30,
          unit: 'Ch ',
          normalLevel: NormalLevel(minimum: 1, maximum: 99),
          deviceId: 1,
          showDecimal: false, 
          showUnitFirst: true
          ),
    ]);
