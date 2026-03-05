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
      await box.put(scheduleApp.appName, scheduleApp);
      return true;
    } catch (error) {
      print("Insert error: $error");
      return false;
    }
  }

  @override
  Future<bool> deleteScheduleApp(String appName) async {
    try {
      final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
      await box.delete(appName);
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

      await box.put(scheduleApp.appName, scheduleApp);

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
  Future<ScheduleAppModel?> getSingleScheduleApp(String appName) async {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    return box.get(appName);
  }
}