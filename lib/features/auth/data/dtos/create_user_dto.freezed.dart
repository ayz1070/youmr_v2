// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CreateUserDto _$CreateUserDtoFromJson(Map<String, dynamic> json) {
  return _CreateUserDto.fromJson(json);
}

/// @nodoc
mixin _$CreateUserDto {
  /// 유저 고유 ID (Firebase Auth에서 생성)
  String get uid => throw _privateConstructorUsedError;

  /// 이메일 (Firebase Auth에서 생성)
  String get email => throw _privateConstructorUsedError;

  /// 닉네임 (Firebase Auth displayName 또는 기본값)
  String get nickname => throw _privateConstructorUsedError;

  /// 실명 (nullable, 사용자가 나중에 설정)
  String? get name => throw _privateConstructorUsedError;

  /// 프로필 이미지 URL (Firebase Auth photoURL 또는 기본값)
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// 유저 타입 (기본값: 빈 문자열)
  String get userType => throw _privateConstructorUsedError;

  /// 요일 정보 (기본값: 빈 문자열)
  String get dayOfWeek => throw _privateConstructorUsedError;

  /// FCM 토큰 (기본값: 빈 문자열, 나중에 설정)
  String get fcmToken => throw _privateConstructorUsedError;

  /// Serializes this CreateUserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CreateUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreateUserDtoCopyWith<CreateUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreateUserDtoCopyWith<$Res> {
  factory $CreateUserDtoCopyWith(
          CreateUserDto value, $Res Function(CreateUserDto) then) =
      _$CreateUserDtoCopyWithImpl<$Res, CreateUserDto>;
  @useResult
  $Res call(
      {String uid,
      String email,
      String nickname,
      String? name,
      String? profileImageUrl,
      String userType,
      String dayOfWeek,
      String fcmToken});
}

/// @nodoc
class _$CreateUserDtoCopyWithImpl<$Res, $Val extends CreateUserDto>
    implements $CreateUserDtoCopyWith<$Res> {
  _$CreateUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreateUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? nickname = null,
    Object? name = freezed,
    Object? profileImageUrl = freezed,
    Object? userType = null,
    Object? dayOfWeek = null,
    Object? fcmToken = null,
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
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreateUserDtoImplCopyWith<$Res>
    implements $CreateUserDtoCopyWith<$Res> {
  factory _$$CreateUserDtoImplCopyWith(
          _$CreateUserDtoImpl value, $Res Function(_$CreateUserDtoImpl) then) =
      __$$CreateUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String email,
      String nickname,
      String? name,
      String? profileImageUrl,
      String userType,
      String dayOfWeek,
      String fcmToken});
}

/// @nodoc
class __$$CreateUserDtoImplCopyWithImpl<$Res>
    extends _$CreateUserDtoCopyWithImpl<$Res, _$CreateUserDtoImpl>
    implements _$$CreateUserDtoImplCopyWith<$Res> {
  __$$CreateUserDtoImplCopyWithImpl(
      _$CreateUserDtoImpl _value, $Res Function(_$CreateUserDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreateUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? email = null,
    Object? nickname = null,
    Object? name = freezed,
    Object? profileImageUrl = freezed,
    Object? userType = null,
    Object? dayOfWeek = null,
    Object? fcmToken = null,
  }) {
    return _then(_$CreateUserDtoImpl(
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
      userType: null == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String,
      dayOfWeek: null == dayOfWeek
          ? _value.dayOfWeek
          : dayOfWeek // ignore: cast_nullable_to_non_nullable
              as String,
      fcmToken: null == fcmToken
          ? _value.fcmToken
          : fcmToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CreateUserDtoImpl implements _CreateUserDto {
  const _$CreateUserDtoImpl(
      {required this.uid,
      required this.email,
      required this.nickname,
      this.name,
      this.profileImageUrl,
      this.userType = '',
      this.dayOfWeek = '',
      this.fcmToken = ''});

  factory _$CreateUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CreateUserDtoImplFromJson(json);

  /// 유저 고유 ID (Firebase Auth에서 생성)
  @override
  final String uid;

  /// 이메일 (Firebase Auth에서 생성)
  @override
  final String email;

  /// 닉네임 (Firebase Auth displayName 또는 기본값)
  @override
  final String nickname;

  /// 실명 (nullable, 사용자가 나중에 설정)
  @override
  final String? name;

  /// 프로필 이미지 URL (Firebase Auth photoURL 또는 기본값)
  @override
  final String? profileImageUrl;

  /// 유저 타입 (기본값: 빈 문자열)
  @override
  @JsonKey()
  final String userType;

  /// 요일 정보 (기본값: 빈 문자열)
  @override
  @JsonKey()
  final String dayOfWeek;

  /// FCM 토큰 (기본값: 빈 문자열, 나중에 설정)
  @override
  @JsonKey()
  final String fcmToken;

  @override
  String toString() {
    return 'CreateUserDto(uid: $uid, email: $email, nickname: $nickname, name: $name, profileImageUrl: $profileImageUrl, userType: $userType, dayOfWeek: $dayOfWeek, fcmToken: $fcmToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreateUserDtoImpl &&
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
                other.fcmToken == fcmToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, email, nickname, name,
      profileImageUrl, userType, dayOfWeek, fcmToken);

  /// Create a copy of CreateUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreateUserDtoImplCopyWith<_$CreateUserDtoImpl> get copyWith =>
      __$$CreateUserDtoImplCopyWithImpl<_$CreateUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CreateUserDtoImplToJson(
      this,
    );
  }
}

abstract class _CreateUserDto implements CreateUserDto {
  const factory _CreateUserDto(
      {required final String uid,
      required final String email,
      required final String nickname,
      final String? name,
      final String? profileImageUrl,
      final String userType,
      final String dayOfWeek,
      final String fcmToken}) = _$CreateUserDtoImpl;

  factory _CreateUserDto.fromJson(Map<String, dynamic> json) =
      _$CreateUserDtoImpl.fromJson;

  /// 유저 고유 ID (Firebase Auth에서 생성)
  @override
  String get uid;

  /// 이메일 (Firebase Auth에서 생성)
  @override
  String get email;

  /// 닉네임 (Firebase Auth displayName 또는 기본값)
  @override
  String get nickname;

  /// 실명 (nullable, 사용자가 나중에 설정)
  @override
  String? get name;

  /// 프로필 이미지 URL (Firebase Auth photoURL 또는 기본값)
  @override
  String? get profileImageUrl;

  /// 유저 타입 (기본값: 빈 문자열)
  @override
  String get userType;

  /// 요일 정보 (기본값: 빈 문자열)
  @override
  String get dayOfWeek;

  /// FCM 토큰 (기본값: 빈 문자열, 나중에 설정)
  @override
  String get fcmToken;

  /// Create a copy of CreateUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreateUserDtoImplCopyWith<_$CreateUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
