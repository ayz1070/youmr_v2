import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_entity.freezed.dart';
part 'attendance_entity.g.dart';

/// 출석 정보 도메인 엔티티
@freezed
class AttendanceEntity with _$AttendanceEntity {
  /// [weekKey] : 연도-주차 (예: 2024-23)
  /// [userId] : 유저 고유 ID
  /// [nickname] : 유저 닉네임
  /// [profileImageUrl] : 프로필 이미지 URL
  /// [selectedDays] : 선택한 요일 리스트
  /// [lastUpdated] : 마지막 업데이트 시간
  const factory AttendanceEntity({
    required String weekKey,
    required String userId,
    required String nickname,
    required String profileImageUrl,
    required List<String> selectedDays,
    DateTime? lastUpdated,
  }) = _AttendanceEntity;

  factory AttendanceEntity.fromJson(Map<String, dynamic> json) => _$AttendanceEntityFromJson(json);
} 