import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'schedule_app_model.freezed.dart';
part 'schedule_app_model.g.dart';

@freezed
@HiveType(typeId: 0)
class ScheduleAppModel with _$ScheduleAppModel {
  const factory ScheduleAppModel({
    @HiveField(0) required String packageName,
    @HiveField(1) required String appName,
    @HiveField(2) required String selectedDate,
    @HiveField(3) required String selectedTime,
    @HiveField(4) String? appIcon,
    @HiveField(5) String? scheduleLabel,
  }) = _ScheduleAppModel;

  factory ScheduleAppModel.fromJson(Map<String, dynamic> json) =>
      _$ScheduleAppModelFromJson(json);
}