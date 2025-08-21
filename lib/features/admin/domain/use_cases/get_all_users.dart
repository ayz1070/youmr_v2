import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../entities/admin_user.dart';
import '../repositories/admin_user_repository.dart';

/// 전체 회원 목록 조회 유즈케이스
class GetAllUsers {
  /// Repository 의존성
  final AdminUserRepository repository;
  /// 생성자
  const GetAllUsers(this.repository);

  /// 전체 회원 목록 조회 실행
  /// 반환값: Either<AppFailure, List<AdminUser>>
  Future<Either<AppFailure, List<AdminUser>>> call() {
    return repository.getAllUsers();
  }
} 