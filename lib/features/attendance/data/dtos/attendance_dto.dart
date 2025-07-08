import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/attendance.dart';

part 'attendance_dto.freezed.dart';
part 'attendance_dto.g.dart';

/// 출석 DTO (Firestore ↔️ Domain 변환)
@freezed
class AttendanceDto with _$AttendanceDto {
  const factory AttendanceDto({
    required String weekKey,
    required String userId,
    required List<String> selectedDays,
    required String nickname,
    required String profileImageUrl,
    @JsonKey(name: 'lastUpdated', fromJson: _fromTimestamp, toJson: _toTimestamp)
    DateTime? lastUpdated,
  }) = _AttendanceDto;

  factory AttendanceDto.fromJson(Map<String, dynamic> json) => _$AttendanceDtoFromJson(json);

  factory AttendanceDto.fromDomain(Attendance attendance) => AttendanceDto(
    weekKey: attendance.weekKey,
    userId: attendance.userId,
    selectedDays: attendance.selectedDays,
    nickname: attendance.nickname,
    profileImageUrl: attendance.profileImageUrl,
    lastUpdated: attendance.lastUpdated,
  );
}

/// AttendanceDto → Attendance 변환 확장
extension AttendanceDtoX on AttendanceDto {
  Attendance toDomain() => Attendance(
    weekKey: weekKey,
    userId: userId,
    selectedDays: selectedDays,
    nickname: nickname,
    profileImageUrl: profileImageUrl,
    lastUpdated: lastUpdated,
  );
}

DateTime? _fromTimestamp(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is Timestamp) return value.toDate();
  return null;
}

dynamic _toTimestamp(DateTime? value) => value; 