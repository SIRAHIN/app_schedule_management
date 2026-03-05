import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void onNotificationTap(NotificationResponse response) async {
  String? packageName = response.payload;

  if (packageName != null) {
    FlutterDeviceApps.openApp(packageName);
  }
}