// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendee.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Attendee _$AttendeeFromJson(Map<String, dynamic> json) {
  return _Attendee.fromJson(json);
}

/// @nodoc
mixin _$Attendee {
  String get userId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;

  /// Serializes this Attendee to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Attendee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendeeCopyWith<Attendee> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendeeCopyWith<$Res> {
  factory $AttendeeCopyWith(Attendee value, $Res Function(Attendee) then) =
      _$AttendeeCopyWithImpl<$Res, Attendee>;
  @useResult
  $Res call({String userId, String nickname, String profileImageUrl});
}

/// @nodoc
class _$AttendeeCopyWithImpl<$Res, $Val extends Attendee>
    implements $AttendeeCopyWith<$Res> {
  _$AttendeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Attendee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? nickname = null,
    Object? profileImageUrl = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AttendeeImplCopyWith<$Res>
    implements $AttendeeCopyWith<$Res> {
  factory _$$AttendeeImplCopyWith(
          _$AttendeeImpl value, $Res Function(_$AttendeeImpl) then) =
      __$$AttendeeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String nickname, String profileImageUrl});
}

/// @nodoc
class __$$AttendeeImplCopyWithImpl<$Res>
    extends _$AttendeeCopyWithImpl<$Res, _$AttendeeImpl>
    implements _$$AttendeeImplCopyWith<$Res> {
  __$$AttendeeImplCopyWithImpl(
      _$AttendeeImpl _value, $Res Function(_$AttendeeImpl) _then)
      : super(_value, _then);

  /// Create a copy of Attendee
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? nickname = null,
    Object? profileImageUrl = null,
  }) {
    return _then(_$AttendeeImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      profileImageUrl: null == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendeeImpl implements _Attendee {
  const _$AttendeeImpl(
      {required this.userId,
      required this.nickname,
      required this.profileImageUrl});

  factory _$AttendeeImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendeeImplFromJson(json);

  @override
  final String userId;
  @override
  final String nickname;
  @override
  final String profileImageUrl;

  @override
  String toString() {
    return 'Attendee(userId: $userId, nickname: $nickname, profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendeeImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, userId, nickname, profileImageUrl);

  /// Create a copy of Attendee
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendeeImplCopyWith<_$AttendeeImpl> get copyWith =>
      __$$AttendeeImplCopyWithImpl<_$AttendeeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendeeImplToJson(
      this,
    );
  }
}

abstract class _Attendee implements Attendee {
  const factory _Attendee(
      {required final String userId,
      required final String nickname,
      required final String profileImageUrl}) = _$AttendeeImpl;

  factory _Attendee.fromJson(Map<String, dynamic> json) =
      _$AttendeeImpl.fromJson;

  @override
  String get userId;
  @override
  String get nickname;
  @override
  String get profileImageUrl;

  /// Create a copy of Attendee
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendeeImplCopyWith<_$AttendeeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
