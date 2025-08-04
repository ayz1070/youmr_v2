// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_settings_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationSettingsDto _$NotificationSettingsDtoFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsDto.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsDto {
  /// 사용자 ID
  String get userId => throw _privateConstructorUsedError;

  /// 전체 알림 활성화 여부
  bool get isEnabled => throw _privateConstructorUsedError;

  /// 출석 체크 알림 활성화 여부
  bool get attendanceReminderEnabled => throw _privateConstructorUsedError;

  /// 회비 알림 활성화 여부
  bool get monthlyFeeReminderEnabled => throw _privateConstructorUsedError;

  /// 출석 체크 알림 시간 (HH:mm 형식)
  String get attendanceReminderTime => throw _privateConstructorUsedError;

  /// 출석 체크 알림 요일 (1-7, 월-일)
  int get attendanceReminderDayOfWeek => throw _privateConstructorUsedError;

  /// 생성 시간
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 수정 시간
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettingsDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsDtoCopyWith<NotificationSettingsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsDtoCopyWith<$Res> {
  factory $NotificationSettingsDtoCopyWith(NotificationSettingsDto value,
          $Res Function(NotificationSettingsDto) then) =
      _$NotificationSettingsDtoCopyWithImpl<$Res, NotificationSettingsDto>;
  @useResult
  $Res call(
      {String userId,
      bool isEnabled,
      bool attendanceReminderEnabled,
      bool monthlyFeeReminderEnabled,
      String attendanceReminderTime,
      int attendanceReminderDayOfWeek,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class _$NotificationSettingsDtoCopyWithImpl<$Res,
        $Val extends NotificationSettingsDto>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  _$NotificationSettingsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? isEnabled = null,
    Object? attendanceReminderEnabled = null,
    Object? monthlyFeeReminderEnabled = null,
    Object? attendanceReminderTime = null,
    Object? attendanceReminderDayOfWeek = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceReminderEnabled: null == attendanceReminderEnabled
          ? _value.attendanceReminderEnabled
          : attendanceReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlyFeeReminderEnabled: null == monthlyFeeReminderEnabled
          ? _value.monthlyFeeReminderEnabled
          : monthlyFeeReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceReminderTime: null == attendanceReminderTime
          ? _value.attendanceReminderTime
          : attendanceReminderTime // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceReminderDayOfWeek: null == attendanceReminderDayOfWeek
          ? _value.attendanceReminderDayOfWeek
          : attendanceReminderDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsDtoImplCopyWith<$Res>
    implements $NotificationSettingsDtoCopyWith<$Res> {
  factory _$$NotificationSettingsDtoImplCopyWith(
          _$NotificationSettingsDtoImpl value,
          $Res Function(_$NotificationSettingsDtoImpl) then) =
      __$$NotificationSettingsDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      bool isEnabled,
      bool attendanceReminderEnabled,
      bool monthlyFeeReminderEnabled,
      String attendanceReminderTime,
      int attendanceReminderDayOfWeek,
      DateTime createdAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$NotificationSettingsDtoImplCopyWithImpl<$Res>
    extends _$NotificationSettingsDtoCopyWithImpl<$Res,
        _$NotificationSettingsDtoImpl>
    implements _$$NotificationSettingsDtoImplCopyWith<$Res> {
  __$$NotificationSettingsDtoImplCopyWithImpl(
      _$NotificationSettingsDtoImpl _value,
      $Res Function(_$NotificationSettingsDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? isEnabled = null,
    Object? attendanceReminderEnabled = null,
    Object? monthlyFeeReminderEnabled = null,
    Object? attendanceReminderTime = null,
    Object? attendanceReminderDayOfWeek = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$NotificationSettingsDtoImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isEnabled: null == isEnabled
          ? _value.isEnabled
          : isEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceReminderEnabled: null == attendanceReminderEnabled
          ? _value.attendanceReminderEnabled
          : attendanceReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      monthlyFeeReminderEnabled: null == monthlyFeeReminderEnabled
          ? _value.monthlyFeeReminderEnabled
          : monthlyFeeReminderEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      attendanceReminderTime: null == attendanceReminderTime
          ? _value.attendanceReminderTime
          : attendanceReminderTime // ignore: cast_nullable_to_non_nullable
              as String,
      attendanceReminderDayOfWeek: null == attendanceReminderDayOfWeek
          ? _value.attendanceReminderDayOfWeek
          : attendanceReminderDayOfWeek // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsDtoImpl implements _NotificationSettingsDto {
  const _$NotificationSettingsDtoImpl(
      {required this.userId,
      this.isEnabled = true,
      this.attendanceReminderEnabled = true,
      this.monthlyFeeReminderEnabled = true,
      this.attendanceReminderTime = '12:00',
      this.attendanceReminderDayOfWeek = 1,
      required this.createdAt,
      required this.updatedAt});

  factory _$NotificationSettingsDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationSettingsDtoImplFromJson(json);

  /// 사용자 ID
  @override
  final String userId;

  /// 전체 알림 활성화 여부
  @override
  @JsonKey()
  final bool isEnabled;

  /// 출석 체크 알림 활성화 여부
  @override
  @JsonKey()
  final bool attendanceReminderEnabled;

  /// 회비 알림 활성화 여부
  @override
  @JsonKey()
  final bool monthlyFeeReminderEnabled;

  /// 출석 체크 알림 시간 (HH:mm 형식)
  @override
  @JsonKey()
  final String attendanceReminderTime;

  /// 출석 체크 알림 요일 (1-7, 월-일)
  @override
  @JsonKey()
  final int attendanceReminderDayOfWeek;

  /// 생성 시간
  @override
  final DateTime createdAt;

  /// 수정 시간
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'NotificationSettingsDto(userId: $userId, isEnabled: $isEnabled, attendanceReminderEnabled: $attendanceReminderEnabled, monthlyFeeReminderEnabled: $monthlyFeeReminderEnabled, attendanceReminderTime: $attendanceReminderTime, attendanceReminderDayOfWeek: $attendanceReminderDayOfWeek, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.isEnabled, isEnabled) ||
                other.isEnabled == isEnabled) &&
            (identical(other.attendanceReminderEnabled,
                    attendanceReminderEnabled) ||
                other.attendanceReminderEnabled == attendanceReminderEnabled) &&
            (identical(other.monthlyFeeReminderEnabled,
                    monthlyFeeReminderEnabled) ||
                other.monthlyFeeReminderEnabled == monthlyFeeReminderEnabled) &&
            (identical(other.attendanceReminderTime, attendanceReminderTime) ||
                other.attendanceReminderTime == attendanceReminderTime) &&
            (identical(other.attendanceReminderDayOfWeek,
                    attendanceReminderDayOfWeek) ||
                other.attendanceReminderDayOfWeek ==
                    attendanceReminderDayOfWeek) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      userId,
      isEnabled,
      attendanceReminderEnabled,
      monthlyFeeReminderEnabled,
      attendanceReminderTime,
      attendanceReminderDayOfWeek,
      createdAt,
      updatedAt);

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsDtoImplCopyWith<_$NotificationSettingsDtoImpl>
      get copyWith => __$$NotificationSettingsDtoImplCopyWithImpl<
          _$NotificationSettingsDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsDtoImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsDto implements NotificationSettingsDto {
  const factory _NotificationSettingsDto(
      {required final String userId,
      final bool isEnabled,
      final bool attendanceReminderEnabled,
      final bool monthlyFeeReminderEnabled,
      final String attendanceReminderTime,
      final int attendanceReminderDayOfWeek,
      required final DateTime createdAt,
      required final DateTime updatedAt}) = _$NotificationSettingsDtoImpl;

  factory _NotificationSettingsDto.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsDtoImpl.fromJson;

  /// 사용자 ID
  @override
  String get userId;

  /// 전체 알림 활성화 여부
  @override
  bool get isEnabled;

  /// 출석 체크 알림 활성화 여부
  @override
  bool get attendanceReminderEnabled;

  /// 회비 알림 활성화 여부
  @override
  bool get monthlyFeeReminderEnabled;

  /// 출석 체크 알림 시간 (HH:mm 형식)
  @override
  String get attendanceReminderTime;

  /// 출석 체크 알림 요일 (1-7, 월-일)
  @override
  int get attendanceReminderDayOfWeek;

  /// 생성 시간
  @override
  DateTime get createdAt;

  /// 수정 시간
  @override
  DateTime get updatedAt;

  /// Create a copy of NotificationSettingsDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsDtoImplCopyWith<_$NotificationSettingsDtoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
