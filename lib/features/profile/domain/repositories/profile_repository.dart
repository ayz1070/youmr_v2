import '../entities/profile_entity.dart';

/// 프로필 기능 추상 저장소
abstract class ProfileRepository {
  /// 내 프로필 조회
  Future<ProfileEntity?> fetchProfile();

  /// 내 프로필 수정
  Future<void> updateProfile(ProfileEntity profile);
} 