import '../repositories/admin_user_repository.dart';

/// 회원 권한 변경 유즈케이스
class ChangeUserType {
  final AdminUserRepository repository;
  const ChangeUserType(this.repository);

  Future<void> call({required String uid, required String newType}) {
    return repository.changeUserType(uid: uid, newType: newType);
  }
} 