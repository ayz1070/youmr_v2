import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/attendance.dart';

part 'attendance_dto.freezed.dart';
part 'attendance_dto.g.dart';

/// 출석 DTO (Firestore <-> Domain 변환)
@freezed
class AttendanceDto with _$AttendanceDto {
  const factory AttendanceDto({
    /// 주차 키
    required String weekKey,
    /// 유저 고유 ID
    required String userId,
    /// 선택한 요일 리스트
    required List<String> selectedDays,
    /// 실명
    required String name,
    /// 프로필 이미지 URL
    required String profileImageUrl,
    /// 마지막 업데이트 시각
    @JsonKey(name: 'last_updated', fromJson: _fromTimestamp, toJson: _toTimestamp)
    DateTime? lastUpdated,
  }) = _AttendanceDto;

  factory AttendanceDto.fromJson(Map<String, dynamic> json) => _$AttendanceDtoFromJson(json);

  /// 도메인 → DTO 변환
  factory AttendanceDto.fromDomain(Attendance attendance) => AttendanceDto(
    weekKey: attendance.weekKey,
    userId: attendance.userId,
    selectedDays: attendance.selectedDays,
    name: attendance.name,
    profileImageUrl: attendance.profileImageUrl,
    lastUpdated: attendance.lastUpdated,
  );
}

/// DTO → 도메인 변환 확장
extension AttendanceDtoX on AttendanceDto {
  Attendance toDomain() => Attendance(
    weekKey: weekKey,
    userId: userId,
    selectedDays: selectedDays,
    name: name,
    profileImageUrl: profileImageUrl,
    lastUpdated: lastUpdated,
  );
}

/// Firestore Timestamp → DateTime 변환
DateTime? _fromTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

/// DateTime → Firestore Timestamp 변환
Object? _toTimestamp(DateTime? value) {
  if (value == null) return null;
  return Timestamp.fromDate(value);
} 