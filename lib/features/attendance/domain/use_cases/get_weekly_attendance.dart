import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 주간 출석 현황 조회 유즈케이스
/// - 특정 주차의 모든 사용자 출석 현황을 조회
/// - 주간 출석 통계 및 관리자 화면에서 사용
/// - 전체 참석자 현황 파악을 위한 데이터 제공
class GetWeeklyAttendance {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const GetWeeklyAttendance(this.repository);

  /// 주간 출석 현황 조회 실행
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// 
  /// 반환: 성공 시 전체 출석 목록, 실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - weekKey 형식 검증 (YYYY-WNN 형식)
  /// - Repository를 통한 주간 출석 데이터 조회
  /// - 결과 반환 (성공/실패 구분)
  Future<Either<AttendanceFailure, List<Attendance>>> call({
    required String weekKey,
  }) async {

    
    try {
      // Repository를 통한 주간 출석 데이터 조회
      final result = await repository.getWeeklyAttendance(
        weekKey: weekKey,
      );
      
      return result;
    } catch (e) {
      // 예상치 못한 예외 처리
      return Left(AttendanceUnknownFailure('주간 출석 현황 조회 중 오류가 발생했습니다: $e'));
    }
  }
}
