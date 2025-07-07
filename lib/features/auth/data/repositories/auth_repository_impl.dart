import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_firebase_data_source.dart';
import '../dtos/user_dto.dart';

/// 인증 관련 리포지토리 구현체
class AuthRepositoryImpl implements AuthRepository {
  final AuthFirebaseDataSource _dataSource;
  AuthRepositoryImpl(this._dataSource);

  @override
  Future<UserEntity> signInWithGoogle() async {
    final dto = await _dataSource.signInWithGoogle();
    return dto.toEntity();
  }

  @override
  Future<void> saveProfile(UserEntity user) async {
    final dto = UserDTO.fromEntity(user);
    await _dataSource.saveProfile(dto);
  }

  @override
  Future<AuthCheckResult> checkAuthAndProfile() async {
    final profile = await _dataSource.getCurrentUserProfile();
    if (profile == null) return AuthCheckResult.notLoggedIn;
    final hasProfile = (profile['nickname'] ?? '').toString().trim().isNotEmpty &&
        (profile['userType'] ?? '').toString().trim().isNotEmpty;
    if (!hasProfile) return AuthCheckResult.needProfile;
    return AuthCheckResult.success;
  }
} 