import 'dart:convert';

import 'package:app_schedule_management/core/helper/formate_converter.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

void showCreateScheduleBottomSheet(
  BuildContext context,
  AppInfo app,
  ScheduleAppModel? scheduleApp,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CreateScheduleBottomSheet(app: app, scheduleApp: scheduleApp);
    },
  );
}

// Value Notifiers
late ValueNotifier<DateTime?> _selectedDate;
late ValueNotifier<TimeOfDay?> _selectedTime;

// Controllers
late TextEditingController _scheduleLabelController;

class CreateScheduleBottomSheet extends StatefulWidget {
  final AppInfo app;
  final ScheduleAppModel? scheduleApp;

  CreateScheduleBottomSheet({super.key, required this.app, this.scheduleApp});

  @override
  State<CreateScheduleBottomSheet> createState() =>
      _CreateScheduleBottomSheetState();
}

class _CreateScheduleBottomSheetState extends State<CreateScheduleBottomSheet> {
  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 150));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate.value ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate.value) {
      _selectedDate.value = picked;
    }
  }

  // Time Picker
  Future<void> _selectTime(BuildContext context) async {
    FocusScope.of(context).unfocus();
    await Future.delayed(const Duration(milliseconds: 150));

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime.value ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime.value) {
      _selectedTime.value = picked;
    }
  }

  // Create Schedule
  Future<void> _onCreatePressed(BuildContext context) async {
    if (_selectedDate.value == null || _selectedTime.value == null) {
      toastification.show(
        context: context,
        title: const Text('Please select date and time'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
      );
      return;
    }

    // Create Single Schedule App Model
    final scheduleApp = ScheduleAppModel(
      packageName: widget.app.packageName!,
      appName: widget.app.appName!,
      selectedDate: _selectedDate.value!.toIso8601String(),
      selectedTime:
          '${_selectedTime.value!.hour.toString().padLeft(2, '0')}:${_selectedTime.value!.minute.toString().padLeft(2, '0')}',
      appIcon: base64Encode(widget.app.iconBytes!),
      scheduleLabel: _scheduleLabelController.text,
    );

    // Get All Schedule Apps
    final List<ScheduleAppModel> existingScheduleApps =
        await getIt<LocalDbSource>().getAllScheduleApps();

    // Duplicate check: same date + same time
    for (var element in existingScheduleApps) {
      if (element.selectedDate == scheduleApp.selectedDate &&
          element.selectedTime == scheduleApp.selectedTime) {
        toastification.show(
          context: context,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.memory(
                FormatConverter.base64ToUint8List(element.appIcon!),
                height: 25,
                width: 25,
              ),
              SizedBox(width: 5.w),
              Text("Schedule Conflict"),
            ],
          ),
          description: Text(
            '${element.appName} is already scheduled at ${element.selectedTime} ${_selectedTime.value?.period.name} on ${FormatConverter.formatDateTime(_selectedDate.value!)}.',
          ),
          type: ToastificationType.info,
          autoCloseDuration: const Duration(seconds: 4),
          alignment: Alignment.topCenter,
          style: ToastificationStyle.minimal,
          showProgressBar: true,
        );
        return;
      }
    }

    // Insert Schedule App || Update Schedule App
    if (widget.scheduleApp != null) {
      await getIt<LocalDbSource>().updateScheduleApp(scheduleApp);
    } else {
      await getIt<LocalDbSource>().insertScheduleApp(scheduleApp);
    }

    // Show Success Toast
    toastification.show(
      context: context,
      title: widget.scheduleApp != null
          ? const Text('Schedule updated successfully')
          : const Text('Schedule created successfully'),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
    );

    Navigator.pop(context);
  }

  // Init State
  @override
  void initState() {
    super.initState();
    _scheduleLabelController = TextEditingController(
      text: widget.scheduleApp?.scheduleLabel,
    );
    _selectedDate = ValueNotifier(
      widget.scheduleApp?.selectedDate != null
          ? DateTime.parse(widget.scheduleApp!.selectedDate)
          : null,
    );
    _selectedTime = ValueNotifier(
      widget.scheduleApp?.selectedTime != null
          ? TimeOfDay(
              hour: int.parse(widget.scheduleApp!.selectedTime.split(':')[0]),
              minute: int.parse(widget.scheduleApp!.selectedTime.split(':')[1]),
            )
          : null,
    );
  }

  // Dispose
  @override
  void dispose() {
    _scheduleLabelController.dispose();
    _selectedDate.dispose();
    _selectedTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Create New Schedule',
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.h),

          /// App Info
          ListTile(
            leading: widget.app.iconBytes != null
                ? Image.memory(widget.app.iconBytes!, width: 50, height: 50)
                : const Icon(Icons.apps),
            title: Text(widget.app.appName ?? ''),
            subtitle: Text(widget.app.packageName ?? ''),
          ),

          SizedBox(height: 10.h),

          TextField(
            controller: _scheduleLabelController,
            decoration: const InputDecoration(
              hintText: 'Schedule Label',
              border: OutlineInputBorder(),
            ),
          ),

          SizedBox(height: 20.h),

          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _selectDate(context),
                  child: ValueListenableBuilder<DateTime?>(
                    valueListenable: _selectedDate,
                    builder: (context, value, child) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Date',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          value == null
                              ? 'Select Date'
                              : '${value.day}/${value.month}/${value.year}',
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: InkWell(
                  onTap: () => _selectTime(context),
                  child: ValueListenableBuilder<TimeOfDay?>(
                    valueListenable: _selectedTime,
                    builder: (context, value, child) {
                      return InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Time',
                          border: OutlineInputBorder(),
                        ),
                        child: Text(
                          value == null ? 'Select Time' : value.format(context),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 20.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => _onCreatePressed(context),
                child: widget.scheduleApp != null
                    ? Text('Update Schedule')
                    : Text('Create Schedule'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
