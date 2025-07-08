import '../repositories/admin_user_repository.dart';

/// 회원 삭제 유즈케이스
class RemoveUser {
  final AdminUserRepository repository;
  const RemoveUser(this.repository);

  Future<void> call({required String uid}) {
    return repository.removeUser(uid: uid);
  }
} 