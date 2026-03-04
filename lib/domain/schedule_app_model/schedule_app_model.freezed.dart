// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule_app_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ScheduleAppModel _$ScheduleAppModelFromJson(Map<String, dynamic> json) {
  return _ScheduleAppModel.fromJson(json);
}

/// @nodoc
mixin _$ScheduleAppModel {
  @HiveField(0)
  String get packageName => throw _privateConstructorUsedError;
  @HiveField(1)
  String get appName => throw _privateConstructorUsedError;
  @HiveField(2)
  String get selectedDate => throw _privateConstructorUsedError;
  @HiveField(3)
  String get selectedTime => throw _privateConstructorUsedError;
  @HiveField(4)
  String? get appIcon => throw _privateConstructorUsedError;
  @HiveField(5)
  String? get scheduleLabel => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleAppModelCopyWith<ScheduleAppModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleAppModelCopyWith<$Res> {
  factory $ScheduleAppModelCopyWith(
          ScheduleAppModel value, $Res Function(ScheduleAppModel) then) =
      _$ScheduleAppModelCopyWithImpl<$Res, ScheduleAppModel>;
  @useResult
  $Res call(
      {@HiveField(0) String packageName,
      @HiveField(1) String appName,
      @HiveField(2) String selectedDate,
      @HiveField(3) String selectedTime,
      @HiveField(4) String? appIcon,
      @HiveField(5) String? scheduleLabel});
}

/// @nodoc
class _$ScheduleAppModelCopyWithImpl<$Res, $Val extends ScheduleAppModel>
    implements $ScheduleAppModelCopyWith<$Res> {
  _$ScheduleAppModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? appName = null,
    Object? selectedDate = null,
    Object? selectedTime = null,
    Object? appIcon = freezed,
    Object? scheduleLabel = freezed,
  }) {
    return _then(_value.copyWith(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTime: null == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as String,
      appIcon: freezed == appIcon
          ? _value.appIcon
          : appIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleLabel: freezed == scheduleLabel
          ? _value.scheduleLabel
          : scheduleLabel // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ScheduleAppModelImplCopyWith<$Res>
    implements $ScheduleAppModelCopyWith<$Res> {
  factory _$$ScheduleAppModelImplCopyWith(_$ScheduleAppModelImpl value,
          $Res Function(_$ScheduleAppModelImpl) then) =
      __$$ScheduleAppModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String packageName,
      @HiveField(1) String appName,
      @HiveField(2) String selectedDate,
      @HiveField(3) String selectedTime,
      @HiveField(4) String? appIcon,
      @HiveField(5) String? scheduleLabel});
}

/// @nodoc
class __$$ScheduleAppModelImplCopyWithImpl<$Res>
    extends _$ScheduleAppModelCopyWithImpl<$Res, _$ScheduleAppModelImpl>
    implements _$$ScheduleAppModelImplCopyWith<$Res> {
  __$$ScheduleAppModelImplCopyWithImpl(_$ScheduleAppModelImpl _value,
      $Res Function(_$ScheduleAppModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packageName = null,
    Object? appName = null,
    Object? selectedDate = null,
    Object? selectedTime = null,
    Object? appIcon = freezed,
    Object? scheduleLabel = freezed,
  }) {
    return _then(_$ScheduleAppModelImpl(
      packageName: null == packageName
          ? _value.packageName
          : packageName // ignore: cast_nullable_to_non_nullable
              as String,
      appName: null == appName
          ? _value.appName
          : appName // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as String,
      selectedTime: null == selectedTime
          ? _value.selectedTime
          : selectedTime // ignore: cast_nullable_to_non_nullable
              as String,
      appIcon: freezed == appIcon
          ? _value.appIcon
          : appIcon // ignore: cast_nullable_to_non_nullable
              as String?,
      scheduleLabel: freezed == scheduleLabel
          ? _value.scheduleLabel
          : scheduleLabel // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ScheduleAppModelImpl implements _ScheduleAppModel {
  const _$ScheduleAppModelImpl(
      {@HiveField(0) required this.packageName,
      @HiveField(1) required this.appName,
      @HiveField(2) required this.selectedDate,
      @HiveField(3) required this.selectedTime,
      @HiveField(4) this.appIcon,
      @HiveField(5) this.scheduleLabel});

  factory _$ScheduleAppModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScheduleAppModelImplFromJson(json);

  @override
  @HiveField(0)
  final String packageName;
  @override
  @HiveField(1)
  final String appName;
  @override
  @HiveField(2)
  final String selectedDate;
  @override
  @HiveField(3)
  final String selectedTime;
  @override
  @HiveField(4)
  final String? appIcon;
  @override
  @HiveField(5)
  final String? scheduleLabel;

  @override
  String toString() {
    return 'ScheduleAppModel(packageName: $packageName, appName: $appName, selectedDate: $selectedDate, selectedTime: $selectedTime, appIcon: $appIcon, scheduleLabel: $scheduleLabel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScheduleAppModelImpl &&
            (identical(other.packageName, packageName) ||
                other.packageName == packageName) &&
            (identical(other.appName, appName) || other.appName == appName) &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.selectedTime, selectedTime) ||
                other.selectedTime == selectedTime) &&
            (identical(other.appIcon, appIcon) || other.appIcon == appIcon) &&
            (identical(other.scheduleLabel, scheduleLabel) ||
                other.scheduleLabel == scheduleLabel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, packageName, appName,
      selectedDate, selectedTime, appIcon, scheduleLabel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ScheduleAppModelImplCopyWith<_$ScheduleAppModelImpl> get copyWith =>
      __$$ScheduleAppModelImplCopyWithImpl<_$ScheduleAppModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScheduleAppModelImplToJson(
      this,
    );
  }
}

abstract class _ScheduleAppModel implements ScheduleAppModel {
  const factory _ScheduleAppModel(
      {@HiveField(0) required final String packageName,
      @HiveField(1) required final String appName,
      @HiveField(2) required final String selectedDate,
      @HiveField(3) required final String selectedTime,
      @HiveField(4) final String? appIcon,
      @HiveField(5) final String? scheduleLabel}) = _$ScheduleAppModelImpl;

  factory _ScheduleAppModel.fromJson(Map<String, dynamic> json) =
      _$ScheduleAppModelImpl.fromJson;

  @override
  @HiveField(0)
  String get packageName;
  @override
  @HiveField(1)
  String get appName;
  @override
  @HiveField(2)
  String get selectedDate;
  @override
  @HiveField(3)
  String get selectedTime;
  @override
  @HiveField(4)
  String? get appIcon;
  @override
  @HiveField(5)
  String? get scheduleLabel;
  @override
  @JsonKey(ignore: true)
  _$$ScheduleAppModelImplCopyWith<_$ScheduleAppModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
