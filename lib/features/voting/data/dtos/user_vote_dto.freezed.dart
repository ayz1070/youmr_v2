// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_vote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserVoteDto _$UserVoteDtoFromJson(Map<String, dynamic> json) {
  return _UserVoteDto.fromJson(json);
}

/// @nodoc
mixin _$UserVoteDto {
  String get userId => throw _privateConstructorUsedError;
  String get voteId => throw _privateConstructorUsedError;
  DateTime get votedAt => throw _privateConstructorUsedError;

  /// Serializes this UserVoteDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserVoteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserVoteDtoCopyWith<UserVoteDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserVoteDtoCopyWith<$Res> {
  factory $UserVoteDtoCopyWith(
          UserVoteDto value, $Res Function(UserVoteDto) then) =
      _$UserVoteDtoCopyWithImpl<$Res, UserVoteDto>;
  @useResult
  $Res call({String userId, String voteId, DateTime votedAt});
}

/// @nodoc
class _$UserVoteDtoCopyWithImpl<$Res, $Val extends UserVoteDto>
    implements $UserVoteDtoCopyWith<$Res> {
  _$UserVoteDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserVoteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? voteId = null,
    Object? votedAt = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      voteId: null == voteId
          ? _value.voteId
          : voteId // ignore: cast_nullable_to_non_nullable
              as String,
      votedAt: null == votedAt
          ? _value.votedAt
          : votedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserVoteDtoImplCopyWith<$Res>
    implements $UserVoteDtoCopyWith<$Res> {
  factory _$$UserVoteDtoImplCopyWith(
          _$UserVoteDtoImpl value, $Res Function(_$UserVoteDtoImpl) then) =
      __$$UserVoteDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String voteId, DateTime votedAt});
}

/// @nodoc
class __$$UserVoteDtoImplCopyWithImpl<$Res>
    extends _$UserVoteDtoCopyWithImpl<$Res, _$UserVoteDtoImpl>
    implements _$$UserVoteDtoImplCopyWith<$Res> {
  __$$UserVoteDtoImplCopyWithImpl(
      _$UserVoteDtoImpl _value, $Res Function(_$UserVoteDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserVoteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? voteId = null,
    Object? votedAt = null,
  }) {
    return _then(_$UserVoteDtoImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      voteId: null == voteId
          ? _value.voteId
          : voteId // ignore: cast_nullable_to_non_nullable
              as String,
      votedAt: null == votedAt
          ? _value.votedAt
          : votedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserVoteDtoImpl implements _UserVoteDto {
  const _$UserVoteDtoImpl(
      {required this.userId, required this.voteId, required this.votedAt});

  factory _$UserVoteDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserVoteDtoImplFromJson(json);

  @override
  final String userId;
  @override
  final String voteId;
  @override
  final DateTime votedAt;

  @override
  String toString() {
    return 'UserVoteDto(userId: $userId, voteId: $voteId, votedAt: $votedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserVoteDtoImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.voteId, voteId) || other.voteId == voteId) &&
            (identical(other.votedAt, votedAt) || other.votedAt == votedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, voteId, votedAt);

  /// Create a copy of UserVoteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserVoteDtoImplCopyWith<_$UserVoteDtoImpl> get copyWith =>
      __$$UserVoteDtoImplCopyWithImpl<_$UserVoteDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserVoteDtoImplToJson(
      this,
    );
  }
}

abstract class _UserVoteDto implements UserVoteDto {
  const factory _UserVoteDto(
      {required final String userId,
      required final String voteId,
      required final DateTime votedAt}) = _$UserVoteDtoImpl;

  factory _UserVoteDto.fromJson(Map<String, dynamic> json) =
      _$UserVoteDtoImpl.fromJson;

  @override
  String get userId;
  @override
  String get voteId;
  @override
  DateTime get votedAt;

  /// Create a copy of UserVoteDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserVoteDtoImplCopyWith<_$UserVoteDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
