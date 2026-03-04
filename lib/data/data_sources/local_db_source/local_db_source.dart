import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';

abstract class LocalDbSource {
  Future<void> insertScheduleApp(ScheduleAppModel scheduleApp);
  Future<void> deleteScheduleApp(String appName);
  Future<void> updateScheduleApp(ScheduleAppModel scheduleApp);
  Future<List<ScheduleAppModel>> getAllScheduleApps();
  Future<ScheduleAppModel?> getSingleScheduleApp(String appName);
}