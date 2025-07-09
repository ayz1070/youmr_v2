// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vote_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoteDto _$VoteDtoFromJson(Map<String, dynamic> json) {
  return _VoteDto.fromJson(json);
}

/// @nodoc
mixin _$VoteDto {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get artist => throw _privateConstructorUsedError;
  String? get youtubeUrl => throw _privateConstructorUsedError;
  int get voteCount => throw _privateConstructorUsedError;
  @TimestampOrDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;

  /// Serializes this VoteDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoteDtoCopyWith<VoteDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoteDtoCopyWith<$Res> {
  factory $VoteDtoCopyWith(VoteDto value, $Res Function(VoteDto) then) =
      _$VoteDtoCopyWithImpl<$Res, VoteDto>;
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String? youtubeUrl,
      int voteCount,
      @TimestampOrDateTimeConverter() DateTime createdAt,
      String createdBy});
}

/// @nodoc
class _$VoteDtoCopyWithImpl<$Res, $Val extends VoteDto>
    implements $VoteDtoCopyWith<$Res> {
  _$VoteDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? youtubeUrl = freezed,
    Object? voteCount = null,
    Object? createdAt = null,
    Object? createdBy = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeUrl: freezed == youtubeUrl
          ? _value.youtubeUrl
          : youtubeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoteDtoImplCopyWith<$Res> implements $VoteDtoCopyWith<$Res> {
  factory _$$VoteDtoImplCopyWith(
          _$VoteDtoImpl value, $Res Function(_$VoteDtoImpl) then) =
      __$$VoteDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String artist,
      String? youtubeUrl,
      int voteCount,
      @TimestampOrDateTimeConverter() DateTime createdAt,
      String createdBy});
}

/// @nodoc
class __$$VoteDtoImplCopyWithImpl<$Res>
    extends _$VoteDtoCopyWithImpl<$Res, _$VoteDtoImpl>
    implements _$$VoteDtoImplCopyWith<$Res> {
  __$$VoteDtoImplCopyWithImpl(
      _$VoteDtoImpl _value, $Res Function(_$VoteDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? artist = null,
    Object? youtubeUrl = freezed,
    Object? voteCount = null,
    Object? createdAt = null,
    Object? createdBy = null,
  }) {
    return _then(_$VoteDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      artist: null == artist
          ? _value.artist
          : artist // ignore: cast_nullable_to_non_nullable
              as String,
      youtubeUrl: freezed == youtubeUrl
          ? _value.youtubeUrl
          : youtubeUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      voteCount: null == voteCount
          ? _value.voteCount
          : voteCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdBy: null == createdBy
          ? _value.createdBy
          : createdBy // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoteDtoImpl implements _VoteDto {
  const _$VoteDtoImpl(
      {required this.id,
      required this.title,
      required this.artist,
      this.youtubeUrl,
      required this.voteCount,
      @TimestampOrDateTimeConverter() required this.createdAt,
      required this.createdBy});

  factory _$VoteDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteDtoImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String artist;
  @override
  final String? youtubeUrl;
  @override
  final int voteCount;
  @override
  @TimestampOrDateTimeConverter()
  final DateTime createdAt;
  @override
  final String createdBy;

  @override
  String toString() {
    return 'VoteDto(id: $id, title: $title, artist: $artist, youtubeUrl: $youtubeUrl, voteCount: $voteCount, createdAt: $createdAt, createdBy: $createdBy)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoteDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.artist, artist) || other.artist == artist) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.voteCount, voteCount) ||
                other.voteCount == voteCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, artist, youtubeUrl,
      voteCount, createdAt, createdBy);

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoteDtoImplCopyWith<_$VoteDtoImpl> get copyWith =>
      __$$VoteDtoImplCopyWithImpl<_$VoteDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoteDtoImplToJson(
      this,
    );
  }
}

abstract class _VoteDto implements VoteDto {
  const factory _VoteDto(
      {required final String id,
      required final String title,
      required final String artist,
      final String? youtubeUrl,
      required final int voteCount,
      @TimestampOrDateTimeConverter() required final DateTime createdAt,
      required final String createdBy}) = _$VoteDtoImpl;

  factory _VoteDto.fromJson(Map<String, dynamic> json) = _$VoteDtoImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get artist;
  @override
  String? get youtubeUrl;
  @override
  int get voteCount;
  @override
  @TimestampOrDateTimeConverter()
  DateTime get createdAt;
  @override
  String get createdBy;

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteDtoImplCopyWith<_$VoteDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
