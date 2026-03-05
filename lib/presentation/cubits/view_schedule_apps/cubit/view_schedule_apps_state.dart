part of 'view_schedule_apps_cubit.dart';

@freezed
class ViewScheduleAppsState with _$ViewScheduleAppsState {
  const factory ViewScheduleAppsState.initial() = _Initial;
  const factory ViewScheduleAppsState.loading() = _Loading;
  const factory ViewScheduleAppsState.loaded(List<ScheduleAppModel> scheduleApps) = _Loaded;
  const factory ViewScheduleAppsState.error(String error) = _Error;
}
