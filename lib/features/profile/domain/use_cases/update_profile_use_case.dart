import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// 내 프로필 수정 유스케이스
class UpdateProfileUseCase {
  final ProfileRepository repository;
  UpdateProfileUseCase(this.repository);

  Future<void> call(ProfileEntity profile) {
    return repository.updateProfile(profile);
  }
} 