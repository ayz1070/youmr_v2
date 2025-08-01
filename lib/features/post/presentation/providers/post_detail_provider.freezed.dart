// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_detail_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PostDetailState {
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isCommentSheetOpen => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get editCommentId => throw _privateConstructorUsedError;
  String? get editContent => throw _privateConstructorUsedError;
  DocumentSnapshot<Map<String, dynamic>>? get post =>
      throw _privateConstructorUsedError;
  YoutubePlayerController? get ytController =>
      throw _privateConstructorUsedError;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostDetailStateCopyWith<PostDetailState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostDetailStateCopyWith<$Res> {
  factory $PostDetailStateCopyWith(
          PostDetailState value, $Res Function(PostDetailState) then) =
      _$PostDetailStateCopyWithImpl<$Res, PostDetailState>;
  @useResult
  $Res call(
      {bool isLoading,
      bool isCommentSheetOpen,
      String? error,
      String? editCommentId,
      String? editContent,
      DocumentSnapshot<Map<String, dynamic>>? post,
      YoutubePlayerController? ytController});
}

/// @nodoc
class _$PostDetailStateCopyWithImpl<$Res, $Val extends PostDetailState>
    implements $PostDetailStateCopyWith<$Res> {
  _$PostDetailStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCommentSheetOpen = null,
    Object? error = freezed,
    Object? editCommentId = freezed,
    Object? editContent = freezed,
    Object? post = freezed,
    Object? ytController = freezed,
  }) {
    return _then(_value.copyWith(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommentSheetOpen: null == isCommentSheetOpen
          ? _value.isCommentSheetOpen
          : isCommentSheetOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      editCommentId: freezed == editCommentId
          ? _value.editCommentId
          : editCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      editContent: freezed == editContent
          ? _value.editContent
          : editContent // ignore: cast_nullable_to_non_nullable
              as String?,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Map<String, dynamic>>?,
      ytController: freezed == ytController
          ? _value.ytController
          : ytController // ignore: cast_nullable_to_non_nullable
              as YoutubePlayerController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PostDetailStateImplCopyWith<$Res>
    implements $PostDetailStateCopyWith<$Res> {
  factory _$$PostDetailStateImplCopyWith(_$PostDetailStateImpl value,
          $Res Function(_$PostDetailStateImpl) then) =
      __$$PostDetailStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isLoading,
      bool isCommentSheetOpen,
      String? error,
      String? editCommentId,
      String? editContent,
      DocumentSnapshot<Map<String, dynamic>>? post,
      YoutubePlayerController? ytController});
}

/// @nodoc
class __$$PostDetailStateImplCopyWithImpl<$Res>
    extends _$PostDetailStateCopyWithImpl<$Res, _$PostDetailStateImpl>
    implements _$$PostDetailStateImplCopyWith<$Res> {
  __$$PostDetailStateImplCopyWithImpl(
      _$PostDetailStateImpl _value, $Res Function(_$PostDetailStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? isCommentSheetOpen = null,
    Object? error = freezed,
    Object? editCommentId = freezed,
    Object? editContent = freezed,
    Object? post = freezed,
    Object? ytController = freezed,
  }) {
    return _then(_$PostDetailStateImpl(
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isCommentSheetOpen: null == isCommentSheetOpen
          ? _value.isCommentSheetOpen
          : isCommentSheetOpen // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      editCommentId: freezed == editCommentId
          ? _value.editCommentId
          : editCommentId // ignore: cast_nullable_to_non_nullable
              as String?,
      editContent: freezed == editContent
          ? _value.editContent
          : editContent // ignore: cast_nullable_to_non_nullable
              as String?,
      post: freezed == post
          ? _value.post
          : post // ignore: cast_nullable_to_non_nullable
              as DocumentSnapshot<Map<String, dynamic>>?,
      ytController: freezed == ytController
          ? _value.ytController
          : ytController // ignore: cast_nullable_to_non_nullable
              as YoutubePlayerController?,
    ));
  }
}

/// @nodoc

class _$PostDetailStateImpl implements _PostDetailState {
  const _$PostDetailStateImpl(
      {this.isLoading = false,
      this.isCommentSheetOpen = false,
      this.error,
      this.editCommentId,
      this.editContent,
      this.post,
      this.ytController});

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool isCommentSheetOpen;
  @override
  final String? error;
  @override
  final String? editCommentId;
  @override
  final String? editContent;
  @override
  final DocumentSnapshot<Map<String, dynamic>>? post;
  @override
  final YoutubePlayerController? ytController;

  @override
  String toString() {
    return 'PostDetailState(isLoading: $isLoading, isCommentSheetOpen: $isCommentSheetOpen, error: $error, editCommentId: $editCommentId, editContent: $editContent, post: $post, ytController: $ytController)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostDetailStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isCommentSheetOpen, isCommentSheetOpen) ||
                other.isCommentSheetOpen == isCommentSheetOpen) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.editCommentId, editCommentId) ||
                other.editCommentId == editCommentId) &&
            (identical(other.editContent, editContent) ||
                other.editContent == editContent) &&
            (identical(other.post, post) || other.post == post) &&
            (identical(other.ytController, ytController) ||
                other.ytController == ytController));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, isCommentSheetOpen,
      error, editCommentId, editContent, post, ytController);

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostDetailStateImplCopyWith<_$PostDetailStateImpl> get copyWith =>
      __$$PostDetailStateImplCopyWithImpl<_$PostDetailStateImpl>(
          this, _$identity);
}

abstract class _PostDetailState implements PostDetailState {
  const factory _PostDetailState(
      {final bool isLoading,
      final bool isCommentSheetOpen,
      final String? error,
      final String? editCommentId,
      final String? editContent,
      final DocumentSnapshot<Map<String, dynamic>>? post,
      final YoutubePlayerController? ytController}) = _$PostDetailStateImpl;

  @override
  bool get isLoading;
  @override
  bool get isCommentSheetOpen;
  @override
  String? get error;
  @override
  String? get editCommentId;
  @override
  String? get editContent;
  @override
  DocumentSnapshot<Map<String, dynamic>>? get post;
  @override
  YoutubePlayerController? get ytController;

  /// Create a copy of PostDetailState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostDetailStateImplCopyWith<_$PostDetailStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
