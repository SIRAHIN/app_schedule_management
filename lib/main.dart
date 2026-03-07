import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:app_schedule_management/data/services/notification_services.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:app_schedule_management/injection.dart';
import 'package:app_schedule_management/presentation/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the app orientation to portrait mode \\
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  configureDependencies();

  await initHive();

  await AndroidAlarmManager.initialize();
  print("Alarm initialized");

  await NotificationService.init();
  print("Notification initialized");

  runApp(const App());
}

// Init Hive \\
Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ScheduleAppModelAdapter());
}
