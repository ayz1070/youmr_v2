import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// 출석 정보 저장 유스케이스
class SaveAttendanceUseCase {
  final AttendanceRepository repository;
  SaveAttendanceUseCase(this.repository);

  Future<void> call(AttendanceEntity entity) {
    return repository.saveAttendance(entity);
  }
} 