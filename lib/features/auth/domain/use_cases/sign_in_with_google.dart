import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 구글 로그인 유즈케이스
class SignInWithGoogle {
  final AuthRepository repository;
  const SignInWithGoogle(this.repository);

  Future<Either<AuthFailure, AuthUser>> call() {
    return repository.signInWithGoogle();
  }
} 