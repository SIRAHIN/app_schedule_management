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
  ViewAppsCubit(this._appInstalledServices) : super(ViewAppsState.initial());

  Future<void> getInstalledApps() async {
    emit(ViewAppsState.loading());
    try {
      final apps = await _appInstalledServices.getInstalledApps();
      emit(ViewAppsState.loaded(apps));
    } catch (e) {
      emit(ViewAppsState.error(e.toString()));
    }
  }
}
