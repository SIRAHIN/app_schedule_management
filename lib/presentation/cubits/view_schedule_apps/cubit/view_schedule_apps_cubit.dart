import 'package:app_schedule_management/data/data_sources/local_db_source/local_db_source.dart';
import 'package:app_schedule_management/domain/schedule_app_model/schedule_app_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'view_schedule_apps_state.dart';
part 'view_schedule_apps_cubit.freezed.dart';

@injectable
class ViewScheduleAppsCubit extends Cubit<ViewScheduleAppsState> {
  final LocalDbSource _localDbSource;
  ViewScheduleAppsCubit(this._localDbSource) : super(ViewScheduleAppsState.initial());

  // Get All Schedule Apps
  Future<void> getAllScheduleApps() async {
    emit(ViewScheduleAppsState.loading());
    try {
      final scheduleApps = await _localDbSource.getAllScheduleApps();
      emit(ViewScheduleAppsState.loaded(scheduleApps));
    } catch (e) {
      emit(ViewScheduleAppsState.error(e.toString()));
    }
  }
}
