import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 로그아웃 유즈케이스
class SignOut {
  final AuthRepository repository;
  const SignOut(this.repository);

  Future<Either<AuthFailure, void>> call() {
    return repository.signOut();
  }
} 