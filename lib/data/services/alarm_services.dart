import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/data/services/notification_services.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Alarm callback \
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

@pragma('vm:entry-point')
void alarmCallback(int id, Map<String, dynamic> params) async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- Initialize dependency injection ---
  configureDependencies(); // your getIt setup

  // --- Initialize Hive in this isolate ---
  await Hive.initFlutter(); // Important for background isolate
  Hive.registerAdapter(ScheduleAppModelAdapter());

  // --- Initialize notifications ---
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings = InitializationSettings(
    android: androidInit,
  );

  await notificationsPlugin.initialize(
    settings,
    onDidReceiveNotificationResponse: onNotificationTap,
  );

  // --- Your existing logic ---
  String? appPackageName = params['package'];
  if (appPackageName == null) return;

  final scheduleApp =
      await getIt<LocalDbSource>().getSingleScheduleApp(appPackageName);

  if (scheduleApp != null) {
    const androidDetails = AndroidNotificationDetails(
      'schedule_channel',
      'Schedule App',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await notificationsPlugin.show(
      id,
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
    appPackageName.hashCode, // unique ID per app
    alarmCallback, //  matches Function(int, Map)
    exact: true,
    wakeup: true,
    params: {'package': appPackageName}, // pass the package name here
  ).then((value) {
    print("Alarm scheduled successfully $value");
  }, onError: (error) {
    print("Alarm scheduled failed $error");
  });
}
