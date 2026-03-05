import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );

    await notificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    // Request POST_NOTIFICATIONS permission (required on Android 13+)
    final androidPlugin = notificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    await androidPlugin?.requestNotificationsPermission();
  }

  // On Notification Tap
  static void onNotificationTap(NotificationResponse response) async {
    String? packageName = response.payload;

    if (packageName != null) {
      FlutterDeviceApps.openApp(packageName);
    }
  }
}
