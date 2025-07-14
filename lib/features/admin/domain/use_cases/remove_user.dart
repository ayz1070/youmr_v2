import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../repositories/admin_user_repository.dart';

/// 회원 삭제 유즈케이스
class RemoveUser {
  /// Repository 의존성
  final AdminUserRepository repository;
  /// 생성자
  const RemoveUser(this.repository);

  /// 회원 삭제 실행
  /// [uid] : 회원 UID
  /// return: Either<AppFailure, void>
  Future<Either<AppFailure, void>> call({required String uid}) {
    return repository.removeUser(uid: uid);
  }
} 