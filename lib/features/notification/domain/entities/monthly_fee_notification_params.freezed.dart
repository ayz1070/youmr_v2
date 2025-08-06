// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'monthly_fee_notification_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MonthlyFeeNotificationParams {
  /// 알림 제목
  String get title => throw _privateConstructorUsedError;

  /// 알림 내용
  String get body => throw _privateConstructorUsedError;

  /// 대상 조건: 출석 요일 (null이면 모든 요일)
  int? get dayOfWeek => throw _privateConstructorUsedError;

  /// 대상 조건: 사용자 타입
  String get userType => throw _privateConstructorUsedError;

  /// 회비 금액
  int get feeAmount => throw _privateConstructorUsedError;

  /// 납부 기한
  DateTime get dueDate => throw _privateConstructorUsedError;

  /// 추가 데이터
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyFeeNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyFeeNotificationParamsCopyWith<MonthlyFeeNotificationParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyFeeNotificationParamsCopyWith<$Res> {
  factory $MonthlyFeeNotificationParamsCopyWith(
          MonthlyFeeNotificationParams value,
          $Res Function(MonthlyFeeNotificationParams) then) =
      _$MonthlyFeeNotificationParamsCopyWithImpl<$Res,
          MonthlyFeeNotificationParams>;
  @useResult
  $Res call(
      {String title,
      String body,
      int? dayOfWeek,
      String userType,
      int feeAmount,
      DateTime dueDate,
      Map<String, dynamic> data});
}

/// @nodoc
class _$MonthlyFeeNotificationParamsCopyWithImpl<$Res,
        $Val extends MonthlyFeeNotificationParams>
    implements $MonthlyFeeNotificationParamsCopyWith<$Res> {
  _$MonthlyFeeNotificationParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyFeeNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? dayOfWeek = freezed,
    Object? userType = null,
    Object? feeAmount = null,
    Object? dueDate = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      feeAmount: null == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyFeeNotificationParamsImplCopyWith<$Res>
    implements $MonthlyFeeNotificationParamsCopyWith<$Res> {
  factory _$$MonthlyFeeNotificationParamsImplCopyWith(
          _$MonthlyFeeNotificationParamsImpl value,
          $Res Function(_$MonthlyFeeNotificationParamsImpl) then) =
      __$$MonthlyFeeNotificationParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String body,
      int? dayOfWeek,
      String userType,
      int feeAmount,
      DateTime dueDate,
      Map<String, dynamic> data});
}

/// @nodoc
class __$$MonthlyFeeNotificationParamsImplCopyWithImpl<$Res>
    extends _$MonthlyFeeNotificationParamsCopyWithImpl<$Res,
        _$MonthlyFeeNotificationParamsImpl>
    implements _$$MonthlyFeeNotificationParamsImplCopyWith<$Res> {
  __$$MonthlyFeeNotificationParamsImplCopyWithImpl(
      _$MonthlyFeeNotificationParamsImpl _value,
      $Res Function(_$MonthlyFeeNotificationParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyFeeNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? dayOfWeek = freezed,
    Object? userType = null,
    Object? feeAmount = null,
    Object? dueDate = null,
    Object? data = null,
  }) {
    return _then(_$MonthlyFeeNotificationParamsImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as int?,
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      feeAmount: null == feeAmount
          ? _value.feeAmount
          : feeAmount // ignore: cast_nullable_to_non_nullable
              as int,
      dueDate: null == dueDate
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$MonthlyFeeNotificationParamsImpl
    implements _MonthlyFeeNotificationParams {
  const _$MonthlyFeeNotificationParamsImpl(
      {this.title = '회비 납부 안내',
      this.body = '이번 달 회비를 납부해주세요.',
      this.dayOfWeek,
      this.userType = 'offline_member',
      this.feeAmount = 50000,
      required this.dueDate,
      final Map<String, dynamic> data = const {}})
      : _data = data;

  /// 알림 제목
  @override
  @JsonKey()
  final String title;

  /// 알림 내용
  @override
  @JsonKey()
  final String body;

  /// 대상 조건: 출석 요일 (null이면 모든 요일)
  @override
  final int? dayOfWeek;

  /// 대상 조건: 사용자 타입
  @override
  @JsonKey()
  final String userType;

  /// 회비 금액
  @override
  @JsonKey()
  final int feeAmount;

  /// 납부 기한
  @override
  final DateTime dueDate;

  /// 추가 데이터
  final Map<String, dynamic> _data;

  /// 추가 데이터
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'MonthlyFeeNotificationParams(title: $title, body: $body, dayOfWeek: $dayOfWeek, userType: $userType, feeAmount: $feeAmount, dueDate: $dueDate, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyFeeNotificationParamsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.feeAmount, feeAmount) ||
                other.feeAmount == feeAmount) &&
            (identical(other.dueDate, dueDate) || other.dueDate == dueDate) &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, body, dayOfWeek, userType,
      feeAmount, dueDate, const DeepCollectionEquality().hash(_data));

  /// Create a copy of MonthlyFeeNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyFeeNotificationParamsImplCopyWith<
          _$MonthlyFeeNotificationParamsImpl>
      get copyWith => __$$MonthlyFeeNotificationParamsImplCopyWithImpl<
          _$MonthlyFeeNotificationParamsImpl>(this, _$identity);
}

abstract class _MonthlyFeeNotificationParams
    implements MonthlyFeeNotificationParams {
  const factory _MonthlyFeeNotificationParams(
      {final String title,
      final String body,
      final int? dayOfWeek,
      final String userType,
      final int feeAmount,
      required final DateTime dueDate,
      final Map<String, dynamic> data}) = _$MonthlyFeeNotificationParamsImpl;

  /// 알림 제목
  @override
  String get title;

  /// 알림 내용
  @override
  String get body;

  /// 대상 조건: 출석 요일 (null이면 모든 요일)
  @override
  int? get dayOfWeek;

  /// 대상 조건: 사용자 타입
  @override
  String get userType;

  /// 회비 금액
  @override
  int get feeAmount;

  /// 납부 기한
  @override
  DateTime get dueDate;

  /// 추가 데이터
  @override
  Map<String, dynamic> get data;

  /// Create a copy of MonthlyFeeNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyFeeNotificationParamsImplCopyWith<
          _$MonthlyFeeNotificationParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
