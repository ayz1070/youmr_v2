import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// 프로필 저장 유스케이스
class SaveProfileUseCase {
  final AuthRepository repository;
  SaveProfileUseCase(this.repository);

  Future<void> call(UserEntity user) {
    return repository.saveProfile(user);
  }
} 