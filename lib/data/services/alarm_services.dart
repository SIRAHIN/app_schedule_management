import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Alarm callback \
@pragma('vm:entry-point')
void alarmCallback(int id, Map<String, dynamic> params) async {
  WidgetsFlutterBinding.ensureInitialized();

  print("Alarm callback $params");

  String? appPackageName = params['package'];
  if (appPackageName == null) return;

  /// Init dependencies if background isolate
  if (!getIt.isRegistered<LocalDbSource>()) {
    configureDependencies();
    await initHive();
  }

  /// Initialize notifications in the background isolate
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const InitializationSettings initSettings = InitializationSettings(
    android: androidSettings,
  );
  await notificationsPlugin.initialize(initSettings);

  //  Show notification
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'alarm_channel',
    'Scheduled Apps',
    channelDescription: 'Notification for scheduled apps',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
    enableVibration: true,
  );

  const NotificationDetails notificationDetails = NotificationDetails(
    android: androidDetails,
  );

  await notificationsPlugin.show(
    id,
    "Scheduled App",
    "Time to open your ${params['appName']} app",
    notificationDetails,
    payload: appPackageName,
  );

  // Try auto-open app
  try {
    FlutterDeviceApps.openApp(appPackageName);
  } catch (e) {
    print("Auto open failed: $e");
  }
}

// Schedule alarm \\
Future<void> scheduleAlarm(DateTime time, String appPackageName, String appName) async {
  print("Schedule alarm $time $appPackageName");
  await AndroidAlarmManager.oneShotAt(
    time,
    appPackageName.hashCode,
    alarmCallback,
    exact: true,
    wakeup: true,
    allowWhileIdle: true,
    alarmClock: true,
    params: {'package': appPackageName, 'appName': appName},
  ).then(
    (value) {
      print("Alarm scheduled successfully $value");
    },
    onError: (error) {
      print("Alarm scheduled failed $error");
    },
  );
}

// Cancel alarm \\
Future<void> cancelAlarm(String appPackageName) async {
  await AndroidAlarmManager.cancel(appPackageName.hashCode);
}
