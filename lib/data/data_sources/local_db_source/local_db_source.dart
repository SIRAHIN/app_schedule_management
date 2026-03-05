import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';

abstract class LocalDbSource {
  Future<bool> insertScheduleApp(ScheduleAppModel scheduleApp);
  Future<bool> deleteScheduleApp(String appName);
  Future<bool> updateScheduleApp(ScheduleAppModel scheduleApp);
  Future<List<ScheduleAppModel>> getAllScheduleApps();
  Future<ScheduleAppModel?> getSingleScheduleApp(String appName);
}