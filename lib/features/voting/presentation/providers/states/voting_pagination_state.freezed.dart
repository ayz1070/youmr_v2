// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voting_pagination_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VotingPaginationState {
  List<Vote> get votes => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get hasMore => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  String? get lastDocumentId => throw _privateConstructorUsedError;
  List<String> get selectedVoteIds => throw _privateConstructorUsedError;

  /// Create a copy of VotingPaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VotingPaginationStateCopyWith<VotingPaginationState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotingPaginationStateCopyWith<$Res> {
  factory $VotingPaginationStateCopyWith(VotingPaginationState value,
          $Res Function(VotingPaginationState) then) =
      _$VotingPaginationStateCopyWithImpl<$Res, VotingPaginationState>;
  @useResult
  $Res call(
      {List<Vote> votes,
      bool isLoading,
      bool hasMore,
      String? error,
      String? lastDocumentId,
      List<String> selectedVoteIds});
}

/// @nodoc
class _$VotingPaginationStateCopyWithImpl<$Res,
        $Val extends VotingPaginationState>
    implements $VotingPaginationStateCopyWith<$Res> {
  _$VotingPaginationStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VotingPaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? votes = null,
    Object? isLoading = null,
    Object? hasMore = null,
    Object? error = freezed,
    Object? lastDocumentId = freezed,
    Object? selectedVoteIds = null,
  }) {
    return _then(_value.copyWith(
      votes: null == votes
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<Vote>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastDocumentId: freezed == lastDocumentId
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedVoteIds: null == selectedVoteIds
          ? _value.selectedVoteIds
          : selectedVoteIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VotingPaginationStateImplCopyWith<$Res>
    implements $VotingPaginationStateCopyWith<$Res> {
  factory _$$VotingPaginationStateImplCopyWith(
          _$VotingPaginationStateImpl value,
          $Res Function(_$VotingPaginationStateImpl) then) =
      __$$VotingPaginationStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Vote> votes,
      bool isLoading,
      bool hasMore,
      String? error,
      String? lastDocumentId,
      List<String> selectedVoteIds});
}

/// @nodoc
class __$$VotingPaginationStateImplCopyWithImpl<$Res>
    extends _$VotingPaginationStateCopyWithImpl<$Res,
        _$VotingPaginationStateImpl>
    implements _$$VotingPaginationStateImplCopyWith<$Res> {
  __$$VotingPaginationStateImplCopyWithImpl(_$VotingPaginationStateImpl _value,
      $Res Function(_$VotingPaginationStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VotingPaginationState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? votes = null,
    Object? isLoading = null,
    Object? hasMore = null,
    Object? error = freezed,
    Object? lastDocumentId = freezed,
    Object? selectedVoteIds = null,
  }) {
    return _then(_$VotingPaginationStateImpl(
      votes: null == votes
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<Vote>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMore: null == hasMore
          ? _value.hasMore
          : hasMore // ignore: cast_nullable_to_non_nullable
              as bool,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
      lastDocumentId: freezed == lastDocumentId
          ? _value.lastDocumentId
          : lastDocumentId // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedVoteIds: null == selectedVoteIds
          ? _value._selectedVoteIds
          : selectedVoteIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$VotingPaginationStateImpl implements _VotingPaginationState {
  const _$VotingPaginationStateImpl(
      {final List<Vote> votes = const [],
      this.isLoading = false,
      this.hasMore = true,
      this.error,
      this.lastDocumentId,
      final List<String> selectedVoteIds = const []})
      : _votes = votes,
        _selectedVoteIds = selectedVoteIds;

  final List<Vote> _votes;
  @override
  @JsonKey()
  List<Vote> get votes {
    if (_votes is EqualUnmodifiableListView) return _votes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votes);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final bool hasMore;
  @override
  final String? error;
  @override
  final String? lastDocumentId;
  final List<String> _selectedVoteIds;
  @override
  @JsonKey()
  List<String> get selectedVoteIds {
    if (_selectedVoteIds is EqualUnmodifiableListView) return _selectedVoteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedVoteIds);
  }

  @override
  String toString() {
    return 'VotingPaginationState(votes: $votes, isLoading: $isLoading, hasMore: $hasMore, error: $error, lastDocumentId: $lastDocumentId, selectedVoteIds: $selectedVoteIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VotingPaginationStateImpl &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.lastDocumentId, lastDocumentId) ||
                other.lastDocumentId == lastDocumentId) &&
            const DeepCollectionEquality()
                .equals(other._selectedVoteIds, _selectedVoteIds));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_votes),
      isLoading,
      hasMore,
      error,
      lastDocumentId,
      const DeepCollectionEquality().hash(_selectedVoteIds));

  /// Create a copy of VotingPaginationState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VotingPaginationStateImplCopyWith<_$VotingPaginationStateImpl>
      get copyWith => __$$VotingPaginationStateImplCopyWithImpl<
          _$VotingPaginationStateImpl>(this, _$identity);
}

abstract class _VotingPaginationState implements VotingPaginationState {
  const factory _VotingPaginationState(
      {final List<Vote> votes,
      final bool isLoading,
      final bool hasMore,
      final String? error,
      final String? lastDocumentId,
      final List<String> selectedVoteIds}) = _$VotingPaginationStateImpl;

  @override
  List<Vote> get votes;
  @override
  bool get isLoading;
  @override
  bool get hasMore;
  @override
  String? get error;
  @override
  String? get lastDocumentId;
  @override
  List<String> get selectedVoteIds;

  /// Create a copy of VotingPaginationState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VotingPaginationStateImplCopyWith<_$VotingPaginationStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
