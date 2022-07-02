import 'package:smart_home/utils/routine_id_generator.dart';
import 'package:test/test.dart';

void main() {
  group('RoutineIDGenerator', () {
    test(
        'generateRoutineId generates expected routine ID from current date time ',
        () {
      final RoutineIDGenerator routineIDGenerator = RoutineIDGenerator();

      final DateTime mockCurrentDate = DateTime(2020, 1, 1, 0, 0, 0, 0);

      routineIDGenerator.now = mockCurrentDate;

      final String expectedRoutineID =
          '${mockCurrentDate.millisecondsSinceEpoch}';

      final String actualRoutineId = routineIDGenerator.generateRoutineId();

      expect(actualRoutineId, expectedRoutineID);
    });
  });
}
