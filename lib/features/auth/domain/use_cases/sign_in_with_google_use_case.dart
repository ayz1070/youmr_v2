import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// 구글 로그인 유스케이스
class SignInWithGoogleUseCase {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  Future<UserEntity> call() {
    return repository.signInWithGoogle();
  }
} 