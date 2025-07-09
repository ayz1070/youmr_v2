import 'package:dartz/dartz.dart';
import '../../../../core/errors/attendance_failure.dart';
import '../entities/attendance.dart';

/// 출석 관련 Repository 인터페이스
abstract class AttendanceRepository {
  /// 내 출석 정보 불러오기
  Future<Either<AttendanceFailure, Attendance?>> getMyAttendance({required String weekKey, required String userId});

  /// 내 출석 정보 저장
  Future<Either<AttendanceFailure, void>> saveMyAttendance({required Attendance attendance});

  /// 요일별 참석자 스트림
  Stream<Either<AttendanceFailure, List<Attendance>>> attendeesByDayStream({required String weekKey, required String day});
} 