import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/routine_status.dart';
import 'package:smart_home/enums/unit_value_order.dart';
import 'package:smart_home/models/normal_level.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/providers/routines_provider.dart';
import 'package:smart_home/utils/routine_id_generator.dart';

class WriteRoutineViewModel {
  WriteRoutineViewModel({required this.ref});

  WidgetRef ref;

  Routine createNewRoutine({
    required String name,
    required RoutineStatus status,
    required double value,
    required String unit,
    required UnitValueOrder unitValueOrder,
    required double minimumLevel,
    required double maximumLevel,
    required int deviceId,
  }) {
    try {
      final routineIDGEnerator = RoutineIDGenerator();

      final generatedRoutineId = routineIDGEnerator.generateRoutineId();

      final createdRoutine = Routine(
        name: name,
        status: status,
        value: value,
        unit: unit,
        normalLevel: NormalLevel(minimum: minimumLevel, maximum: maximumLevel),
        deviceId: deviceId,
        routineId: generatedRoutineId,
        showDecimal: true,
        showUnitFirst: unitValueOrder == UnitValueOrder.showUnitFirst,
        isSystemRoutine: false,
      );

      return createdRoutine;
    } catch (e) {
      throw Exception('Error creating new routine');
    }
  }

  Routine updateRoutine({
    required Routine originalRoutine,
    required String name,
    required RoutineStatus status,
    required double value,
    required String unit,
    required UnitValueOrder unitValueOrder,
    required double minimumLevel,
    required double maximumLevel,
    required int deviceId,
  }) {
    final updatedRoutine = originalRoutine.copyWith(
      name: name,
      status: status,
      value: value,
      unit: unit,
      normalLevel: NormalLevel(minimum: minimumLevel, maximum: maximumLevel),
      deviceId: deviceId,
      showDecimal: true,
      showUnitFirst: unitValueOrder == UnitValueOrder.showUnitFirst,
      isSystemRoutine: false,
    );

    return updatedRoutine;
  }

  void updateRoutineListWithRoutine(
      {required Routine routine, required bool isNew}) {
    final routineList = ref.read(routinesProvider.notifier).state;

    if (isNew) {
      routineList.add(routine);
    } else {
      routineList.removeWhere(
          (routineInList) => routineInList.routineId == routine.routineId);
      routineList.add(routine);
    }

  }
}
