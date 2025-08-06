import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance.freezed.dart';
part 'attendance.g.dart';

/// 출석 엔티티(불변, Freezed)
@freezed
class Attendance with _$Attendance {
  const factory Attendance({
    required String weekKey,
    required String userId,
    required List<String> selectedDays,
    required String name,
    required String profileImageUrl,
    DateTime? lastUpdated,
  }) = _Attendance;

  factory Attendance.fromJson(Map<String, dynamic> json) => _$AttendanceFromJson(json);
} 