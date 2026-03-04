import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocalDbSource)
class LocalDbSourceImpl implements LocalDbSource {
  @override
  Future<void> insertScheduleApp(ScheduleAppModel scheduleApp) async {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    await box.put(scheduleApp.appName, scheduleApp);
  }

  @override
  Future<void> deleteScheduleApp(String appName) async {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    await box.delete(appName);
  }

  @override
  Future<void> updateScheduleApp(ScheduleAppModel scheduleApp) async {
    final box = await Hive.openBox<ScheduleAppModel>('schedule_apps');
    await box.put(scheduleApp.appName, scheduleApp);
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