import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/providers/disabled_devices_provder.dart';
import 'package:smart_home/providers/routines_provider.dart';

final activeRoutinesProvider = StateProvider((ref) {
  final disabledDevices = ref.watch(disabledDevicesProvider);

  final availableRoutines = ref.watch(routinesProvider);

  final availableRoutinesWithPoweredOnDevices = availableRoutines
      .where((element) => !disabledDevices.contains(element.deviceId))
      .toList();

  return availableRoutinesWithPoweredOnDevices;
});
