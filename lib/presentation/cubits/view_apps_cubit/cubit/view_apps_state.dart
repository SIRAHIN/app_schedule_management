part of 'view_apps_cubit.dart';

@freezed
class ViewAppsState with _$ViewAppsState {
  const factory ViewAppsState.initial() = _Initial;
  const factory ViewAppsState.loading() = _Loading;
  const factory ViewAppsState.loaded(List<AppInfo> apps) = _Loaded;
  const factory ViewAppsState.error(String error) = _Error;
}
