import 'package:flutter/material.dart';
import 'package:smart_home/models/routine.dart';
import 'package:smart_home/ui/screens/write_routine_screen.dart';

class EditRoutineScreen extends StatefulWidget {
  final Routine routine;
  const EditRoutineScreen({
    Key? key,
    required this.routine,
  }) : super(key: key);

  @override
  State<EditRoutineScreen> createState() => _EditRoutineScreenState();
}

class _EditRoutineScreenState extends State<EditRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return WriteRoutine(
      routine: widget.routine,
    );
  }
}
