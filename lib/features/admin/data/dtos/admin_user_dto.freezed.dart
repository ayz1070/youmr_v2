// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_user_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminUserDto _$AdminUserDtoFromJson(Map<String, dynamic> json) {
  return _AdminUserDto.fromJson(json);
}

/// @nodoc
mixin _$AdminUserDto {
  /// 회원 UID
  String? get uid => throw _privateConstructorUsedError;

  /// 닉네임
  String? get nickname => throw _privateConstructorUsedError;

  /// 이름
  String? get name => throw _privateConstructorUsedError;

  /// 이메일
  String? get email => throw _privateConstructorUsedError;

  /// 회원 유형(admin, user 등)
  String? get userType => throw _privateConstructorUsedError;

  /// 프로필 이미지 URL
  String? get profileImageUrl => throw _privateConstructorUsedError;

  /// 가입일(생성일)
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this AdminUserDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminUserDtoCopyWith<AdminUserDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminUserDtoCopyWith<$Res> {
  factory $AdminUserDtoCopyWith(
          AdminUserDto value, $Res Function(AdminUserDto) then) =
      _$AdminUserDtoCopyWithImpl<$Res, AdminUserDto>;
  @useResult
  $Res call(
      {String? uid,
      String? nickname,
      String? name,
      String? email,
      String? userType,
      String? profileImageUrl,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class _$AdminUserDtoCopyWithImpl<$Res, $Val extends AdminUserDto>
    implements $AdminUserDtoCopyWith<$Res> {
  _$AdminUserDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? nickname = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? userType = freezed,
    Object? profileImageUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminUserDtoImplCopyWith<$Res>
    implements $AdminUserDtoCopyWith<$Res> {
  factory _$$AdminUserDtoImplCopyWith(
          _$AdminUserDtoImpl value, $Res Function(_$AdminUserDtoImpl) then) =
      __$$AdminUserDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? uid,
      String? nickname,
      String? name,
      String? email,
      String? userType,
      String? profileImageUrl,
      @TimestampConverter() DateTime? createdAt});
}

/// @nodoc
class __$$AdminUserDtoImplCopyWithImpl<$Res>
    extends _$AdminUserDtoCopyWithImpl<$Res, _$AdminUserDtoImpl>
    implements _$$AdminUserDtoImplCopyWith<$Res> {
  __$$AdminUserDtoImplCopyWithImpl(
      _$AdminUserDtoImpl _value, $Res Function(_$AdminUserDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminUserDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = freezed,
    Object? nickname = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? userType = freezed,
    Object? profileImageUrl = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$AdminUserDtoImpl(
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      nickname: freezed == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminUserDtoImpl implements _AdminUserDto {
  const _$AdminUserDtoImpl(
      {this.uid,
      this.nickname,
      this.name,
      this.email,
      this.userType,
      this.profileImageUrl,
      @TimestampConverter() this.createdAt});

  factory _$AdminUserDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminUserDtoImplFromJson(json);

  /// 회원 UID
  @override
  final String? uid;

  /// 닉네임
  @override
  final String? nickname;

  /// 이름
  @override
  final String? name;

  /// 이메일
  @override
  final String? email;

  /// 회원 유형(admin, user 등)
  @override
  final String? userType;

  /// 프로필 이미지 URL
  @override
  final String? profileImageUrl;

  /// 가입일(생성일)
  @override
  @TimestampConverter()
  final DateTime? createdAt;

  @override
  String toString() {
    return 'AdminUserDto(uid: $uid, nickname: $nickname, name: $name, email: $email, userType: $userType, profileImageUrl: $profileImageUrl, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminUserDtoImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, nickname, name, email,
      userType, profileImageUrl, createdAt);

  /// Create a copy of AdminUserDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminUserDtoImplCopyWith<_$AdminUserDtoImpl> get copyWith =>
      __$$AdminUserDtoImplCopyWithImpl<_$AdminUserDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminUserDtoImplToJson(
      this,
    );
  }
}

abstract class _AdminUserDto implements AdminUserDto {
  const factory _AdminUserDto(
      {final String? uid,
      final String? nickname,
      final String? name,
      final String? email,
      final String? userType,
      final String? profileImageUrl,
      @TimestampConverter() final DateTime? createdAt}) = _$AdminUserDtoImpl;

  factory _AdminUserDto.fromJson(Map<String, dynamic> json) =
      _$AdminUserDtoImpl.fromJson;

  /// 회원 UID
  @override
  String? get uid;

  /// 닉네임
  @override
  String? get nickname;

  /// 이름
  @override
  String? get name;

  /// 이메일
  @override
  String? get email;

  /// 회원 유형(admin, user 등)
  @override
  String? get userType;

  /// 프로필 이미지 URL
  @override
  String? get profileImageUrl;

  /// 가입일(생성일)
  @override
  @TimestampConverter()
  DateTime? get createdAt;

  /// Create a copy of AdminUserDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminUserDtoImplCopyWith<_$AdminUserDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
