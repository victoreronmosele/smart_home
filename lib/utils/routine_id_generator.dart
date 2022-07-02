import 'package:flutter/material.dart';

/// Util class that generates IDs for [Routine]s.
class RoutineIDGenerator {
  DateTime? _now;

  @visibleForTesting
  set now(DateTime now) => _now = now;

  String generateRoutineId() {
    _now ??= DateTime.now();
    return _now!.millisecondsSinceEpoch.toString();
  }
}
