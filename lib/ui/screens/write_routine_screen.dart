import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/models/routine.dart';

/// This widget abstracts the UI for:
/// * creating new routines and,
/// * editing existing user created routines.
///
/// It is composed by the `AddRoutineScreen` and `EditRoutineScreen` widgets.
///
class WriteRoutine extends StatefulWidget {
  /// [routine] is nullable because this widget can be used to create a new routine
  /// or to edit an existing one.
  ///
  /// If [routine] is null, then the widget will be used to create a new routine.
  /// If [routine] is not null, then the widget will be used to edit the [routine].
  final Routine? routine;
  const WriteRoutine({Key? key, this.routine}) : super(key: key);

  @override
  State<WriteRoutine> createState() => _WriteRoutineState();
}

class _WriteRoutineState extends State<WriteRoutine> {
  bool get _isRoutineNull => widget.routine == null;

  Device? _selectedDevice;

  @override
  void initState() {
    super.initState();

    if (!_isRoutineNull) {
      _selectedDevice = Device.values
          .firstWhere((device) => device.id == widget.routine?.deviceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          _isRoutineNull ? 'Add Routine' : 'Edit Routine',
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Device',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              DropdownButtonHideUnderline(
                  child: DropdownButton<Device>(
                value: _selectedDevice,
                onChanged: (Device? value) {
                  setState(() {
                    _selectedDevice = value;
                  });
                },
                items: Device.values.map((Device device) {
                  return DropdownMenuItem(
                    value: device,
                    child: Row(
                      children: [
                        Image.asset(
                          device.imageUrl,
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        Text(device.longName),
                      ],
                    ),
                  );
                }).toList(),
                hint: const Text('Select a device'),
              )),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Name',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Value',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Unit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Unit Value Order',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Status',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Minimum Level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
              const Text(
                'Maximum Level',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      )),
    );
  }
}
