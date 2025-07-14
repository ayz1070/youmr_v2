import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 로그아웃 유즈케이스
/// - 현재 로그인된 사용자를 로그아웃 처리
class SignOut {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const SignOut(this.repository);

  /// 로그아웃 실행
  /// 반환: 성공 시 void, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, void>> call() {
    return repository.signOut();
  }
} 