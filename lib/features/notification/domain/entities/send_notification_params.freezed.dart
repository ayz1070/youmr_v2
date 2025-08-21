// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_notification_params.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SendNotificationParams {
  /// 알림 제목
  String get title => throw _privateConstructorUsedError;

  /// 알림 내용
  String get body => throw _privateConstructorUsedError;

  /// 알림 타입
  String get type => throw _privateConstructorUsedError;

  /// 대상 사용자 ID 리스트 (빈 리스트면 모든 사용자)
  List<String> get userIds => throw _privateConstructorUsedError;

  /// 추가 데이터
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  /// 이미지 URL (선택사항)
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of SendNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SendNotificationParamsCopyWith<SendNotificationParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendNotificationParamsCopyWith<$Res> {
  factory $SendNotificationParamsCopyWith(SendNotificationParams value,
          $Res Function(SendNotificationParams) then) =
      _$SendNotificationParamsCopyWithImpl<$Res, SendNotificationParams>;
  @useResult
  $Res call(
      {String title,
      String body,
      String type,
      List<String> userIds,
      Map<String, dynamic> data,
      String? imageUrl});
}

/// @nodoc
class _$SendNotificationParamsCopyWithImpl<$Res,
        $Val extends SendNotificationParams>
    implements $SendNotificationParamsCopyWith<$Res> {
  _$SendNotificationParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SendNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? userIds = null,
    Object? data = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
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
      userIds: null == userIds
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SendNotificationParamsImplCopyWith<$Res>
    implements $SendNotificationParamsCopyWith<$Res> {
  factory _$$SendNotificationParamsImplCopyWith(
          _$SendNotificationParamsImpl value,
          $Res Function(_$SendNotificationParamsImpl) then) =
      __$$SendNotificationParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      String body,
      String type,
      List<String> userIds,
      Map<String, dynamic> data,
      String? imageUrl});
}

/// @nodoc
class __$$SendNotificationParamsImplCopyWithImpl<$Res>
    extends _$SendNotificationParamsCopyWithImpl<$Res,
        _$SendNotificationParamsImpl>
    implements _$$SendNotificationParamsImplCopyWith<$Res> {
  __$$SendNotificationParamsImplCopyWithImpl(
      _$SendNotificationParamsImpl _value,
      $Res Function(_$SendNotificationParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of SendNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? userIds = null,
    Object? data = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$SendNotificationParamsImpl(
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
      userIds: null == userIds
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendNotificationParamsImpl implements _SendNotificationParams {
  const _$SendNotificationParamsImpl(
      {required this.title,
      required this.body,
      this.type = 'general',
      final List<String> userIds = const [],
      final Map<String, dynamic> data = const {},
      this.imageUrl})
      : _userIds = userIds,
        _data = data;

  /// 알림 제목
  @override
  final String title;

  /// 알림 내용
  @override
  final String body;

  /// 알림 타입
  @override
  @JsonKey()
  final String type;

  /// 대상 사용자 ID 리스트 (빈 리스트면 모든 사용자)
  final List<String> _userIds;

  /// 대상 사용자 ID 리스트 (빈 리스트면 모든 사용자)
  @override
  @JsonKey()
  List<String> get userIds {
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

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

  /// 이미지 URL (선택사항)
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'SendNotificationParams(title: $title, body: $body, type: $type, userIds: $userIds, data: $data, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendNotificationParamsImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      body,
      type,
      const DeepCollectionEquality().hash(_userIds),
      const DeepCollectionEquality().hash(_data),
      imageUrl);

  /// Create a copy of SendNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SendNotificationParamsImplCopyWith<_$SendNotificationParamsImpl>
      get copyWith => __$$SendNotificationParamsImplCopyWithImpl<
          _$SendNotificationParamsImpl>(this, _$identity);
}

abstract class _SendNotificationParams implements SendNotificationParams {
  const factory _SendNotificationParams(
      {required final String title,
      required final String body,
      final String type,
      final List<String> userIds,
      final Map<String, dynamic> data,
      final String? imageUrl}) = _$SendNotificationParamsImpl;

  /// 알림 제목
  @override
  String get title;

  /// 알림 내용
  @override
  String get body;

  /// 알림 타입
  @override
  String get type;

  /// 대상 사용자 ID 리스트 (빈 리스트면 모든 사용자)
  @override
  List<String> get userIds;

  /// 추가 데이터
  @override
  Map<String, dynamic> get data;

  /// 이미지 URL (선택사항)
  @override
  String? get imageUrl;

  /// Create a copy of SendNotificationParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SendNotificationParamsImplCopyWith<_$SendNotificationParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}
