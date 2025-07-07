import '../../domain/entities/attendance_entity.dart';
import '../../domain/repositories/attendance_repository.dart';
import '../data_sources/attendance_firestore_data_source.dart';

/// 출석 관련 리포지토리 구현체
class AttendanceRepositoryImpl implements AttendanceRepository {
  final AttendanceFirestoreDataSource _dataSource;
  AttendanceRepositoryImpl(this._dataSource);

  @override
  Future<AttendanceEntity?> getMyAttendance(String weekKey, String userId) {
    return _dataSource.fetchMyAttendance(weekKey, userId);
  }

  @override
  Future<void> saveAttendance(AttendanceEntity entity) {
    return _dataSource.saveAttendance(entity);
  }

  @override
  Stream<List<AttendanceEntity>> getAttendeesByDay(String weekKey, String day) {
    return _dataSource.attendeesByDay(weekKey, day);
  }
} 