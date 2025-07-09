import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 요일별 참석자 조회 유즈케이스
class GetAttendeesByDay {
  final AttendanceRepository repository;
  const GetAttendeesByDay(this.repository);

  Stream<Either<AttendanceFailure, List<Attendance>>> call({required String weekKey, required String day}) {
    return repository.attendeesByDayStream(weekKey: weekKey, day: day);
  }
} 