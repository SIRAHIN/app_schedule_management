import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/data/services/notification_services.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


// Alarm callback \
@pragma('vm:entry-point')
void alarmCallback(int id, Map<String, dynamic> params) async {
  print("Alarm callback $params");
  print("This is inside alarm callback");
  String? appPackageName = params['package'];
  if (appPackageName == null) return;
  print("App package name $appPackageName");

    WidgetsFlutterBinding.ensureInitialized();



  configureDependencies();

  await initHive();

  await AndroidAlarmManager.initialize();

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidInit,
  );

  await notificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: onNotificationTap,
  );

  final scheduleApp = await getIt<LocalDbSource>().getSingleScheduleApp(
    appPackageName,
  );
  print("Schedule app $scheduleApp");
  if (scheduleApp != null) {
    const androidDetails = AndroidNotificationDetails(
      'schedule_channel',
      'Schedule App',
      importance: Importance.max,
      priority: Priority.high,
    );
    const notificationDetails = NotificationDetails(android: androidDetails);
    await notificationsPlugin.show(
      0,
      'Time to use ${scheduleApp.appName}!',
      'Tap to open ${scheduleApp.appName}',
      notificationDetails,
      payload: scheduleApp.packageName,
    );
  }
}

// Schedule alarm \\
Future<void> scheduleAlarm(DateTime time, String appPackageName) async {
  await AndroidAlarmManager.oneShotAt(
    time,
    appPackageName.hashCode,
    alarmCallback,
    exact: true,
    wakeup: true,
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
