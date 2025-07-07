import '../repositories/admin_repository.dart';

/// 유저 권한 변경 유스케이스
class ChangeUserTypeUseCase {
  final AdminRepository repository;
  ChangeUserTypeUseCase(this.repository);

  Future<void> call(String uid, String newType) {
    return repository.changeUserType(uid, newType);
  }
} 