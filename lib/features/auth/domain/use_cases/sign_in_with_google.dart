import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 구글 로그인 유즈케이스
/// - 구글 인증을 통해 유저 정보를 반환
class SignInWithGoogle {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const SignInWithGoogle(this.repository);

  /// 구글 로그인 실행
  /// 반환: 성공 시 [AuthUser], 실패 시 [AuthFailure]
  Future<Either<AuthFailure, AuthUser>> call() {
    return repository.signInWithGoogle();
  }
} 