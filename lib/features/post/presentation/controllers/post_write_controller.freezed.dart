// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_write_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$PostWriteState {
  bool get isLoading => throw _privateConstructorUsedError;
  String? get error => throw _privateConstructorUsedError;
  bool? get success => throw _privateConstructorUsedError;

  /// Create a copy of PostWriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PostWriteStateCopyWith<PostWriteState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostWriteStateCopyWith<$Res> {
  factory $PostWriteStateCopyWith(
    PostWriteState value,
    $Res Function(PostWriteState) then,
  ) = _$PostWriteStateCopyWithImpl<$Res, PostWriteState>;
  @useResult
  $Res call({bool isLoading, String? error, bool? success});
}

/// @nodoc
class _$PostWriteStateCopyWithImpl<$Res, $Val extends PostWriteState>
    implements $PostWriteStateCopyWith<$Res> {
  _$PostWriteStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PostWriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? success = freezed,
  }) {
    return _then(
      _value.copyWith(
            isLoading: null == isLoading
                ? _value.isLoading
                : isLoading // ignore: cast_nullable_to_non_nullable
                      as bool,
            error: freezed == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as String?,
            success: freezed == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PostWriteStateImplCopyWith<$Res>
    implements $PostWriteStateCopyWith<$Res> {
  factory _$$PostWriteStateImplCopyWith(
    _$PostWriteStateImpl value,
    $Res Function(_$PostWriteStateImpl) then,
  ) = __$$PostWriteStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isLoading, String? error, bool? success});
}

/// @nodoc
class __$$PostWriteStateImplCopyWithImpl<$Res>
    extends _$PostWriteStateCopyWithImpl<$Res, _$PostWriteStateImpl>
    implements _$$PostWriteStateImplCopyWith<$Res> {
  __$$PostWriteStateImplCopyWithImpl(
    _$PostWriteStateImpl _value,
    $Res Function(_$PostWriteStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PostWriteState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isLoading = null,
    Object? error = freezed,
    Object? success = freezed,
  }) {
    return _then(
      _$PostWriteStateImpl(
        isLoading: null == isLoading
            ? _value.isLoading
            : isLoading // ignore: cast_nullable_to_non_nullable
                  as bool,
        error: freezed == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as String?,
        success: freezed == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc

class _$PostWriteStateImpl implements _PostWriteState {
  const _$PostWriteStateImpl({
    this.isLoading = false,
    this.error,
    this.success,
  });

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? error;
  @override
  final bool? success;

  @override
  String toString() {
    return 'PostWriteState(isLoading: $isLoading, error: $error, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostWriteStateImpl &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.success, success) || other.success == success));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isLoading, error, success);

  /// Create a copy of PostWriteState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PostWriteStateImplCopyWith<_$PostWriteStateImpl> get copyWith =>
      __$$PostWriteStateImplCopyWithImpl<_$PostWriteStateImpl>(
        this,
        _$identity,
      );
}

abstract class _PostWriteState implements PostWriteState {
  const factory _PostWriteState({
    final bool isLoading,
    final String? error,
    final bool? success,
  }) = _$PostWriteStateImpl;

  @override
  bool get isLoading;
  @override
  String? get error;
  @override
  bool? get success;

  /// Create a copy of PostWriteState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PostWriteStateImplCopyWith<_$PostWriteStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
