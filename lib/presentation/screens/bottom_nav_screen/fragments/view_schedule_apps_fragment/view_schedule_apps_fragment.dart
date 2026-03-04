import 'dart:typed_data';
import 'package:app_schedule_management/core/helper/formate_converter.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/presentation/screens/bottom_nav_screen/fragments/view_apps_fragment/widgets/create_schedule_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';

class ViewScheduleAppsFragment extends StatelessWidget {
  const ViewScheduleAppsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Schedule Apps', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getIt<LocalDbSource>().getAllScheduleApps(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final scheduleApp = snapshot.data![index];

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
                        onPressed: () {
                          // Delete Schedule App
                          getIt<LocalDbSource>().deleteScheduleApp(scheduleApp.appName);
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
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}