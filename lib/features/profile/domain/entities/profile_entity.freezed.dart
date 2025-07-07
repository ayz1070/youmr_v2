// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProfileEntity _$ProfileEntityFromJson(Map<String, dynamic> json) {
  return _ProfileEntity.fromJson(json);
}

/// @nodoc
mixin _$ProfileEntity {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get userType => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  String? get dayOfWeek => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ProfileEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProfileEntityCopyWith<ProfileEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileEntityCopyWith<$Res> {
  factory $ProfileEntityCopyWith(
    ProfileEntity value,
    $Res Function(ProfileEntity) then,
  ) = _$ProfileEntityCopyWithImpl<$Res, ProfileEntity>;
  @useResult
  $Res call({
    String id,
    String email,
    String nickname,
    String userType,
    String profileImageUrl,
    String? dayOfWeek,
    DateTime createdAt,
  });
}

/// @nodoc
class _$ProfileEntityCopyWithImpl<$Res, $Val extends ProfileEntity>
    implements $ProfileEntityCopyWith<$Res> {
  _$ProfileEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = null,
    Object? userType = null,
    Object? profileImageUrl = null,
    Object? dayOfWeek = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            userType: null == userType
                ? _value.userType
                : userType // ignore: cast_nullable_to_non_nullable
                      as String,
            profileImageUrl: null == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            dayOfWeek: freezed == dayOfWeek
                ? _value.dayOfWeek
                : dayOfWeek // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProfileEntityImplCopyWith<$Res>
    implements $ProfileEntityCopyWith<$Res> {
  factory _$$ProfileEntityImplCopyWith(
    _$ProfileEntityImpl value,
    $Res Function(_$ProfileEntityImpl) then,
  ) = __$$ProfileEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String email,
    String nickname,
    String userType,
    String profileImageUrl,
    String? dayOfWeek,
    DateTime createdAt,
  });
}

/// @nodoc
class __$$ProfileEntityImplCopyWithImpl<$Res>
    extends _$ProfileEntityCopyWithImpl<$Res, _$ProfileEntityImpl>
    implements _$$ProfileEntityImplCopyWith<$Res> {
  __$$ProfileEntityImplCopyWithImpl(
    _$ProfileEntityImpl _value,
    $Res Function(_$ProfileEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? nickname = null,
    Object? userType = null,
    Object? profileImageUrl = null,
    Object? dayOfWeek = freezed,
    Object? createdAt = null,
  }) {
    return _then(
      _$ProfileEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        userType: null == userType
            ? _value.userType
            : userType // ignore: cast_nullable_to_non_nullable
                  as String,
        profileImageUrl: null == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        dayOfWeek: freezed == dayOfWeek
            ? _value.dayOfWeek
            : dayOfWeek // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProfileEntityImpl implements _ProfileEntity {
  const _$ProfileEntityImpl({
    required this.id,
    required this.email,
    required this.nickname,
    required this.userType,
    required this.profileImageUrl,
    this.dayOfWeek,
    required this.createdAt,
  });

  factory _$ProfileEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProfileEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String nickname;
  @override
  final String userType;
  @override
  final String profileImageUrl;
  @override
  final String? dayOfWeek;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'ProfileEntity(id: $id, email: $email, nickname: $nickname, userType: $userType, profileImageUrl: $profileImageUrl, dayOfWeek: $dayOfWeek, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProfileEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            (identical(other.dayOfWeek, dayOfWeek) ||
                other.dayOfWeek == dayOfWeek) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    email,
    nickname,
    userType,
    profileImageUrl,
    dayOfWeek,
    createdAt,
  );

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      __$$ProfileEntityImplCopyWithImpl<_$ProfileEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProfileEntityImplToJson(this);
  }
}

abstract class _ProfileEntity implements ProfileEntity {
  const factory _ProfileEntity({
    required final String id,
    required final String email,
    required final String nickname,
    required final String userType,
    required final String profileImageUrl,
    final String? dayOfWeek,
    required final DateTime createdAt,
  }) = _$ProfileEntityImpl;

  factory _ProfileEntity.fromJson(Map<String, dynamic> json) =
      _$ProfileEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get nickname;
  @override
  String get userType;
  @override
  String get profileImageUrl;
  @override
  String? get dayOfWeek;
  @override
  DateTime get createdAt;

  /// Create a copy of ProfileEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProfileEntityImplCopyWith<_$ProfileEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
