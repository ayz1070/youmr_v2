import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendee.freezed.dart';
part 'attendee.g.dart';

/// 참석자 엔티티(불변, Freezed)
@freezed
class Attendee with _$Attendee {
  const factory Attendee({
    required String userId,
    required String nickname,
    required String profileImageUrl,
  }) = _Attendee;

  factory Attendee.fromJson(Map<String, dynamic> json) => _$AttendeeFromJson(json);
} 