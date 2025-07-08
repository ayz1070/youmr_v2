import '../entities/admin_user.dart';
import '../repositories/admin_user_repository.dart';

/// 전체 회원 목록 조회 유즈케이스
class GetAllUsers {
  final AdminUserRepository repository;
  const GetAllUsers(this.repository);

  Future<List<AdminUser>> call() {
    return repository.getAllUsers();
  }
} 