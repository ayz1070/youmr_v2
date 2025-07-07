import '../entities/attendance_entity.dart';

/// 출석 관련 리포지토리 인터페이스
abstract class AttendanceRepository {
  /// 내 출석 정보 불러오기
  Future<AttendanceEntity?> getMyAttendance(String weekKey, String userId);

  /// 출석 정보 저장
  Future<void> saveAttendance(AttendanceEntity entity);

  /// 요일별 참석자 스트림
  Stream<List<AttendanceEntity>> getAttendeesByDay(String weekKey, String day);
} 