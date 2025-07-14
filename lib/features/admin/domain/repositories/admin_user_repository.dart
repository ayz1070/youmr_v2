import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../entities/admin_user.dart';

/// 관리자/회원 Repository 인터페이스
abstract class AdminUserRepository {
  /// 전체 회원 목록 조회
  /// 반환값: Either<AppFailure, List<AdminUser>>
  Future<Either<AppFailure, List<AdminUser>>> getAllUsers();

  /// 회원 권한 변경
  /// [uid] : 회원 UID
  /// [newType] : 변경할 권한 타입
  /// 반환값: Either<AppFailure, void>
  Future<Either<AppFailure, void>> changeUserType({required String uid, required String newType});

  /// 회원 삭제
  /// [uid] : 회원 UID
  /// 반환값: Either<AppFailure, void>
  Future<Either<AppFailure, void>> removeUser({required String uid});
} 