// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

AttendanceEntity _$AttendanceEntityFromJson(Map<String, dynamic> json) {
  return _AttendanceEntity.fromJson(json);
}

/// @nodoc
mixin _$AttendanceEntity {
  String get weekKey => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get profileImageUrl => throw _privateConstructorUsedError;
  List<String> get selectedDays => throw _privateConstructorUsedError;
  DateTime? get lastUpdated => throw _privateConstructorUsedError;

  /// Serializes this AttendanceEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AttendanceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AttendanceEntityCopyWith<AttendanceEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttendanceEntityCopyWith<$Res> {
  factory $AttendanceEntityCopyWith(
    AttendanceEntity value,
    $Res Function(AttendanceEntity) then,
  ) = _$AttendanceEntityCopyWithImpl<$Res, AttendanceEntity>;
  @useResult
  $Res call({
    String weekKey,
    String userId,
    String nickname,
    String profileImageUrl,
    List<String> selectedDays,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class _$AttendanceEntityCopyWithImpl<$Res, $Val extends AttendanceEntity>
    implements $AttendanceEntityCopyWith<$Res> {
  _$AttendanceEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AttendanceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekKey = null,
    Object? userId = null,
    Object? nickname = null,
    Object? profileImageUrl = null,
    Object? selectedDays = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _value.copyWith(
            weekKey: null == weekKey
                ? _value.weekKey
                : weekKey // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            nickname: null == nickname
                ? _value.nickname
                : nickname // ignore: cast_nullable_to_non_nullable
                      as String,
            profileImageUrl: null == profileImageUrl
                ? _value.profileImageUrl
                : profileImageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            selectedDays: null == selectedDays
                ? _value.selectedDays
                : selectedDays // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            lastUpdated: freezed == lastUpdated
                ? _value.lastUpdated
                : lastUpdated // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AttendanceEntityImplCopyWith<$Res>
    implements $AttendanceEntityCopyWith<$Res> {
  factory _$$AttendanceEntityImplCopyWith(
    _$AttendanceEntityImpl value,
    $Res Function(_$AttendanceEntityImpl) then,
  ) = __$$AttendanceEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String weekKey,
    String userId,
    String nickname,
    String profileImageUrl,
    List<String> selectedDays,
    DateTime? lastUpdated,
  });
}

/// @nodoc
class __$$AttendanceEntityImplCopyWithImpl<$Res>
    extends _$AttendanceEntityCopyWithImpl<$Res, _$AttendanceEntityImpl>
    implements _$$AttendanceEntityImplCopyWith<$Res> {
  __$$AttendanceEntityImplCopyWithImpl(
    _$AttendanceEntityImpl _value,
    $Res Function(_$AttendanceEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AttendanceEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weekKey = null,
    Object? userId = null,
    Object? nickname = null,
    Object? profileImageUrl = null,
    Object? selectedDays = null,
    Object? lastUpdated = freezed,
  }) {
    return _then(
      _$AttendanceEntityImpl(
        weekKey: null == weekKey
            ? _value.weekKey
            : weekKey // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        nickname: null == nickname
            ? _value.nickname
            : nickname // ignore: cast_nullable_to_non_nullable
                  as String,
        profileImageUrl: null == profileImageUrl
            ? _value.profileImageUrl
            : profileImageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        selectedDays: null == selectedDays
            ? _value._selectedDays
            : selectedDays // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        lastUpdated: freezed == lastUpdated
            ? _value.lastUpdated
            : lastUpdated // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AttendanceEntityImpl implements _AttendanceEntity {
  const _$AttendanceEntityImpl({
    required this.weekKey,
    required this.userId,
    required this.nickname,
    required this.profileImageUrl,
    required final List<String> selectedDays,
    this.lastUpdated,
  }) : _selectedDays = selectedDays;

  factory _$AttendanceEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttendanceEntityImplFromJson(json);

  @override
  final String weekKey;
  @override
  final String userId;
  @override
  final String nickname;
  @override
  final String profileImageUrl;
  final List<String> _selectedDays;
  @override
  List<String> get selectedDays {
    if (_selectedDays is EqualUnmodifiableListView) return _selectedDays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedDays);
  }

  @override
  final DateTime? lastUpdated;

  @override
  String toString() {
    return 'AttendanceEntity(weekKey: $weekKey, userId: $userId, nickname: $nickname, profileImageUrl: $profileImageUrl, selectedDays: $selectedDays, lastUpdated: $lastUpdated)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttendanceEntityImpl &&
            (identical(other.weekKey, weekKey) || other.weekKey == weekKey) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality().equals(
              other._selectedDays,
              _selectedDays,
            ) &&
            (identical(other.lastUpdated, lastUpdated) ||
                other.lastUpdated == lastUpdated));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    weekKey,
    userId,
    nickname,
    profileImageUrl,
    const DeepCollectionEquality().hash(_selectedDays),
    lastUpdated,
  );

  /// Create a copy of AttendanceEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AttendanceEntityImplCopyWith<_$AttendanceEntityImpl> get copyWith =>
      __$$AttendanceEntityImplCopyWithImpl<_$AttendanceEntityImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AttendanceEntityImplToJson(this);
  }
}

abstract class _AttendanceEntity implements AttendanceEntity {
  const factory _AttendanceEntity({
    required final String weekKey,
    required final String userId,
    required final String nickname,
    required final String profileImageUrl,
    required final List<String> selectedDays,
    final DateTime? lastUpdated,
  }) = _$AttendanceEntityImpl;

  factory _AttendanceEntity.fromJson(Map<String, dynamic> json) =
      _$AttendanceEntityImpl.fromJson;

  @override
  String get weekKey;
  @override
  String get userId;
  @override
  String get nickname;
  @override
  String get profileImageUrl;
  @override
  List<String> get selectedDays;
  @override
  DateTime? get lastUpdated;

  /// Create a copy of AttendanceEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AttendanceEntityImplCopyWith<_$AttendanceEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
