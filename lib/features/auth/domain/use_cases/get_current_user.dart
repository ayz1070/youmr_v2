import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 현재 로그인 유저 조회 유즈케이스
/// - 현재 인증된 유저 정보를 반환
class GetCurrentUser {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const GetCurrentUser(this.repository);

  /// 현재 로그인 유저 조회 실행
  /// 반환: 성공 시 [AuthUser?], 실패 시 [AuthFailure]
  Future<Either<AuthFailure, AuthUser?>> call() {
    return repository.getCurrentUser();
  }
} 