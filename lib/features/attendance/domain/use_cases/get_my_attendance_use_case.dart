import '../entities/attendance_entity.dart';
import '../repositories/attendance_repository.dart';

/// 내 출석 정보 불러오기 유스케이스
class GetMyAttendanceUseCase {
  final AttendanceRepository repository;
  GetMyAttendanceUseCase(this.repository);

  Future<AttendanceEntity?> call(String weekKey, String userId) {
    return repository.getMyAttendance(weekKey, userId);
  }
} 