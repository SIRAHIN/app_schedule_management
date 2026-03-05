import 'dart:typed_data';
import 'package:app_schedule_management/core/helper/formate_converter.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/presentation/cubits/view_schedule_apps/cubit/view_schedule_apps_cubit.dart';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_apps_fragment/widgets/create_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';

class ViewScheduleAppsFragment extends StatefulWidget {
  const ViewScheduleAppsFragment({super.key});

  @override
  State<ViewScheduleAppsFragment> createState() => _ViewScheduleAppsFragmentState();
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
      appBar: AppBar(
        title: Text('View Schedule Apps', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: BlocBuilder<ViewScheduleAppsCubit, ViewScheduleAppsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator()),
            loading: () => const Center(child: CircularProgressIndicator()),
            loaded: (scheduleApps) {
              if (scheduleApps.isEmpty) {
                return const Center(child: Text('No Schedule Apps Found'));
              }
              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<ViewScheduleAppsCubit>().getAllScheduleApps();
                },
                child: ListView.builder(
                  itemCount: scheduleApps.length,
                  itemBuilder: (context, index) {
                    final scheduleApp = scheduleApps[index];
                
                    // Convert appIcon from base64 to Uint8List
                    Uint8List iconBytes = FormatConverter.base64ToUint8List(scheduleApp.appIcon!);
                
                    // Format selectedTime
                    final time = FormatConverter.base64ToTimeOfDay(scheduleApp.selectedTime);
                    
                    return ListTile(
                      leading: Image.memory(
                        iconBytes,
                        height: 50,
                        width: 50,
                      ),
                      title: Text(scheduleApp.appName),
                      subtitle: Text(time.format(context)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // Delete Schedule App
                              bool isDeleteSuccess = await getIt<LocalDbSource>().deleteScheduleApp(scheduleApp.packageName);
                              if(isDeleteSuccess){
                                print("This is delete success : $isDeleteSuccess");
                                await context.read<ViewScheduleAppsCubit>().getAllScheduleApps();
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // Edit Schedule App
                              showCreateScheduleBottomSheet(context, AppInfo(
                                appName: scheduleApp.appName,
                                iconBytes: FormatConverter.base64ToUint8List(scheduleApp.appIcon!),
                                packageName: scheduleApp.packageName,
                              ), scheduleApp);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
            error: (error) => Center(child: Text(error)),
          );
        },
      ),
    );
  }
}