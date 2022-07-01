import 'package:flutter/material.dart';
import 'package:smart_home/ui/screens/write_routine_screen.dart';

class AddRoutineScreen extends StatefulWidget {
  const AddRoutineScreen({Key? key}) : super(key: key);

  @override
  State<AddRoutineScreen> createState() => _AddRoutineScreenState();
}

class _AddRoutineScreenState extends State<AddRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return const WriteRoutine();
  }
}
