import '../entities/admin_user_entity.dart';
import '../repositories/admin_repository.dart';

/// 관리자 유저 목록 조회 유스케이스
class FetchAdminUsersUseCase {
  final AdminRepository repository;
  FetchAdminUsersUseCase(this.repository);

  Future<List<AdminUserEntity>> call() {
    return repository.fetchUsers();
  }
} 