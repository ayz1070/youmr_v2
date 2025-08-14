import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 출석 데이터 삭제 유즈케이스
/// - 특정 주차의 사용자 출석 데이터를 삭제
/// - 관리자 권한이 있는 사용자만 호출 가능
/// - 삭제된 데이터는 복구할 수 없음
class DeleteAttendance {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const DeleteAttendance(this.repository);

  /// 출석 데이터 삭제 실행
  /// 
  /// [weekKey] 삭제할 주차 식별자
  /// [userId] 삭제할 사용자 ID
  /// 
  /// 반환: 성공 시 void, 실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - weekKey 형식 검증 (YYYY-WNN 형식)
  /// - userId 유효성 검사 (빈 문자열이 아닌지)
  /// - 관리자 권한 확인 (호출자에서 검증)
  /// - Repository를 통한 출석 데이터 삭제
  /// - 결과 반환 (성공/실패 구분)
  Future<Either<AttendanceFailure, void>> call({
    required String weekKey,
    required String userId,
  }) async {
    

    try {
      // Repository를 통한 출석 데이터 삭제
      final result = await repository.deleteAttendance(
        weekKey: weekKey,
        userId: userId,
      );
      
      return result;
    } catch (e) {
      // 예상치 못한 예외 처리
      return Left(AttendanceUnknownFailure('출석 데이터 삭제 중 오류가 발생했습니다: $e'));
    }
  }
}
