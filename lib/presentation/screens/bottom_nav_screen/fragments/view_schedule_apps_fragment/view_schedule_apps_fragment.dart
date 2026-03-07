import 'dart:typed_data';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/core/helper/formate_converter.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/data/services/alarm_services.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/presentation/cubits/view_schedule_apps/cubit/view_schedule_apps_cubit.dart';
import 'package:app_schedule_management/presentation/screens/widgets/create_schedule_bottom_sheet.dart';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_schedule_apps_fragment/widgets/schedule_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:intl/intl.dart';

class ViewScheduleAppsFragment extends StatefulWidget {
  const ViewScheduleAppsFragment({super.key});

  @override
  State<ViewScheduleAppsFragment> createState() =>
      _ViewScheduleAppsFragmentState();
}

class _ViewScheduleAppsFragmentState extends State<ViewScheduleAppsFragment> {
  @override
  void initState() {
    super.initState();
    context.read<ViewScheduleAppsCubit>().getAllScheduleApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        title: const Text(
          'Scheduled Apps',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: Colors.red,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<ViewScheduleAppsCubit, ViewScheduleAppsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (scheduleApps) {
              if (scheduleApps.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.event_busy_rounded,
                        size: 72,
                        color: Colors.grey.shade300,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No scheduled apps yet',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                color: const Color(0xFFD32F2F),
                onRefresh: () async {
                  await context
                      .read<ViewScheduleAppsCubit>()
                      .getAllScheduleApps();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  itemCount: scheduleApps.length,
                  itemBuilder: (context, index) {
                    final scheduleApp = scheduleApps[index];

                    final Uint8List iconBytes =
                        FormatConverter.base64ToUint8List(scheduleApp.appIcon!);

                    final time = FormatConverter.base64ToTimeOfDay(
                      scheduleApp.selectedTime,
                    );

                    final formattedDate = DateFormat(
                      'E, dd MMM yyyy',
                    ).format(DateTime.parse(scheduleApp.selectedDate));

                    return ScheduleCard(
                      iconBytes: iconBytes,
                      appName: scheduleApp.appName,
                      scheduleLabel: scheduleApp.scheduleLabel,
                      formattedTime: time.format(context),
                      formattedDate: formattedDate,
                      onDelete: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: const Text('Remove Schedule'),
                            content: Text(
                              'Remove the schedule for "${scheduleApp.appName}"?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(ctx, true),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                                child: const Text('Remove'),
                              ),
                            ],
                          ),
                        );
                        if (confirmed == true) {
                          // Cancel alarm
                          await cancelAlarm(scheduleApp.packageName);

                          // Delete schedule app from local database
                          final isDeleteSuccess = await getIt<LocalDbSource>()
                              .deleteScheduleApp(scheduleApp.packageName);
                          if (isDeleteSuccess) {
                            await context
                                .read<ViewScheduleAppsCubit>()
                                .getAllScheduleApps();
                          }
                        }
                      },
                      onEdit: () {
                        showCreateScheduleBottomSheet(
                          context,
                          AppInfo(
                            appName: scheduleApp.appName,
                            iconBytes: FormatConverter.base64ToUint8List(
                              scheduleApp.appIcon!,
                            ),
                            packageName: scheduleApp.packageName,
                          ),
                          scheduleApp,
                        );
                      },
                    );
                  },
                ),
              );
            },
            error: (error) => Center(
              child: Text(
                error,
                style: const TextStyle(color: Colors.redAccent),
              ),
            ),
          );
        },
      ),
    );
  }
}
