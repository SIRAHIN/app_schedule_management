import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/main.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';


// Alarm callback \
@pragma('vm:entry-point')
void alarmCallback(int id, Map<String, dynamic> params) async {
  print("Alarm callback $params");
  print("This is inside alarm callback");
  String? appPackageName = params['package'];
  if (appPackageName == null) return;
  print("App package name $appPackageName");

  if(getIt.isRegistered<LocalDbSource>()){
    print("LocalDbSource is already registered");
  }else{
    configureDependencies();
    await initHive();
  }
  FlutterDeviceApps.openApp(appPackageName);
}

// Schedule alarm \\
Future<void> scheduleAlarm(DateTime time, String appPackageName) async {
  print("Schedule alarm $time $appPackageName");
  await AndroidAlarmManager.oneShotAt(
    time,
    appPackageName.hashCode,
    alarmCallback,
    exact: true,
    wakeup: true,
    allowWhileIdle: true,
    alarmClock: true,
    params: {'package': appPackageName},
  ).then(
    (value) {
      print("Alarm scheduled successfully $value");
    },
    onError: (error) {
      print("Alarm scheduled failed $error");
    },
  );
}
