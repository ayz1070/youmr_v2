import '../repositories/auth_repository.dart';

/// 인증 및 프로필 체크 유스케이스
class CheckAuthAndProfileUseCase {
  final AuthRepository repository;
  CheckAuthAndProfileUseCase(this.repository);

  Future<AuthCheckResult> call() {
    return repository.checkAuthAndProfile();
  }
} 