import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 요일별 참석자 목록 조회 유즈케이스
/// - 특정 주차와 요일에 출석을 선택한 사용자들의 목록을 실시간으로 조회
/// - Stream을 통한 실시간 데이터 업데이트 제공
/// - Repository 계층의 스트림 데이터를 도메인 엔티티로 변환
class GetAttendeesByDay {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const GetAttendeesByDay(this.repository);

  /// 요일별 참석자 목록 조회 실행
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// [day] 조회할 요일 (예: "월", "화", "수")
  /// 
  /// 반환: 성공 시 참석자 목록 스트림, 실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - weekKey 형식 검증 (YYYY-WNN 형식)
  /// - 요일 유효성 검사 (유효한 요일명인지)
  /// - Repository를 통한 스트림 데이터 조회
  /// - 실시간 업데이트를 위한 Stream 반환
  Stream<Either<AttendanceFailure, List<Attendance>>> call({
    required String weekKey, 
    required String day
  }) {

    try {
      // Repository를 통한 스트림 데이터 조회
      return repository.attendeesByDayStream(
        weekKey: weekKey, 
        day: day
      );
    } catch (e) {
      // 예상치 못한 예외 처리
      return Stream.value(Left(AttendanceUnknownFailure('참석자 목록 조회 중 오류가 발생했습니다: $e')));
    }
  }
} 