// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PostEntity _$PostEntityFromJson(Map<String, dynamic> json) {
  return _PostEntity.fromJson(json);
}

/// @nodoc
mixin _$PostEntity {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get authorId => throw _privateConstructorUsedError;
  String get authorNickname => throw _privateConstructorUsedError;
  String get authorProfileUrl => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String? get youtubeUrl => throw _privateConstructorUsedError;
  bool? get isNotice => throw _privateConstructorUsedError;
  List<String>? get likes => throw _privateConstructorUsedError;
  int? get likesCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this PostEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostEntityCopyWith<PostEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostEntityCopyWith<$Res> {
  factory $PostEntityCopyWith(
    PostEntity value,
    $Res Function(PostEntity) then,
  ) = _$PostEntityCopyWithImpl<$Res, PostEntity>;
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String authorId,
    String authorNickname,
    String authorProfileUrl,
    String category,
    String? youtubeUrl,
    bool? isNotice,
    List<String>? likes,
    int? likesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class _$PostEntityCopyWithImpl<$Res, $Val extends PostEntity>
    implements $PostEntityCopyWith<$Res> {
  _$PostEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorNickname = null,
    Object? authorProfileUrl = null,
    Object? category = null,
    Object? youtubeUrl = freezed,
    Object? isNotice = freezed,
    Object? likes = freezed,
    Object? likesCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
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
            authorProfileUrl: null == authorProfileUrl
                ? _value.authorProfileUrl
                : authorProfileUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            youtubeUrl: freezed == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            isNotice: freezed == isNotice
                ? _value.isNotice
                : isNotice // ignore: cast_nullable_to_non_nullable
                      as bool?,
            likes: freezed == likes
                ? _value.likes
                : likes // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            likesCount: freezed == likesCount
                ? _value.likesCount
                : likesCount // ignore: cast_nullable_to_non_nullable
                      as int?,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            updatedAt: freezed == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostEntityImplCopyWith<$Res>
    implements $PostEntityCopyWith<$Res> {
  factory _$$PostEntityImplCopyWith(
    _$PostEntityImpl value,
    $Res Function(_$PostEntityImpl) then,
  ) = __$$PostEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    String content,
    String authorId,
    String authorNickname,
    String authorProfileUrl,
    String category,
    String? youtubeUrl,
    bool? isNotice,
    List<String>? likes,
    int? likesCount,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// @nodoc
class __$$PostEntityImplCopyWithImpl<$Res>
    extends _$PostEntityCopyWithImpl<$Res, _$PostEntityImpl>
    implements _$$PostEntityImplCopyWith<$Res> {
  __$$PostEntityImplCopyWithImpl(
    _$PostEntityImpl _value,
    $Res Function(_$PostEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? content = null,
    Object? authorId = null,
    Object? authorNickname = null,
    Object? authorProfileUrl = null,
    Object? category = null,
    Object? youtubeUrl = freezed,
    Object? isNotice = freezed,
    Object? likes = freezed,
    Object? likesCount = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(
      _$PostEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
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
        authorProfileUrl: null == authorProfileUrl
            ? _value.authorProfileUrl
            : authorProfileUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        youtubeUrl: freezed == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        isNotice: freezed == isNotice
            ? _value.isNotice
            : isNotice // ignore: cast_nullable_to_non_nullable
                  as bool?,
        likes: freezed == likes
            ? _value._likes
            : likes // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        likesCount: freezed == likesCount
            ? _value.likesCount
            : likesCount // ignore: cast_nullable_to_non_nullable
                  as int?,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        updatedAt: freezed == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PostEntityImpl implements _PostEntity {
  const _$PostEntityImpl({
    required this.id,
    required this.title,
    required this.content,
    required this.authorId,
    required this.authorNickname,
    required this.authorProfileUrl,
    required this.category,
    this.youtubeUrl,
    this.isNotice,
    final List<String>? likes,
    this.likesCount,
    this.createdAt,
    this.updatedAt,
  }) : _likes = likes;

  factory _$PostEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String content;
  @override
  final String authorId;
  @override
  final String authorNickname;
  @override
  final String authorProfileUrl;
  @override
  final String category;
  @override
  final String? youtubeUrl;
  @override
  final bool? isNotice;
  final List<String>? _likes;
  @override
  List<String>? get likes {
    final value = _likes;
    if (value == null) return null;
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? likesCount;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'PostEntity(id: $id, title: $title, content: $content, authorId: $authorId, authorNickname: $authorNickname, authorProfileUrl: $authorProfileUrl, category: $category, youtubeUrl: $youtubeUrl, isNotice: $isNotice, likes: $likes, likesCount: $likesCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.authorId, authorId) ||
                other.authorId == authorId) &&
            (identical(other.authorNickname, authorNickname) ||
                other.authorNickname == authorNickname) &&
            (identical(other.authorProfileUrl, authorProfileUrl) ||
                other.authorProfileUrl == authorProfileUrl) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.isNotice, isNotice) ||
                other.isNotice == isNotice) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.likesCount, likesCount) ||
                other.likesCount == likesCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    content,
    authorId,
    authorNickname,
    authorProfileUrl,
    category,
    youtubeUrl,
    isNotice,
    const DeepCollectionEquality().hash(_likes),
    likesCount,
    createdAt,
    updatedAt,
  );

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      __$$PostEntityImplCopyWithImpl<_$PostEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostEntityImplToJson(this);
  }
}

abstract class _PostEntity implements PostEntity {
  const factory _PostEntity({
    required final String id,
    required final String title,
    required final String content,
    required final String authorId,
    required final String authorNickname,
    required final String authorProfileUrl,
    required final String category,
    final String? youtubeUrl,
    final bool? isNotice,
    final List<String>? likes,
    final int? likesCount,
    final DateTime? createdAt,
    final DateTime? updatedAt,
  }) = _$PostEntityImpl;

  factory _PostEntity.fromJson(Map<String, dynamic> json) =
      _$PostEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get content;
  @override
  String get authorId;
  @override
  String get authorNickname;
  @override
  String get authorProfileUrl;
  @override
  String get category;
  @override
  String? get youtubeUrl;
  @override
  bool? get isNotice;
  @override
  List<String>? get likes;
  @override
  int? get likesCount;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;

  /// Create a copy of PostEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostEntityImplCopyWith<_$PostEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
