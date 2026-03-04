// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_app_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ScheduleAppModelAdapter extends TypeAdapter<ScheduleAppModel> {
  @override
  final int typeId = 0;

  @override
  ScheduleAppModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ScheduleAppModel(
      packageName: fields[0] as String,
      appName: fields[1] as String,
      selectedDate: fields[2] as String,
      selectedTime: fields[3] as String,
      appIcon: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ScheduleAppModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.packageName)
      ..writeByte(1)
      ..write(obj.appName)
      ..writeByte(2)
      ..write(obj.selectedDate)
      ..writeByte(3)
      ..write(obj.selectedTime)
      ..writeByte(4)
      ..write(obj.appIcon);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScheduleAppModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleAppModelImpl _$$ScheduleAppModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleAppModelImpl(
      packageName: json['packageName'] as String,
      appName: json['appName'] as String,
      selectedDate: json['selectedDate'] as String,
      selectedTime: json['selectedTime'] as String,
      appIcon: json['appIcon'] as String?,
    );

Map<String, dynamic> _$$ScheduleAppModelImplToJson(
        _$ScheduleAppModelImpl instance) =>
    <String, dynamic>{
      'packageName': instance.packageName,
      'appName': instance.appName,
      'selectedDate': instance.selectedDate,
      'selectedTime': instance.selectedTime,
      'appIcon': instance.appIcon,
    };
