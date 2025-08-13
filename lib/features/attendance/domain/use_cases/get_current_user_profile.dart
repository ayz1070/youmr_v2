import 'package:dartz/dartz.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 현재 사용자 프로필 정보 조회 유즈케이스
/// - 현재 로그인한 사용자의 이름과 프로필 이미지 URL을 조회
/// - 출석 정보 저장 시 필요한 사용자 기본 정보 제공
/// - Repository 계층을 통한 사용자 프로필 데이터 접근
class GetCurrentUserProfile {
  /// 출석 데이터 접근을 위한 Repository 의존성
  final AttendanceRepository repository;
  
  /// 생성자
  /// [repository] 출석 Repository 의존성 주입
  const GetCurrentUserProfile(this.repository);

  /// 현재 사용자 프로필 정보 조회 실행
  /// 
  /// 반환: 성공 시 (이름, 프로필이미지URL) 튜플, 
  ///       실패 시 [AttendanceFailure]
  /// 
  /// 비즈니스 로직:
  /// - Repository를 통한 사용자 프로필 정보 조회
  /// - 사용자 인증 상태 확인 (Firebase Auth)
  /// - 프로필 데이터 유효성 검사
  /// - 결과 반환 (성공/실패 구분)
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> 
      call() async {
    try {
      // Repository를 통한 사용자 프로필 정보 조회
      final result = await repository.getCurrentUserProfile();
      
      return result;
    } catch (e) {
      // 예상치 못한 예외 처리
      return Left(AttendanceUnknownFailure('사용자 프로필 정보 조회 중 오류가 발생했습니다: $e'));
    }
  }
} 