import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';

void showCreateScheduleBottomSheet(BuildContext context, AppInfo app) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) {
      return CreateScheduleBottomSheet(app: app);
    },
  );
}

class CreateScheduleBottomSheet extends StatelessWidget {
  final AppInfo app;

  CreateScheduleBottomSheet({super.key, required this.app});

  final ValueNotifier<DateTime?> _selectedDate = ValueNotifier(null);
  final ValueNotifier<TimeOfDay?> _selectedTime = ValueNotifier(null);
  final TextEditingController _scheduleLabelController =
      TextEditingController();

  // FIX 1: Unfocus keyboard before opening pickers so viewInsets collapses
  // and the date/time row is never hidden behind the keyboard.
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

  // FIX 2: Single insertion point — no duplicate insertScheduleApp calls,
  // no missing Navigator.pop, no race between branches.
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

    final scheduleApp = ScheduleAppModel(
      packageName: app.packageName!,
      appName: app.appName!,
      selectedDate: _selectedDate.value!.toIso8601String(),
      selectedTime: _selectedTime.value!.format(context),
      appIcon: app.iconBytes.toString(),
    );

    final existing =
        await getIt<LocalDbSource>().getSingleScheduleApp(app.appName!);

    // Duplicate check: same app + same date + same time
    if (existing != null &&
        existing.selectedDate == scheduleApp.selectedDate &&
        existing.selectedTime == scheduleApp.selectedTime) {
      toastification.show(
        context: context,
        title: const Text('Schedule already exists'),
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 3),
        alignment: Alignment.topCenter,
      );
      return; // early-out, no insert, no pop
    }

    // Insert once — covers all remaining cases
    await getIt<LocalDbSource>().insertScheduleApp(scheduleApp);

    toastification.show(
      context: context,
      title: const Text('Schedule created successfully'),
      type: ToastificationType.success,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.topCenter,
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        // FIX 1: Only add bottom inset so the sheet rises with the keyboard,
        // but the content itself does NOT scroll — keeping date/time visible.
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
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
            leading: app.iconBytes != null
                ? Image.memory(app.iconBytes!, width: 50, height: 50)
                : const Icon(Icons.apps),
            title: Text(app.appName ?? ''),
            subtitle: Text(app.packageName ?? ''),
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

          /// Date & Time — always visible; tapping unfocuses the text field first
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
                          value == null
                              ? 'Select Time'
                              : value.format(context),
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
                child: const Text('Create Schedule'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}