// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Post _$PostFromJson(Map<String, dynamic> json) {
  return _Post.fromJson(json);
}

/// @nodoc
mixin _$Post {
  /// 게시글 고유 ID
  String get id => throw _privateConstructorUsedError;

  /// 작성자 UID
  String get authorId => throw _privateConstructorUsedError;

  /// 작성자 닉네임
  String get authorName => throw _privateConstructorUsedError;

  /// 게시글 제목
  String get title => throw _privateConstructorUsedError;

  /// 게시글 본문
  String get content => throw _privateConstructorUsedError;

  /// 게시글 카테고리
  String get category => throw _privateConstructorUsedError;

  /// 작성 시각 (Timestamp 또는 ISO8601 문자열)
  String get createdAt => throw _privateConstructorUsedError;

  /// 마지막 수정 시각 (Timestamp 또는 ISO8601 문자열)
  String get updatedAt => throw _privateConstructorUsedError;

  /// 좋아요 수
  int get likeCount => throw _privateConstructorUsedError;

  /// 댓글 수
  int get commentCount => throw _privateConstructorUsedError;

  /// 게시글에 첨부된 이미지 URL 목록
  List<String> get imageUrls => throw _privateConstructorUsedError;

  /// Serializes this Post to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostCopyWith<Post> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCopyWith<$Res> {
  factory $PostCopyWith(Post value, $Res Function(Post) then) =
      _$PostCopyWithImpl<$Res, Post>;
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
class _$PostCopyWithImpl<$Res, $Val extends Post>
    implements $PostCopyWith<$Res> {
  _$PostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Post
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
abstract class _$$PostImplCopyWith<$Res> implements $PostCopyWith<$Res> {
  factory _$$PostImplCopyWith(
          _$PostImpl value, $Res Function(_$PostImpl) then) =
      __$$PostImplCopyWithImpl<$Res>;
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
class __$$PostImplCopyWithImpl<$Res>
    extends _$PostCopyWithImpl<$Res, _$PostImpl>
    implements _$$PostImplCopyWith<$Res> {
  __$$PostImplCopyWithImpl(_$PostImpl _value, $Res Function(_$PostImpl) _then)
      : super(_value, _then);

  /// Create a copy of Post
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
    return _then(_$PostImpl(
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
class _$PostImpl implements _Post {
  const _$PostImpl(
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

  factory _$PostImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostImplFromJson(json);

  /// 게시글 고유 ID
  @override
  final String id;

  /// 작성자 UID
  @override
  final String authorId;

  /// 작성자 닉네임
  @override
  final String authorName;

  /// 게시글 제목
  @override
  final String title;

  /// 게시글 본문
  @override
  final String content;

  /// 게시글 카테고리
  @override
  final String category;

  /// 작성 시각 (Timestamp 또는 ISO8601 문자열)
  @override
  final String createdAt;

  /// 마지막 수정 시각 (Timestamp 또는 ISO8601 문자열)
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

  /// 게시글에 첨부된 이미지 URL 목록
  final List<String> _imageUrls;

  /// 게시글에 첨부된 이미지 URL 목록
  @override
  @JsonKey()
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  String toString() {
    return 'Post(id: $id, authorId: $authorId, authorName: $authorName, title: $title, content: $content, category: $category, createdAt: $createdAt, updatedAt: $updatedAt, likeCount: $likeCount, commentCount: $commentCount, imageUrls: $imageUrls)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostImpl &&
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

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      __$$PostImplCopyWithImpl<_$PostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostImplToJson(
      this,
    );
  }
}

abstract class _Post implements Post {
  const factory _Post(
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
      final List<String> imageUrls}) = _$PostImpl;

  factory _Post.fromJson(Map<String, dynamic> json) = _$PostImpl.fromJson;

  /// 게시글 고유 ID
  @override
  String get id;

  /// 작성자 UID
  @override
  String get authorId;

  /// 작성자 닉네임
  @override
  String get authorName;

  /// 게시글 제목
  @override
  String get title;

  /// 게시글 본문
  @override
  String get content;

  /// 게시글 카테고리
  @override
  String get category;

  /// 작성 시각 (Timestamp 또는 ISO8601 문자열)
  @override
  String get createdAt;

  /// 마지막 수정 시각 (Timestamp 또는 ISO8601 문자열)
  @override
  String get updatedAt;

  /// 좋아요 수
  @override
  int get likeCount;

  /// 댓글 수
  @override
  int get commentCount;

  /// 게시글에 첨부된 이미지 URL 목록
  @override
  List<String> get imageUrls;

  /// Create a copy of Post
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostImplCopyWith<_$PostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
