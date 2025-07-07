import '../entities/user_entity.dart';

/// 인증 관련 리포지토리 인터페이스
abstract class AuthRepository {
  /// 구글 로그인 및 유저 정보 반환
  Future<UserEntity> signInWithGoogle();

  /// 프로필 정보 저장
  Future<void> saveProfile(UserEntity user);

  /// 인증 및 프로필 정보 체크(분기용)
  Future<AuthCheckResult> checkAuthAndProfile();
}

/// 인증/프로필 체크 결과
enum AuthCheckResult {
  notLoggedIn,
  needProfile,
  success,
} 