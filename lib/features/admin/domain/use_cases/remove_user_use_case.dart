import '../repositories/admin_repository.dart';

/// 유저 삭제 유스케이스
class RemoveUserUseCase {
  final AdminRepository repository;
  RemoveUserUseCase(this.repository);

  Future<void> call(String uid) {
    return repository.removeUser(uid);
  }
} 