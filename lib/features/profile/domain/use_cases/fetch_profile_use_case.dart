import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

/// 내 프로필 조회 유스케이스
class FetchProfileUseCase {
  final ProfileRepository repository;
  FetchProfileUseCase(this.repository);

  Future<ProfileEntity?> call() {
    return repository.fetchProfile();
  }
} 