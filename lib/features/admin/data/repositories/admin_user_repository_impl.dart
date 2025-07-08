import '../../domain/entities/admin_user.dart';
import '../../domain/repositories/admin_user_repository.dart';
import '../data_sources/admin_user_firestore_data_source.dart';
import '../dtos/admin_user_dto.dart';

/// 관리자/회원 Repository 구현체
class AdminUserRepositoryImpl implements AdminUserRepository {
  final AdminUserFirestoreDataSource dataSource;
  AdminUserRepositoryImpl({required this.dataSource});

  @override
  Future<List<AdminUser>> getAllUsers() async {
    final list = await dataSource.fetchAllUsers();
    return list.map((e) => AdminUserDto.fromJson(e).toDomain()).toList();
  }

  @override
  Future<void> changeUserType({required String uid, required String newType}) async {
    await dataSource.updateUserType(uid: uid, newType: newType);
  }

  @override
  Future<void> removeUser({required String uid}) async {
    await dataSource.deleteUser(uid: uid);
  }
} 