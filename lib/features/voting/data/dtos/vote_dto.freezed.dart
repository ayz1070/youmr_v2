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
  /// 곡 문서 ID
  String get id => throw _privateConstructorUsedError;

  /// 곡 제목
  String get title => throw _privateConstructorUsedError;

  /// 아티스트
  String get artist => throw _privateConstructorUsedError;

  /// 유튜브 URL
  String? get youtubeUrl => throw _privateConstructorUsedError;

  /// 득표수
  int get voteCount => throw _privateConstructorUsedError;

  /// 생성일
  @TimestampOrDateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 등록자 ID
  String get createdBy => throw _privateConstructorUsedError;

  /// 작성자 닉네임
  String? get authorNickname => throw _privateConstructorUsedError;

  /// 작성자 프로필 이미지 URL
  String? get authorProfileUrl => throw _privateConstructorUsedError;

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
      String createdBy,
      String? authorNickname,
      String? authorProfileUrl});
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
    Object? authorNickname = freezed,
    Object? authorProfileUrl = freezed,
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
      authorNickname: freezed == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
      String createdBy,
      String? authorNickname,
      String? authorProfileUrl});
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
    Object? authorNickname = freezed,
    Object? authorProfileUrl = freezed,
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
      authorNickname: freezed == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String?,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
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
      required this.createdBy,
      this.authorNickname,
      this.authorProfileUrl});

  factory _$VoteDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoteDtoImplFromJson(json);

  /// 곡 문서 ID
  @override
  final String id;

  /// 곡 제목
  @override
  final String title;

  /// 아티스트
  @override
  final String artist;

  /// 유튜브 URL
  @override
  final String? youtubeUrl;

  /// 득표수
  @override
  final int voteCount;

  /// 생성일
  @override
  @TimestampOrDateTimeConverter()
  final DateTime createdAt;

  /// 등록자 ID
  @override
  final String createdBy;

  /// 작성자 닉네임
  @override
  final String? authorNickname;

  /// 작성자 프로필 이미지 URL
  @override
  final String? authorProfileUrl;

  @override
  String toString() {
    return 'VoteDto(id: $id, title: $title, artist: $artist, youtubeUrl: $youtubeUrl, voteCount: $voteCount, createdAt: $createdAt, createdBy: $createdBy, authorNickname: $authorNickname, authorProfileUrl: $authorProfileUrl)';
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
                other.createdBy == createdBy) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorProfileUrl, authorProfileUrl) ||
                other.authorProfileUrl == authorProfileUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, artist, youtubeUrl,
      voteCount, createdAt, createdBy, authorNickname, authorProfileUrl);

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
      required final String createdBy,
      final String? authorNickname,
      final String? authorProfileUrl}) = _$VoteDtoImpl;

  factory _VoteDto.fromJson(Map<String, dynamic> json) = _$VoteDtoImpl.fromJson;

  /// 곡 문서 ID
  @override
  String get id;

  /// 곡 제목
  @override
  String get title;

  /// 아티스트
  @override
  String get artist;

  /// 유튜브 URL
  @override
  String? get youtubeUrl;

  /// 득표수
  @override
  int get voteCount;

  /// 생성일
  @override
  @TimestampOrDateTimeConverter()
  DateTime get createdAt;

  /// 등록자 ID
  @override
  String get createdBy;

  /// 작성자 닉네임
  @override
  String? get authorNickname;

  /// 작성자 프로필 이미지 URL
  @override
  String? get authorProfileUrl;

  /// Create a copy of VoteDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoteDtoImplCopyWith<_$VoteDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
