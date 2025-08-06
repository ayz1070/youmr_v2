// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fcm_token.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FcmToken _$FcmTokenFromJson(Map<String, dynamic> json) {
  return _FcmToken.fromJson(json);
}

/// @nodoc
mixin _$FcmToken {
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

  /// Serializes this FcmToken to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FcmToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FcmTokenCopyWith<FcmToken> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FcmTokenCopyWith<$Res> {
  factory $FcmTokenCopyWith(FcmToken value, $Res Function(FcmToken) then) =
      _$FcmTokenCopyWithImpl<$Res, FcmToken>;
  @useResult
  $Res call(
      {String userId,
      String token,
      DateTime createdAt,
      DateTime updatedAt,
      Map<String, dynamic> deviceInfo});
}

/// @nodoc
class _$FcmTokenCopyWithImpl<$Res, $Val extends FcmToken>
    implements $FcmTokenCopyWith<$Res> {
  _$FcmTokenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FcmToken
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
abstract class _$$FcmTokenImplCopyWith<$Res>
    implements $FcmTokenCopyWith<$Res> {
  factory _$$FcmTokenImplCopyWith(
          _$FcmTokenImpl value, $Res Function(_$FcmTokenImpl) then) =
      __$$FcmTokenImplCopyWithImpl<$Res>;
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
class __$$FcmTokenImplCopyWithImpl<$Res>
    extends _$FcmTokenCopyWithImpl<$Res, _$FcmTokenImpl>
    implements _$$FcmTokenImplCopyWith<$Res> {
  __$$FcmTokenImplCopyWithImpl(
      _$FcmTokenImpl _value, $Res Function(_$FcmTokenImpl) _then)
      : super(_value, _then);

  /// Create a copy of FcmToken
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
    return _then(_$FcmTokenImpl(
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
class _$FcmTokenImpl implements _FcmToken {
  const _$FcmTokenImpl(
      {required this.userId,
      required this.token,
      required this.createdAt,
      required this.updatedAt,
      final Map<String, dynamic> deviceInfo = const {}})
      : _deviceInfo = deviceInfo;

  factory _$FcmTokenImpl.fromJson(Map<String, dynamic> json) =>
      _$$FcmTokenImplFromJson(json);

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
    return 'FcmToken(userId: $userId, token: $token, createdAt: $createdAt, updatedAt: $updatedAt, deviceInfo: $deviceInfo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FcmTokenImpl &&
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

  /// Create a copy of FcmToken
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FcmTokenImplCopyWith<_$FcmTokenImpl> get copyWith =>
      __$$FcmTokenImplCopyWithImpl<_$FcmTokenImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FcmTokenImplToJson(
      this,
    );
  }
}

abstract class _FcmToken implements FcmToken {
  const factory _FcmToken(
      {required final String userId,
      required final String token,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final Map<String, dynamic> deviceInfo}) = _$FcmTokenImpl;

  factory _FcmToken.fromJson(Map<String, dynamic> json) =
      _$FcmTokenImpl.fromJson;

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

  /// Create a copy of FcmToken
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FcmTokenImplCopyWith<_$FcmTokenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
