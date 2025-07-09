import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 내 출석 정보 저장 유즈케이스
class SaveMyAttendance {
  final AttendanceRepository repository;
  const SaveMyAttendance(this.repository);

  Future<Either<AttendanceFailure, void>> call({required Attendance attendance}) {
    return repository.saveMyAttendance(attendance: attendance);
  }
} 