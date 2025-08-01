// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostDto _$PostDtoFromJson(Map<String, dynamic> json) {
  return _PostDto.fromJson(json);
}

/// @nodoc
mixin _$PostDto {
  /// 게시글 고유 ID
  String get id => throw _privateConstructorUsedError;

  /// 작성자 ID
  String get authorId => throw _privateConstructorUsedError;

  /// 작성자 이름
  String get authorName => throw _privateConstructorUsedError;

  /// 제목
  String get title => throw _privateConstructorUsedError;

  /// 내용
  String get content => throw _privateConstructorUsedError;

  /// 카테고리
  String get category => throw _privateConstructorUsedError;

  /// 생성일(ISO8601)
  String get createdAt => throw _privateConstructorUsedError;

  /// 수정일(ISO8601)
  String get updatedAt => throw _privateConstructorUsedError;

  /// 좋아요 수
  int get likeCount => throw _privateConstructorUsedError;

  /// 댓글 수
  int get commentCount => throw _privateConstructorUsedError;

  /// 이미지 URL 리스트
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this PostDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostDtoCopyWith<PostDto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDtoCopyWith<$Res> {
  factory $PostDtoCopyWith(PostDto value, $Res Function(PostDto) then) =
      _$PostDtoCopyWithImpl<$Res, PostDto>;
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String title,
      String content,
      String category,
      String createdAt,
      String updatedAt,
      int likeCount,
      int commentCount,
      List<String> imageUrls});
}

/// @nodoc
class _$PostDtoCopyWithImpl<$Res, $Val extends PostDto>
    implements $PostDtoCopyWith<$Res> {
  _$PostDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? imageUrls = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostDtoImplCopyWith<$Res> implements $PostDtoCopyWith<$Res> {
  factory _$$PostDtoImplCopyWith(
          _$PostDtoImpl value, $Res Function(_$PostDtoImpl) then) =
      __$$PostDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String authorId,
      String authorName,
      String title,
      String content,
      String category,
      String createdAt,
      String updatedAt,
      int likeCount,
      int commentCount,
      List<String> imageUrls});
}

/// @nodoc
class __$$PostDtoImplCopyWithImpl<$Res>
    extends _$PostDtoCopyWithImpl<$Res, _$PostDtoImpl>
    implements _$$PostDtoImplCopyWith<$Res> {
  __$$PostDtoImplCopyWithImpl(
      _$PostDtoImpl _value, $Res Function(_$PostDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? authorId = null,
    Object? authorName = null,
    Object? title = null,
    Object? content = null,
    Object? category = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? likeCount = null,
    Object? commentCount = null,
    Object? imageUrls = null,
  }) {
    return _then(_$PostDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorName: null == authorName
          ? _value.authorName
          : authorName // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as String,
      likeCount: null == likeCount
          ? _value.likeCount
          : likeCount // ignore: cast_nullable_to_non_nullable
              as int,
      commentCount: null == commentCount
          ? _value.commentCount
          : commentCount // ignore: cast_nullable_to_non_nullable
              as int,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostDtoImpl implements _PostDto {
  const _$PostDtoImpl(
      {required this.id,
      required this.authorId,
      required this.authorName,
      required this.title,
      required this.content,
      required this.category,
      required this.createdAt,
      required this.updatedAt,
      this.likeCount = 0,
      this.commentCount = 0,
      final List<String> imageUrls = const []})
      : _imageUrls = imageUrls;

  factory _$PostDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostDtoImplFromJson(json);

  /// 게시글 고유 ID
  @override
  final String id;

  /// 작성자 ID
  @override
  final String authorId;

  /// 작성자 이름
  @override
  final String authorName;

  /// 제목
  @override
  final String title;

  /// 내용
  @override
  final String content;

  /// 카테고리
  @override
  final String category;

  /// 생성일(ISO8601)
  @override
  final String createdAt;

  /// 수정일(ISO8601)
  @override
  final String updatedAt;

  /// 좋아요 수
  @override
  @JsonKey()
  final int likeCount;

  /// 댓글 수
  @override
  @JsonKey()
  final int commentCount;

  /// 이미지 URL 리스트
  final List<String> _imageUrls;

  /// 이미지 URL 리스트
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'PostDto(id: $id, authorId: $authorId, authorName: $authorName, title: $title, content: $content, category: $category, createdAt: $createdAt, updatedAt: $updatedAt, likeCount: $likeCount, commentCount: $commentCount, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorName, authorName) ||
                other.authorName == authorName) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.likeCount, likeCount) ||
                other.likeCount == likeCount) &&
            (identical(other.commentCount, commentCount) ||
                other.commentCount == commentCount) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      authorId,
      authorName,
      title,
      content,
      category,
      createdAt,
      updatedAt,
      likeCount,
      commentCount,
      const DeepCollectionEquality().hash(_imageUrls));

  /// Create a copy of PostDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDtoImplCopyWith<_$PostDtoImpl> get copyWith =>
      __$$PostDtoImplCopyWithImpl<_$PostDtoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostDtoImplToJson(
      this,
    );
  }
}

abstract class _PostDto implements PostDto {
  const factory _PostDto(
      {required final String id,
      required final String authorId,
      required final String authorName,
      required final String title,
      required final String content,
      required final String category,
      required final String createdAt,
      required final String updatedAt,
      final int likeCount,
      final int commentCount,
      final List<String> imageUrls}) = _$PostDtoImpl;

  factory _PostDto.fromJson(Map<String, dynamic> json) = _$PostDtoImpl.fromJson;

  /// 게시글 고유 ID
  @override
  String get id;

  /// 작성자 ID
  @override
  String get authorId;

  /// 작성자 이름
  @override
  String get authorName;

  /// 제목
  @override
  String get title;

  /// 내용
  @override
  String get content;

  /// 카테고리
  @override
  String get category;

  /// 생성일(ISO8601)
  @override
  String get createdAt;

  /// 수정일(ISO8601)
  @override
  String get updatedAt;

  /// 좋아요 수
  @override
  int get likeCount;

  /// 댓글 수
  @override
  int get commentCount;

  /// 이미지 URL 리스트
  @override
  List<String> get imageUrls;

  /// Create a copy of PostDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDtoImplCopyWith<_$PostDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
