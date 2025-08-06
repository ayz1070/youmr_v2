// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return _Comment.fromJson(json);
}

/// @nodoc
mixin _$Comment {
  /// 댓글 ID
  String get id => throw _privateConstructorUsedError;

  /// 게시글 ID
  String get postId => throw _privateConstructorUsedError;

  /// 댓글 내용
  String get content => throw _privateConstructorUsedError;

  /// 작성자 ID
  String get authorId => throw _privateConstructorUsedError;

  /// 작성자 닉네임
  String get authorNickname => throw _privateConstructorUsedError;

  /// 작성자 프로필 이미지 URL
  String? get authorProfileUrl => throw _privateConstructorUsedError;

  /// 좋아요한 사용자 ID 리스트
  List<String> get likes => throw _privateConstructorUsedError;

  /// 좋아요 수
  int get likesCount => throw _privateConstructorUsedError;

  /// 생성 시간
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 서버 생성 시간
  DateTime? get serverCreatedAt => throw _privateConstructorUsedError;

  /// Serializes this Comment to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CommentCopyWith<Comment> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentCopyWith<$Res> {
  factory $CommentCopyWith(Comment value, $Res Function(Comment) then) =
      _$CommentCopyWithImpl<$Res, Comment>;
  @useResult
  $Res call(
      {String id,
      String postId,
      String content,
      String authorId,
      String authorNickname,
      String? authorProfileUrl,
      List<String> likes,
      int likesCount,
      DateTime createdAt,
      DateTime? serverCreatedAt});
}

/// @nodoc
class _$CommentCopyWithImpl<$Res, $Val extends Comment>
    implements $CommentCopyWith<$Res> {
  _$CommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorNickname = null,
    Object? authorProfileUrl = freezed,
    Object? likes = null,
    Object? likesCount = null,
    Object? createdAt = null,
    Object? serverCreatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serverCreatedAt: freezed == serverCreatedAt
          ? _value.serverCreatedAt
          : serverCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentImplCopyWith<$Res> implements $CommentCopyWith<$Res> {
  factory _$$CommentImplCopyWith(
          _$CommentImpl value, $Res Function(_$CommentImpl) then) =
      __$$CommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String postId,
      String content,
      String authorId,
      String authorNickname,
      String? authorProfileUrl,
      List<String> likes,
      int likesCount,
      DateTime createdAt,
      DateTime? serverCreatedAt});
}

/// @nodoc
class __$$CommentImplCopyWithImpl<$Res>
    extends _$CommentCopyWithImpl<$Res, _$CommentImpl>
    implements _$$CommentImplCopyWith<$Res> {
  __$$CommentImplCopyWithImpl(
      _$CommentImpl _value, $Res Function(_$CommentImpl) _then)
      : super(_value, _then);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? postId = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorNickname = null,
    Object? authorProfileUrl = freezed,
    Object? likes = null,
    Object? likesCount = null,
    Object? createdAt = null,
    Object? serverCreatedAt = freezed,
  }) {
    return _then(_$CommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      authorId: null == authorId
          ? _value.authorId
          : authorId // ignore: cast_nullable_to_non_nullable
              as String,
      authorNickname: null == authorNickname
          ? _value.authorNickname
          : authorNickname // ignore: cast_nullable_to_non_nullable
              as String,
      authorProfileUrl: freezed == authorProfileUrl
          ? _value.authorProfileUrl
          : authorProfileUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      likesCount: null == likesCount
          ? _value.likesCount
          : likesCount // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      serverCreatedAt: freezed == serverCreatedAt
          ? _value.serverCreatedAt
          : serverCreatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentImpl implements _Comment {
  const _$CommentImpl(
      {required this.id,
      required this.postId,
      required this.content,
      required this.authorId,
      required this.authorNickname,
      this.authorProfileUrl,
      final List<String> likes = const [],
      this.likesCount = 0,
      required this.createdAt,
      this.serverCreatedAt})
      : _likes = likes;

  factory _$CommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentImplFromJson(json);

  /// 댓글 ID
  @override
  final String id;

  /// 게시글 ID
  @override
  final String postId;

  /// 댓글 내용
  @override
  final String content;

  /// 작성자 ID
  @override
  final String authorId;

  /// 작성자 닉네임
  @override
  final String authorNickname;

  /// 작성자 프로필 이미지 URL
  @override
  final String? authorProfileUrl;

  /// 좋아요한 사용자 ID 리스트
  final List<String> _likes;

  /// 좋아요한 사용자 ID 리스트
  @override
  @JsonKey()
  List<String> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  /// 좋아요 수
  @override
  @JsonKey()
  final int likesCount;

  /// 생성 시간
  @override
  final DateTime createdAt;

  /// 서버 생성 시간
  @override
  final DateTime? serverCreatedAt;

  @override
  String toString() {
    return 'Comment(id: $id, postId: $postId, content: $content, authorId: $authorId, authorNickname: $authorNickname, authorProfileUrl: $authorProfileUrl, likes: $likes, likesCount: $likesCount, createdAt: $createdAt, serverCreatedAt: $serverCreatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorProfileUrl, authorProfileUrl) ||
                other.authorProfileUrl == authorProfileUrl) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.serverCreatedAt, serverCreatedAt) ||
                other.serverCreatedAt == serverCreatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      postId,
      content,
      authorId,
      authorNickname,
      authorProfileUrl,
      const DeepCollectionEquality().hash(_likes),
      likesCount,
      createdAt,
      serverCreatedAt);

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      __$$CommentImplCopyWithImpl<_$CommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentImplToJson(
      this,
    );
  }
}

abstract class _Comment implements Comment {
  const factory _Comment(
      {required final String id,
      required final String postId,
      required final String content,
      required final String authorId,
      required final String authorNickname,
      final String? authorProfileUrl,
      final List<String> likes,
      final int likesCount,
      required final DateTime createdAt,
      final DateTime? serverCreatedAt}) = _$CommentImpl;

  factory _Comment.fromJson(Map<String, dynamic> json) = _$CommentImpl.fromJson;

  /// 댓글 ID
  @override
  String get id;

  /// 게시글 ID
  @override
  String get postId;

  /// 댓글 내용
  @override
  String get content;

  /// 작성자 ID
  @override
  String get authorId;

  /// 작성자 닉네임
  @override
  String get authorNickname;

  /// 작성자 프로필 이미지 URL
  @override
  String? get authorProfileUrl;

  /// 좋아요한 사용자 ID 리스트
  @override
  List<String> get likes;

  /// 좋아요 수
  @override
  int get likesCount;

  /// 생성 시간
  @override
  DateTime get createdAt;

  /// 서버 생성 시간
  @override
  DateTime? get serverCreatedAt;

  /// Create a copy of Comment
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CommentImplCopyWith<_$CommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
