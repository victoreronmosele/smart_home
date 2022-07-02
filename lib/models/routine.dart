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
  final int routineId;

  /// Defaults to `true`
  ///
  /// If true, the unit is best displayed showing its decimals
  final bool showDecimal;

  /// Defaults to `false`
  ///
  /// If true, the unit is best displayed showing the unit first
  final bool showUnitFirst;
  final bool isSystemRoutine;

  Routine(
      {required this.name,
      required this.status,
      required this.value,
      required this.unit,
      required this.normalLevel,
      required this.deviceId,
      required this.routineId,
      this.showDecimal = true,
      this.showUnitFirst = false,
      this.isSystemRoutine = false});

  Routine copyWith({
    String? name,
    RoutineStatus? status,
    double? value,
    String? unit,
    NormalLevel? normalLevel,
    int? deviceId,
    bool? showDecimal,
    bool? showUnitFirst,
    bool? isSystemRoutine,
  }) {
    return Routine(
        name: name ?? this.name,
        status: status ?? this.status,
        value: value ?? this.value,
        unit: unit ?? this.unit,
        normalLevel: normalLevel ?? this.normalLevel,
        deviceId: deviceId ?? this.deviceId,
        routineId: routineId,
        showDecimal: showDecimal ?? this.showDecimal,
        showUnitFirst: showUnitFirst ?? this.showUnitFirst,
        isSystemRoutine: isSystemRoutine ?? this.isSystemRoutine);
  }
}
