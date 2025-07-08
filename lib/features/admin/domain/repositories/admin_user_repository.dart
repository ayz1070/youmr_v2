import '../entities/admin_user.dart';

/// 관리자/회원 Repository 인터페이스
abstract class AdminUserRepository {
  /// 전체 회원 목록 조회
  Future<List<AdminUser>> getAllUsers();

  /// 회원 권한 변경
  Future<void> changeUserType({required String uid, required String newType});

  /// 회원 삭제
  Future<void> removeUser({required String uid});
} 