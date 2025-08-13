import 'package:dartz/dartz.dart';
import '../entities/attendance.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 내 출석 정보 조회 유즈케이스
/// - 특정 주차에 대한 현재 사용자의 출석 정보를 조회
/// - 사용자가 해당 주차에 출석 정보를 등록하지 않은 경우 null 반환
/// - Repository 계층의 에러를 그대로 전달하여 함수형 에러 처리
class GetMyAttendance {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const GetMyAttendance(this.repository);

  /// 내 출석 정보 조회 실행
  /// 
  /// [weekKey] 조회할 주차 식별자 (예: "2024-W01")
  /// [userId] 조회할 사용자 ID
  /// 
  /// 반환: 성공 시 출석 정보 또는 null (데이터 없음), 
  ///       실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - weekKey 형식 검증 (YYYY-WNN 형식)
  /// - userId 유효성 검사 (빈 문자열이 아닌지)
  /// - Repository를 통한 데이터 조회
  /// - 결과 반환 (성공/실패 구분)
  Future<Either<AttendanceFailure, Attendance?>> call({
    required String weekKey, 
    required String userId
  }) async {

    try {
      // Repository를 통한 데이터 조회
      final result = await repository.getMyAttendance(
        weekKey: weekKey, 
        userId: userId
      );
      
      return result;
    } catch (e) {
      // 예상치 못한 예외 처리
      return Left(AttendanceUnknownFailure('출석 정보 조회 중 오류가 발생했습니다: $e'));
    }
  }
} 