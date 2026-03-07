import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocalDbSource)
class LocalDbSourceImpl implements LocalDbSource {
  @override
  Future<bool> insertScheduleApp(ScheduleAppModel scheduleApp) async {
    try {
      final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
      await box.put(scheduleApp.packageName, scheduleApp);
      return true;
    } catch (error) {
      print("Insert error: $error");
      return false;
    }
  }

  @override
  Future<bool> deleteScheduleApp(String appPackageName) async {
    try {
      final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
      await box.delete(appPackageName);
      return true;
    } catch (error) {
      print("Delete error: $error");
      return false;
    }
  }

  @override
  Future<bool> updateScheduleApp(ScheduleAppModel scheduleApp) async {
    try {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    await box.put(scheduleApp.packageName, scheduleApp);
    print("Update success");
    return true;
  } catch (error) {
    print("Update error: $error");
    return false;
  }
}

  @override
  Future<List<ScheduleAppModel>> getAllScheduleApps() async {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    return box.values.toList();
  }

  @override
  Future<ScheduleAppModel?> getSingleScheduleApp(String appPackageName) async {
    try {
      final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
      return box.get(appPackageName);
    } catch (error) {
      print("Get single error: $error");
      return null;
    }
  }
}