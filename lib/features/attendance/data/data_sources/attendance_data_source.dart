import '../dtos/attendance_dto.dart';

/// 출석 데이터 소스 인터페이스
/// - 외부 데이터(Firestore)와의 통신만 담당
/// - 예외 가공/로깅/Failure 변환 금지
/// - DTO 기반 타입 안전한 데이터 처리
abstract class AttendanceDataSource {
  /// 내 출석 정보 불러오기
  /// 
  /// [weekKey] 주차 키 (예: 2024_01)
  /// [userId] 사용자 고유 ID
  /// 
  /// 반환: 출석 DTO 또는 null (데이터가 없는 경우)
  /// 예외: Firestore 관련 예외를 그대로 throw
  Future<AttendanceDto?> fetchMyAttendance({
    required String weekKey,
    required String userId,
  });

  /// 내 출석 정보 저장
  /// 
  /// [weekKey] 주차 키 (예: 2024_01)
  /// [userId] 사용자 고유 ID
  /// [data] 저장할 출석 데이터
  /// 
  /// 예외: Firestore 관련 예외를 그대로 throw
  Future<void> saveMyAttendance({
    required String weekKey,
    required String userId,
    required AttendanceDto data,
  });

  /// 요일별 참석자 스트림 반환
  /// 
  /// [weekKey] 주차 키 (예: 2024_01)
  /// [day] 요일 (예: '월', '화', '수')
  /// 
  /// 반환: 해당 요일 참석자 목록 스트림
  /// 예외: Firestore 관련 예외를 그대로 throw
  Stream<List<AttendanceDto>> attendeesByDayStream({
    required String weekKey,
    required String day,
  });

  /// 유저 정보 불러오기
  /// 
  /// [userId] 사용자 고유 ID
  /// 
  /// 반환: 사용자 데이터 맵 또는 null (사용자가 없는 경우)
  /// 예외: Firestore 관련 예외를 그대로 throw
  Future<Map<String, dynamic>?> fetchUserData(String userId);
}
