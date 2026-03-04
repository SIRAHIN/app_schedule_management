import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AppInstalledServices {
  Future<List<AppInfo>> getInstalledApps() async {
    final apps = await FlutterDeviceApps.listApps(
      includeIcons: true,
      includeSystem: true,
      onlyLaunchable: true,
    );
    return apps;
  }
}
