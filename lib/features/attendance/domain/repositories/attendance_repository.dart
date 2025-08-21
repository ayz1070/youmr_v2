import 'package:dartz/dartz.dart';
import '../../../../core/errors/attendance_failure.dart';
import '../entities/attendance.dart';

/// 출석 관련 Repository 인터페이스
/// - 출석 데이터의 CRUD 작업을 담당하는 추상화 계층
/// - 도메인 계층과 데이터 계층 간의 의존성 역전을 구현
/// - 함수형 에러 처리(Either)를 통해 성공/실패를 명확히 구분
abstract class AttendanceRepository {
  /// 내 출석 정보 조회
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// [userId] 조회할 사용자 ID
  /// 
  /// 반환: 성공 시 출석 정보 또는 null (데이터 없음), 
  ///       실패 시 [AttendanceFailure]
  Future<Either<AttendanceFailure, Attendance?>> getMyAttendance({
    required String weekKey,
    required String userId,
  });

  /// 내 출석 정보 저장/수정
  /// 
  /// [attendance] 저장할 출석 정보 객체
  /// 
  /// 반환: 성공 시 void, 실패 시 [AttendanceFailure]
  /// 
  /// 주의사항: 
  /// - 기존 데이터가 있으면 업데이트, 없으면 새로 생성
  /// - attendance 객체의 유효성 검사는 호출자에서 수행
  Future<Either<AttendanceFailure, void>> saveMyAttendance({
    required Attendance attendance,
  });

  /// 요일별 참석자 목록 실시간 스트림
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// [day] 조회할 요일 (예: "월", "화", "수")
  /// 
  /// 반환: 성공 시 참석자 목록 스트림, 실패 시 [AttendanceFailure]
  /// 
  /// 특징:
  /// - 실시간 업데이트를 위한 Stream 반환
  /// - Firestore 문서 변경 시 자동으로 새로운 데이터 전달
  Stream<Either<AttendanceFailure, List<Attendance>>> 
      attendeesByDayStream({
    required String weekKey,
    required String day,
  });

  /// 현재 사용자 프로필 정보 조회
  /// 
  /// 반환: 성공 시 (이름, 프로필이미지URL) 튜플, 
  ///       실패 시 [AttendanceFailure]
  /// 
  /// 용도:
  /// - 출석 정보 저장 시 사용자 이름과 프로필 이미지 정보 제공
  /// - UI에서 사용자 정보 표시
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> 
      getCurrentUserProfile();

  /// 특정 주차의 전체 출석 현황 조회
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// 
  /// 반환: 성공 시 전체 출석 목록, 실패 시 [AttendanceFailure]
  /// 
  /// 용도:
  /// - 주간 출석 통계 및 관리자 화면에서 사용
  /// - 전체 참석자 현황 파악
  Future<Either<AttendanceFailure, List<Attendance>>> 
      getWeeklyAttendance({
    required String weekKey,
  });

  /// 사용자별 출석 이력 조회
  /// 
  /// [userId] 조회할 사용자 ID
  /// [limit] 조회할 최대 기록 수 (기본값: 10)
  /// 
  /// 반환: 성공 시 출석 이력 목록, 실패 시 [AttendanceFailure]
  /// 
  /// 용도:
  /// - 사용자별 출석 패턴 분석
  /// - 개인 출석 통계 제공
  Future<Either<AttendanceFailure, List<Attendance>>> 
      getUserAttendanceHistory({
    required String userId,
    int limit = 10,
  });

  /// 출석 데이터 삭제
  /// 
  /// [weekKey] 삭제할 주차 식별자
  /// [userId] 삭제할 사용자 ID
  /// 
  /// 반환: 성공 시 void, 실패 시 [AttendanceFailure]
  /// 
  /// 주의사항:
  /// - 관리자 권한이 있는 사용자만 호출 가능
  /// - 삭제된 데이터는 복구할 수 없음
  Future<Either<AttendanceFailure, void>> deleteAttendance({
    required String weekKey,
    required String userId,
  });
} 