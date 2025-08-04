// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'push_notification_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PushNotificationDto _$PushNotificationDtoFromJson(Map<String, dynamic> json) {
  return _PushNotificationDto.fromJson(json);
}

/// @nodoc
mixin _$PushNotificationDto {
  /// 알림 ID
  String get id => throw _privateConstructorUsedError;

  /// 사용자 ID
  String get userId => throw _privateConstructorUsedError;

  /// 알림 제목
  String get title => throw _privateConstructorUsedError;

  /// 알림 내용
  String get body => throw _privateConstructorUsedError;

  /// 알림 타입 (attendance, monthly_fee, general)
  String get type => throw _privateConstructorUsedError;

  /// 추가 데이터
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// 생성 시간
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// 읽음 여부
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this PushNotificationDto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PushNotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PushNotificationDtoCopyWith<PushNotificationDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PushNotificationDtoCopyWith<$Res> {
  factory $PushNotificationDtoCopyWith(
          PushNotificationDto value, $Res Function(PushNotificationDto) then) =
      _$PushNotificationDtoCopyWithImpl<$Res, PushNotificationDto>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      Map<String, dynamic> data,
      DateTime createdAt,
      bool isRead});
}

/// @nodoc
class _$PushNotificationDtoCopyWithImpl<$Res, $Val extends PushNotificationDto>
    implements $PushNotificationDtoCopyWith<$Res> {
  _$PushNotificationDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PushNotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PushNotificationDtoImplCopyWith<$Res>
    implements $PushNotificationDtoCopyWith<$Res> {
  factory _$$PushNotificationDtoImplCopyWith(_$PushNotificationDtoImpl value,
          $Res Function(_$PushNotificationDtoImpl) then) =
      __$$PushNotificationDtoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String title,
      String body,
      String type,
      Map<String, dynamic> data,
      DateTime createdAt,
      bool isRead});
}

/// @nodoc
class __$$PushNotificationDtoImplCopyWithImpl<$Res>
    extends _$PushNotificationDtoCopyWithImpl<$Res, _$PushNotificationDtoImpl>
    implements _$$PushNotificationDtoImplCopyWith<$Res> {
  __$$PushNotificationDtoImplCopyWithImpl(_$PushNotificationDtoImpl _value,
      $Res Function(_$PushNotificationDtoImpl) _then)
      : super(_value, _then);

  /// Create a copy of PushNotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(_$PushNotificationDtoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isRead: null == isRead
          ? _value.isRead
          : isRead // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PushNotificationDtoImpl implements _PushNotificationDto {
  const _$PushNotificationDtoImpl(
      {required this.id,
      required this.userId,
      required this.title,
      required this.body,
      required this.type,
      final Map<String, dynamic> data = const {},
      required this.createdAt,
      this.isRead = false})
      : _data = data;

  factory _$PushNotificationDtoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PushNotificationDtoImplFromJson(json);

  /// 알림 ID
  @override
  final String id;

  /// 사용자 ID
  @override
  final String userId;

  /// 알림 제목
  @override
  final String title;

  /// 알림 내용
  @override
  final String body;

  /// 알림 타입 (attendance, monthly_fee, general)
  @override
  final String type;

  /// 추가 데이터
  final Map<String, dynamic> _data;

  /// 추가 데이터
  @override
  @JsonKey()
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  /// 생성 시간
  @override
  final DateTime createdAt;

  /// 읽음 여부
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'PushNotificationDto(id: $id, userId: $userId, title: $title, body: $body, type: $type, data: $data, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PushNotificationDtoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, title, body, type,
      const DeepCollectionEquality().hash(_data), createdAt, isRead);

  /// Create a copy of PushNotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PushNotificationDtoImplCopyWith<_$PushNotificationDtoImpl> get copyWith =>
      __$$PushNotificationDtoImplCopyWithImpl<_$PushNotificationDtoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PushNotificationDtoImplToJson(
      this,
    );
  }
}

abstract class _PushNotificationDto implements PushNotificationDto {
  const factory _PushNotificationDto(
      {required final String id,
      required final String userId,
      required final String title,
      required final String body,
      required final String type,
      final Map<String, dynamic> data,
      required final DateTime createdAt,
      final bool isRead}) = _$PushNotificationDtoImpl;

  factory _PushNotificationDto.fromJson(Map<String, dynamic> json) =
      _$PushNotificationDtoImpl.fromJson;

  /// 알림 ID
  @override
  String get id;

  /// 사용자 ID
  @override
  String get userId;

  /// 알림 제목
  @override
  String get title;

  /// 알림 내용
  @override
  String get body;

  /// 알림 타입 (attendance, monthly_fee, general)
  @override
  String get type;

  /// 추가 데이터
  @override
  Map<String, dynamic> get data;

  /// 생성 시간
  @override
  DateTime get createdAt;

  /// 읽음 여부
  @override
  bool get isRead;

  /// Create a copy of PushNotificationDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PushNotificationDtoImplCopyWith<_$PushNotificationDtoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
