import 'package:dartz/dartz.dart';
import '../repositories/attendance_repository.dart';
import '../../../../core/errors/attendance_failure.dart';

/// 현재 사용자 프로필 정보 조회 유즈케이스
/// - 현재 로그인한 사용자의 이름과 프로필 이미지 URL을 반환
class GetCurrentUserProfile {
  /// 출석 레포지토리
  final AttendanceRepository repository;

  /// [repository]: 출석 레포지토리 DI
  const GetCurrentUserProfile(this.repository);

  /// 현재 사용자 프로필 정보 조회 실행
  /// 반환: 성공 시 (이름, 프로필이미지URL), 실패 시 [AttendanceFailure]
  Future<Either<AttendanceFailure, (String name, String profileImageUrl)>> call() {
    return repository.getCurrentUserProfile();
  }
} 