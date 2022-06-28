import 'package:smart_home/enums/routine_status.dart';
import 'package:smart_home/models/normal_level.dart';

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
