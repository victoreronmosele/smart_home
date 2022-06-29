import 'package:flutter/material.dart';

/// Holds the status of the routines
enum RoutineStatus {
  moderate(title: 'Moderate', color: Colors.amber),
  allright(title: 'Alright', color: Colors.green),
  problematic(title: 'Probiematic', color: Colors.red);

  const RoutineStatus({required this.title, required this.color});

  final String title;
  final Color color;
}