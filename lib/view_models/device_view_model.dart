import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/providers/disabled_devices_provder.dart';

class DeviceViewModel {
  DeviceViewModel({
    required this.ref,
    required this.device,
  });

  WidgetRef ref;
  Device device;

  List<int> get _disabledDevices => ref.watch(disabledDevicesProvider);

  bool get isDeviceOn => !_disabledDevices.contains(device.id);

  /// Change [device] from `on` to `off` or from `off` to `on`
  void toggleDevicePower() {
    if (isDeviceOn) {
      ref.watch(disabledDevicesProvider.notifier).state = [
        ..._disabledDevices,
        device.id
      ];
    } else {
      ref.watch(disabledDevicesProvider.notifier).state = [..._disabledDevices]
        ..remove(device.id);
    }
  }
}
