import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 내 출석 정보 조회 유즈케이스
class GetMyAttendance {
  final AttendanceRepository repository;
  const GetMyAttendance(this.repository);

  Future<Either<AttendanceFailure, Attendance?>> call({required String weekKey, required String userId}) {
    return repository.getMyAttendance(weekKey: weekKey, userId: userId);
  }
} 