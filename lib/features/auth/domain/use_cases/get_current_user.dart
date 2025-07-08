import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 현재 로그인 유저 조회 유즈케이스
class GetCurrentUser {
  final AuthRepository repository;
  const GetCurrentUser(this.repository);

  Future<Either<AuthFailure, AuthUser?>> call() {
    return repository.getCurrentUser();
  }
} 