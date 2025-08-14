import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 사용자 출석 이력 조회 유즈케이스
/// - 특정 사용자의 출석 이력을 조회하여 출석 패턴 분석
/// - 개인 출석 통계 및 이력 관리 기능 제공
/// - 사용자별 출석 데이터의 시간적 변화 추적
class GetUserAttendanceHistory {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const GetUserAttendanceHistory(this.repository);

  /// 사용자 출석 이력 조회 실행
  /// 
  /// [userId] 조회할 사용자 ID
  /// [limit] 조회할 최대 기록 수 (기본값: 10)
  /// 
  /// 반환: 성공 시 출석 이력 목록, 실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - userId 유효성 검사 (빈 문자열이 아닌지)
  /// - limit 범위 검증 (1-100 사이의 값)
  /// - Repository를 통한 사용자 출석 이력 조회
  /// - 결과 반환 (성공/실패 구분)
  Future<Either<AttendanceFailure, List<Attendance>>> call({
    required String userId,
    int limit = 10,
  }) async {

    try {
      // Repository를 통한 사용자 출석 이력 조회
      final result = await repository.getUserAttendanceHistory(
        userId: userId,
        limit: limit,
      );
      
      return result;
    } catch (e) {
      // 예상치 못한 예외 처리
      return Left(AttendanceUnknownFailure('사용자 출석 이력 조회 중 오류가 발생했습니다: $e'));
    }
  }
}
