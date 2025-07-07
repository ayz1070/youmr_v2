import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// 요일별 참석자 조회 유스케이스
class GetAttendeesByDayUseCase {
  final AttendanceRepository repository;
  GetAttendeesByDayUseCase(this.repository);

  Stream<List<AttendanceEntity>> call(String weekKey, String day) {
    return repository.getAttendeesByDay(weekKey, day);
  }
} 