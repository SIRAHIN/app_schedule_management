import 'package:app_schedule_management/data/services/app_installed_services.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'view_apps_state.dart';
part 'view_apps_cubit.freezed.dart';

@injectable
class ViewAppsCubit extends Cubit<ViewAppsState> {
  final AppInstalledServices _appInstalledServices;
  List<AppInfo> _allApps = [];
  List<AppInfo> _filteredApps = [];
  ViewAppsCubit(this._appInstalledServices) : super(ViewAppsState.initial());

  // Get Installed Apps
  Future<void> getInstalledApps() async {
    emit(ViewAppsState.loading());
    try {
      final apps = await _appInstalledServices.getInstalledApps();
      _allApps = apps;
      emit(ViewAppsState.loaded(apps));
    } catch (e) {
      emit(ViewAppsState.error(e.toString()));
    }
  }

  // Search Apps
  void searchApps(String query) {
    if (query.isEmpty) {
      _filteredApps = _allApps;
    } else {
      _filteredApps = _allApps
          .where(
            (app) => app.appName!.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    emit(ViewAppsState.loaded(_filteredApps));
  }
}
