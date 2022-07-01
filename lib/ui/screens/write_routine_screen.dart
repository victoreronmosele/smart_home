import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_home/enums/device.dart';
import 'package:smart_home/enums/routine_status.dart';
import 'package:smart_home/enums/unit_value_order.dart';
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
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _valueController = TextEditingController();
  final _unitController = TextEditingController();
  final _minimumLevelController = TextEditingController();
  final _maximumLevelController = TextEditingController();

  /// This tells if a [Routine] was passed into the screen originally
  bool get _isRoutineArgumentNull => widget.routine == null;

  Device? _selectedDevice;
  UnitValueOrder? _selectedUnitValueOrder;
  RoutineStatus? _selectedRoutineStatus;

  /// Holds the error message for the device dropdown menu
  String? _selectedDeviceErrorMessage;

  /// Holds the error message for the unit value order dropdown menu
  String? _selectedUnitValueOrderErrorMessage;

  /// Determines whethether the routine device dropdown has an error or not
  String? _selectedRoutineStatusErrorMessage;

  @override
  void initState() {
    super.initState();

    if (!_isRoutineArgumentNull) {
      _selectedDevice = Device.values
          .firstWhere((device) => device.id == widget.routine!.deviceId);
      _selectedUnitValueOrder = widget.routine!.showUnitFirst
          ? UnitValueOrder.showUnitFirst
          : UnitValueOrder.showValueFirst;
      _selectedRoutineStatus = widget.routine!.status;

      _nameController.text = widget.routine!.name;
      _valueController.text = widget.routine!.value.toString();
      _unitController.text = widget.routine!.unit;
      _minimumLevelController.text =
          widget.routine!.normalLevel.minimum.toString();
      _maximumLevelController.text =
          widget.routine!.normalLevel.maximum.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _valueController.dispose();
    _unitController.dispose();
    _minimumLevelController.dispose();
    _maximumLevelController.dispose();
    super.dispose();
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
          _isRoutineArgumentNull ? 'Add Routine' : 'Edit Routine',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
                onTap: () {
                  validateAndSaveRoutine(context);
                },
                child:
                    const Text('Save', style: TextStyle(color: Colors.black))),
          )),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
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
                InputDecorator(
                  decoration: InputDecoration(
                      errorText: _selectedDeviceErrorMessage,
                      isCollapsed: true),
                  child: DropdownButtonHideUnderline(
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
                    ),
                  ),
                ),
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
                  height: 8.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a name',
                  ),
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Value',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a value',
                  ),
                  controller: _valueController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Unit',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a unit',
                  ),
                  controller: _unitController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a unit';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Unit Value Order',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      errorText: _selectedUnitValueOrderErrorMessage,
                      isCollapsed: true),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<UnitValueOrder>(
                      value: _selectedUnitValueOrder,
                      onChanged: (UnitValueOrder? value) {
                        setState(() {
                          _selectedUnitValueOrder = value;
                        });
                      },
                      items: UnitValueOrder.values
                          .map((UnitValueOrder unitValueOrder) {
                        return DropdownMenuItem(
                          value: unitValueOrder,
                          child: Text(
                              unitValueOrder == UnitValueOrder.showUnitFirst
                                  ? 'Show unit first e.g Ch 10'
                                  : 'Show value first e.g 10m'),
                        );
                      }).toList(),
                      hint: const Text('Select a unit value order'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      errorText: _selectedRoutineStatusErrorMessage,
                      isCollapsed: true),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<RoutineStatus>(
                      value: _selectedRoutineStatus,
                      onChanged: (RoutineStatus? value) {
                        setState(() {
                          _selectedRoutineStatus = value;
                        });
                      },
                      items: RoutineStatus.values
                          .map((RoutineStatus routineStatus) {
                        return DropdownMenuItem(
                          value: routineStatus,
                          child: Text(routineStatus.title),
                        );
                      }).toList(),
                      hint: const Text('Select a routine status'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Minimum Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a minimum level',
                  ),
                  controller: _minimumLevelController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a minimum level';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
                const Text(
                  'Maximum Level',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter a maximum level',
                  ),
                  controller: _maximumLevelController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a maximum level';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void validateAndSaveRoutine(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _selectedDeviceErrorMessage =
          _selectedDevice == null ? 'Please select a device' : null;
      _selectedUnitValueOrderErrorMessage = _selectedUnitValueOrder == null
          ? 'Please select a unit value order'
          : null;
      _selectedRoutineStatusErrorMessage = _selectedRoutineStatus == null
          ? 'Please select a routine status'
          : null;

      if (_selectedDeviceErrorMessage == null &&
          _selectedUnitValueOrderErrorMessage == null &&
          _selectedRoutineStatusErrorMessage == null) {
        setState(() {
          /// Clear any existing error message
        });
        Navigator.pop(context);
      } else {
        setState(() {
          /// Display error message
        });
      }
    }
  }
}
