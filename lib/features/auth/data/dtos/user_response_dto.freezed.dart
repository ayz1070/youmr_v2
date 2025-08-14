// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_response_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserResponseDto _$UserResponseDtoFromJson(Map<String, dynamic> json) {
  return _UserResponseDto.fromJson(json);
}

/// @nodoc
mixin _$UserResponseDto {
  /// 유저 고유 ID
  String get uid => throw _privateConstructorUsedError;

  /// 이메일
  String get email => throw _privateConstructorUsedError;

  /// 닉네임
  String get nickname => throw _privateConstructorUsedError;

  /// 실명 (nullable)
  String? get name => throw _privateConstructorUsedError;

  /// 프로필 이미지 URL (nullable)
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// 유저 타입(관리자/일반 등, nullable)
  String? get userType => throw _privateConstructorUsedError;

  /// 요일 정보(nullable)
  String? get dayOfWeek => throw _privateConstructorUsedError;

  /// FCM 토큰(푸시용, nullable)
  String? get fcmToken => throw _privateConstructorUsedError;

  /// 생성일(nullable)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// 수정일(nullable)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// 마지막 업데이트(nullable)
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this UserResponseDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserResponseDtoCopyWith<UserResponseDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserResponseDtoCopyWith<$Res> {
  factory $UserResponseDtoCopyWith(
          UserResponseDto value, $Res Function(UserResponseDto) then) =
      _$UserResponseDtoCopyWithImpl<$Res, UserResponseDto>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String nickname,
      String? name,
      String? profileImageUrl,
      String? userType,
      String? dayOfWeek,
      String? fcmToken,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastUpdated});
}

/// @nodoc
class _$UserResponseDtoCopyWithImpl<$Res, $Val extends UserResponseDto>
    implements $UserResponseDtoCopyWith<$Res> {
  _$UserResponseDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? nickname = null,
    Object? name = freezed,
    Object? profileImageUrl = freezed,
    Object? userType = freezed,
    Object? dayOfWeek = freezed,
    Object? fcmToken = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserResponseDtoImplCopyWith<$Res>
    implements $UserResponseDtoCopyWith<$Res> {
  factory _$$UserResponseDtoImplCopyWith(_$UserResponseDtoImpl value,
          $Res Function(_$UserResponseDtoImpl) then) =
      __$$UserResponseDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String nickname,
      String? name,
      String? profileImageUrl,
      String? userType,
      String? dayOfWeek,
      String? fcmToken,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? lastUpdated});
}

/// @nodoc
class __$$UserResponseDtoImplCopyWithImpl<$Res>
    extends _$UserResponseDtoCopyWithImpl<$Res, _$UserResponseDtoImpl>
    implements _$$UserResponseDtoImplCopyWith<$Res> {
  __$$UserResponseDtoImplCopyWithImpl(
      _$UserResponseDtoImpl _value, $Res Function(_$UserResponseDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? nickname = null,
    Object? name = freezed,
    Object? profileImageUrl = freezed,
    Object? userType = freezed,
    Object? dayOfWeek = freezed,
    Object? fcmToken = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? lastUpdated = freezed,
  }) {
    return _then(_$UserResponseDtoImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      dayOfWeek: freezed == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String?,
      fcmToken: freezed == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      lastUpdated: freezed == lastUpdated
          ? _value.lastUpdated
          : lastUpdated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserResponseDtoImpl implements _UserResponseDto {
  const _$UserResponseDtoImpl(
      {required this.uid,
      required this.email,
      required this.nickname,
      this.name,
      this.profileImageUrl,
      this.userType,
      this.dayOfWeek,
      this.fcmToken,
      this.createdAt,
      this.updatedAt,
      this.lastUpdated});

  factory _$UserResponseDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserResponseDtoImplFromJson(json);

  /// 유저 고유 ID
  @override
  final String uid;

  /// 이메일
  @override
  final String email;

  /// 닉네임
  @override
  final String nickname;

  /// 실명 (nullable)
  @override
  final String? name;

  /// 프로필 이미지 URL (nullable)
  @override
  final String? profileImageUrl;

  /// 유저 타입(관리자/일반 등, nullable)
  @override
  final String? userType;

  /// 요일 정보(nullable)
  @override
  final String? dayOfWeek;

  /// FCM 토큰(푸시용, nullable)
  @override
  final String? fcmToken;

  /// 생성일(nullable)
  @override
  final DateTime? createdAt;

  /// 수정일(nullable)
  @override
  final DateTime? updatedAt;

  /// 마지막 업데이트(nullable)
  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'UserResponseDto(uid: $uid, email: $email, nickname: $nickname, name: $name, profileImageUrl: $profileImageUrl, userType: $userType, dayOfWeek: $dayOfWeek, fcmToken: $fcmToken, createdAt: $createdAt, updatedAt: $updatedAt, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserResponseDtoImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.fcmToken, fcmToken) ||
                other.fcmToken == fcmToken) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      email,
      nickname,
      name,
      profileImageUrl,
      userType,
      dayOfWeek,
      fcmToken,
      createdAt,
      updatedAt,
      lastUpdated);

  /// Create a copy of UserResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserResponseDtoImplCopyWith<_$UserResponseDtoImpl> get copyWith =>
      __$$UserResponseDtoImplCopyWithImpl<_$UserResponseDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserResponseDtoImplToJson(
      this,
    );
  }
}

abstract class _UserResponseDto implements UserResponseDto {
  const factory _UserResponseDto(
      {required final String uid,
      required final String email,
      required final String nickname,
      final String? name,
      final String? profileImageUrl,
      final String? userType,
      final String? dayOfWeek,
      final String? fcmToken,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? lastUpdated}) = _$UserResponseDtoImpl;

  factory _UserResponseDto.fromJson(Map<String, dynamic> json) =
      _$UserResponseDtoImpl.fromJson;

  /// 유저 고유 ID
  @override
  String get uid;

  /// 이메일
  @override
  String get email;

  /// 닉네임
  @override
  String get nickname;

  /// 실명 (nullable)
  @override
  String? get name;

  /// 프로필 이미지 URL (nullable)
  @override
  String? get profileImageUrl;

  /// 유저 타입(관리자/일반 등, nullable)
  @override
  String? get userType;

  /// 요일 정보(nullable)
  @override
  String? get dayOfWeek;

  /// FCM 토큰(푸시용, nullable)
  @override
  String? get fcmToken;

  /// 생성일(nullable)
  @override
  DateTime? get createdAt;

  /// 수정일(nullable)
  @override
  DateTime? get updatedAt;

  /// 마지막 업데이트(nullable)
  @override
  DateTime? get lastUpdated;

  /// Create a copy of UserResponseDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserResponseDtoImplCopyWith<_$UserResponseDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
