import 'package:flutter/material.dart';
import 'package:smart_home/models/routine.dart';

class RoutineScreen extends StatelessWidget {
  final Routine routine;
  const RoutineScreen({Key? key, required this.routine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(routine.name),
      ),
    );
  }
}
