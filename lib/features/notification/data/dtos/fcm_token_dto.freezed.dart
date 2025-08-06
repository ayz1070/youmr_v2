// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FcmTokenDto _$FcmTokenDtoFromJson(Map<String, dynamic> json) {
  return _FcmTokenDto.fromJson(json);
}

/// @nodoc
mixin _$FcmTokenDto {
  /// 사용자 ID
  String get userId => throw _privateConstructorUsedError;

  /// FCM 토큰
  String get token => throw _privateConstructorUsedError;

  /// 생성 시간
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 수정 시간
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// 디바이스 정보
  Map<String, dynamic> get deviceInfo => throw _privateConstructorUsedError;

  /// Serializes this FcmTokenDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmTokenDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenDtoCopyWith<FcmTokenDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenDtoCopyWith<$Res> {
  factory $FcmTokenDtoCopyWith(
          FcmTokenDto value, $Res Function(FcmTokenDto) then) =
      _$FcmTokenDtoCopyWithImpl<$Res, FcmTokenDto>;
  @useResult
  $Res call(
      {String userId,
      String token,
      DateTime createdAt,
      DateTime updatedAt,
      Map<String, dynamic> deviceInfo});
}

/// @nodoc
class _$FcmTokenDtoCopyWithImpl<$Res, $Val extends FcmTokenDto>
    implements $FcmTokenDtoCopyWith<$Res> {
  _$FcmTokenDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmTokenDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deviceInfo = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceInfo: null == deviceInfo
          ? _value.deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FcmTokenDtoImplCopyWith<$Res>
    implements $FcmTokenDtoCopyWith<$Res> {
  factory _$$FcmTokenDtoImplCopyWith(
          _$FcmTokenDtoImpl value, $Res Function(_$FcmTokenDtoImpl) then) =
      __$$FcmTokenDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String token,
      DateTime createdAt,
      DateTime updatedAt,
      Map<String, dynamic> deviceInfo});
}

/// @nodoc
class __$$FcmTokenDtoImplCopyWithImpl<$Res>
    extends _$FcmTokenDtoCopyWithImpl<$Res, _$FcmTokenDtoImpl>
    implements _$$FcmTokenDtoImplCopyWith<$Res> {
  __$$FcmTokenDtoImplCopyWithImpl(
      _$FcmTokenDtoImpl _value, $Res Function(_$FcmTokenDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of FcmTokenDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? token = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? deviceInfo = null,
  }) {
    return _then(_$FcmTokenDtoImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceInfo: null == deviceInfo
          ? _value._deviceInfo
          : deviceInfo // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FcmTokenDtoImpl implements _FcmTokenDto {
  const _$FcmTokenDtoImpl(
      {required this.userId,
      required this.token,
      required this.createdAt,
      required this.updatedAt,
      final Map<String, dynamic> deviceInfo = const {}})
      : _deviceInfo = deviceInfo;

  factory _$FcmTokenDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenDtoImplFromJson(json);

  /// 사용자 ID
  @override
  final String userId;

  /// FCM 토큰
  @override
  final String token;

  /// 생성 시간
  @override
  final DateTime createdAt;

  /// 수정 시간
  @override
  final DateTime updatedAt;

  /// 디바이스 정보
  final Map<String, dynamic> _deviceInfo;

  /// 디바이스 정보
  @override
  @JsonKey()
  Map<String, dynamic> get deviceInfo {
    if (_deviceInfo is EqualUnmodifiableMapView) return _deviceInfo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_deviceInfo);
  }

  @override
  String toString() {
    return 'FcmTokenDto(userId: $userId, token: $token, createdAt: $createdAt, updatedAt: $updatedAt, deviceInfo: $deviceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            const DeepCollectionEquality()
                .equals(other._deviceInfo, _deviceInfo));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, token, createdAt,
      updatedAt, const DeepCollectionEquality().hash(_deviceInfo));

  /// Create a copy of FcmTokenDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenDtoImplCopyWith<_$FcmTokenDtoImpl> get copyWith =>
      __$$FcmTokenDtoImplCopyWithImpl<_$FcmTokenDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenDtoImplToJson(
      this,
    );
  }
}

abstract class _FcmTokenDto implements FcmTokenDto {
  const factory _FcmTokenDto(
      {required final String userId,
      required final String token,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final Map<String, dynamic> deviceInfo}) = _$FcmTokenDtoImpl;

  factory _FcmTokenDto.fromJson(Map<String, dynamic> json) =
      _$FcmTokenDtoImpl.fromJson;

  /// 사용자 ID
  @override
  String get userId;

  /// FCM 토큰
  @override
  String get token;

  /// 생성 시간
  @override
  DateTime get createdAt;

  /// 수정 시간
  @override
  DateTime get updatedAt;

  /// 디바이스 정보
  @override
  Map<String, dynamic> get deviceInfo;

  /// Create a copy of FcmTokenDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenDtoImplCopyWith<_$FcmTokenDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
