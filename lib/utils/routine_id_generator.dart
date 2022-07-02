import 'package:flutter/material.dart';

/// Util class that generates IDs for [Routine]s.
class RoutineIDGenerator {
  /// Holds the current time
  DateTime? _now;

  /// Use this only for testing purposes.
  @visibleForTesting
  set now(DateTime now) => _now = now;

  /// Generates a new ID for a [Routine] using the current time.
  int generateRoutineId() {
    _now ??= DateTime.now();
    return _now!.millisecondsSinceEpoch;
  }
}


