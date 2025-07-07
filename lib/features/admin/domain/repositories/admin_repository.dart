import '../entities/admin_user_entity.dart';

/// 관리자 기능 추상 저장소
abstract class AdminRepository {
  /// 유저 목록 조회
  Future<List<AdminUserEntity>> fetchUsers();

  /// 유저 권한 변경
  Future<void> changeUserType(String uid, String newType);

  /// 유저 삭제
  Future<void> removeUser(String uid);
} 