// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voting_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$VotingState {
  List<String> get selectedVoteIds => throw _privateConstructorUsedError;
  int get pick => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;

  /// Create a copy of VotingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VotingStateCopyWith<VotingState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotingStateCopyWith<$Res> {
  factory $VotingStateCopyWith(
          VotingState value, $Res Function(VotingState) then) =
      _$VotingStateCopyWithImpl<$Res, VotingState>;
  @useResult
  $Res call({List<String> selectedVoteIds, int pick, String? error});
}

/// @nodoc
class _$VotingStateCopyWithImpl<$Res, $Val extends VotingState>
    implements $VotingStateCopyWith<$Res> {
  _$VotingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VotingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedVoteIds = null,
    Object? pick = null,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      selectedVoteIds: null == selectedVoteIds
          ? _value.selectedVoteIds
          : selectedVoteIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pick: null == pick
          ? _value.pick
          : pick // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VotingStateImplCopyWith<$Res>
    implements $VotingStateCopyWith<$Res> {
  factory _$$VotingStateImplCopyWith(
          _$VotingStateImpl value, $Res Function(_$VotingStateImpl) then) =
      __$$VotingStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> selectedVoteIds, int pick, String? error});
}

/// @nodoc
class __$$VotingStateImplCopyWithImpl<$Res>
    extends _$VotingStateCopyWithImpl<$Res, _$VotingStateImpl>
    implements _$$VotingStateImplCopyWith<$Res> {
  __$$VotingStateImplCopyWithImpl(
      _$VotingStateImpl _value, $Res Function(_$VotingStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of VotingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedVoteIds = null,
    Object? pick = null,
    Object? error = freezed,
  }) {
    return _then(_$VotingStateImpl(
      selectedVoteIds: null == selectedVoteIds
          ? _value._selectedVoteIds
          : selectedVoteIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      pick: null == pick
          ? _value.pick
          : pick // ignore: cast_nullable_to_non_nullable
              as int,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$VotingStateImpl implements _VotingState {
  const _$VotingStateImpl(
      {final List<String> selectedVoteIds = const [],
      this.pick = 0,
      this.error})
      : _selectedVoteIds = selectedVoteIds;

  final List<String> _selectedVoteIds;
  @override
  @JsonKey()
  List<String> get selectedVoteIds {
    if (_selectedVoteIds is EqualUnmodifiableListView) return _selectedVoteIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedVoteIds);
  }

  @override
  @JsonKey()
  final int pick;
  @override
  final String? error;

  @override
  String toString() {
    return 'VotingState(selectedVoteIds: $selectedVoteIds, pick: $pick, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VotingStateImpl &&
            const DeepCollectionEquality()
                .equals(other._selectedVoteIds, _selectedVoteIds) &&
            (identical(other.pick, pick) || other.pick == pick) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_selectedVoteIds), pick, error);

  /// Create a copy of VotingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VotingStateImplCopyWith<_$VotingStateImpl> get copyWith =>
      __$$VotingStateImplCopyWithImpl<_$VotingStateImpl>(this, _$identity);
}

abstract class _VotingState implements VotingState {
  const factory _VotingState(
      {final List<String> selectedVoteIds,
      final int pick,
      final String? error}) = _$VotingStateImpl;

  @override
  List<String> get selectedVoteIds;
  @override
  int get pick;
  @override
  String? get error;

  /// Create a copy of VotingState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VotingStateImplCopyWith<_$VotingStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
