import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_firestore_data_source.dart';

/// 프로필 저장소 구현체
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileFirestoreDataSource dataSource;
  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<ProfileEntity?> fetchProfile() => dataSource.fetchProfile();

  @override
  Future<void> updateProfile(ProfileEntity profile) => dataSource.updateProfile(profile);
} 