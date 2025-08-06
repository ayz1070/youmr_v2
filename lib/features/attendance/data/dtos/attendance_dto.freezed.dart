// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AttendanceDto _$AttendanceDtoFromJson(Map<String, dynamic> json) {
  return _AttendanceDto.fromJson(json);
}

/// @nodoc
mixin _$AttendanceDto {
  /// 주차 키
  String get weekKey => throw _privateConstructorUsedError;

  /// 유저 고유 ID
  String get userId => throw _privateConstructorUsedError;

  /// 선택한 요일 리스트
  List<String> get selectedDays => throw _privateConstructorUsedError;

  /// 실명
  String get name => throw _privateConstructorUsedError;

  /// 프로필 이미지 URL
  String get profileImageUrl => throw _privateConstructorUsedError;

  /// 마지막 업데이트 시각
  @JsonKey(name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this AttendanceDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceDtoCopyWith<AttendanceDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceDtoCopyWith<$Res> {
  factory $AttendanceDtoCopyWith(
          AttendanceDto value, $Res Function(AttendanceDto) then) =
      _$AttendanceDtoCopyWithImpl<$Res, AttendanceDto>;
  @useResult
  $Res call(
      {String weekKey,
      String userId,
      List<String> selectedDays,
      String name,
      String profileImageUrl,
      @JsonKey(
          name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
      DateTime? lastUpdated});
}

/// @nodoc
class _$AttendanceDtoCopyWithImpl<$Res, $Val extends AttendanceDto>
    implements $AttendanceDtoCopyWith<$Res> {
  _$AttendanceDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekKey = null,
    Object? userId = null,
    Object? selectedDays = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      weekKey: null == weekKey
          ? _value.weekKey
          : weekKey // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDays: null == selectedDays
          ? _value.selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendanceDtoImplCopyWith<$Res>
    implements $AttendanceDtoCopyWith<$Res> {
  factory _$$AttendanceDtoImplCopyWith(
          _$AttendanceDtoImpl value, $Res Function(_$AttendanceDtoImpl) then) =
      __$$AttendanceDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String weekKey,
      String userId,
      List<String> selectedDays,
      String name,
      String profileImageUrl,
      @JsonKey(
          name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
      DateTime? lastUpdated});
}

/// @nodoc
class __$$AttendanceDtoImplCopyWithImpl<$Res>
    extends _$AttendanceDtoCopyWithImpl<$Res, _$AttendanceDtoImpl>
    implements _$$AttendanceDtoImplCopyWith<$Res> {
  __$$AttendanceDtoImplCopyWithImpl(
      _$AttendanceDtoImpl _value, $Res Function(_$AttendanceDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AttendanceDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekKey = null,
    Object? userId = null,
    Object? selectedDays = null,
    Object? name = null,
    Object? profileImageUrl = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$AttendanceDtoImpl(
      weekKey: null == weekKey
          ? _value.weekKey
          : weekKey // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      selectedDays: null == selectedDays
          ? _value._selectedDays
          : selectedDays // ignore: cast_nullable_to_non_nullable
              as List<String>,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceDtoImpl implements _AttendanceDto {
  const _$AttendanceDtoImpl(
      {required this.weekKey,
      required this.userId,
      required final List<String> selectedDays,
      required this.name,
      required this.profileImageUrl,
      @JsonKey(
          name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
      this.lastUpdated})
      : _selectedDays = selectedDays;

  factory _$AttendanceDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceDtoImplFromJson(json);

  /// 주차 키
  @override
  final String weekKey;

  /// 유저 고유 ID
  @override
  final String userId;

  /// 선택한 요일 리스트
  final List<String> _selectedDays;

  /// 선택한 요일 리스트
  @override
  List<String> get selectedDays {
    if (_selectedDays is EqualUnmodifiableListView) return _selectedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedDays);
  }

  /// 실명
  @override
  final String name;

  /// 프로필 이미지 URL
  @override
  final String profileImageUrl;

  /// 마지막 업데이트 시각
  @override
  @JsonKey(name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'AttendanceDto(weekKey: $weekKey, userId: $userId, selectedDays: $selectedDays, name: $name, profileImageUrl: $profileImageUrl, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceDtoImpl &&
            (identical(other.weekKey, weekKey) || other.weekKey == weekKey) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality()
                .equals(other._selectedDays, _selectedDays) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      weekKey,
      userId,
      const DeepCollectionEquality().hash(_selectedDays),
      name,
      profileImageUrl,
      lastUpdated);

  /// Create a copy of AttendanceDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceDtoImplCopyWith<_$AttendanceDtoImpl> get copyWith =>
      __$$AttendanceDtoImplCopyWithImpl<_$AttendanceDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceDtoImplToJson(
      this,
    );
  }
}

abstract class _AttendanceDto implements AttendanceDto {
  const factory _AttendanceDto(
      {required final String weekKey,
      required final String userId,
      required final List<String> selectedDays,
      required final String name,
      required final String profileImageUrl,
      @JsonKey(
          name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
      final DateTime? lastUpdated}) = _$AttendanceDtoImpl;

  factory _AttendanceDto.fromJson(Map<String, dynamic> json) =
      _$AttendanceDtoImpl.fromJson;

  /// 주차 키
  @override
  String get weekKey;

  /// 유저 고유 ID
  @override
  String get userId;

  /// 선택한 요일 리스트
  @override
  List<String> get selectedDays;

  /// 실명
  @override
  String get name;

  /// 프로필 이미지 URL
  @override
  String get profileImageUrl;

  /// 마지막 업데이트 시각
  @override
  @JsonKey(name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
  DateTime? get lastUpdated;

  /// Create a copy of AttendanceDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceDtoImplCopyWith<_$AttendanceDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
