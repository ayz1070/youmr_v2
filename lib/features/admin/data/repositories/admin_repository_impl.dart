import '../../domain/entities/admin_user_entity.dart';
import '../../domain/repositories/admin_repository.dart';
import '../data_sources/user_firestore_data_source.dart';

/// 관리자 기능 저장소 구현체
class AdminRepositoryImpl implements AdminRepository {
  final UserFirestoreDataSource dataSource;
  AdminRepositoryImpl(this.dataSource);

  @override
  Future<List<AdminUserEntity>> fetchUsers() => dataSource.fetchUsers();

  @override
  Future<void> changeUserType(String uid, String newType) => dataSource.changeUserType(uid, newType);

  @override
  Future<void> removeUser(String uid) => dataSource.removeUser(uid);
} 