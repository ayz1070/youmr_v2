import 'package:dartz/dartz.dart';
import 'package:youmr_v2/core/errors/app_failure.dart';
import '../repositories/admin_user_repository.dart';

/// 회원 권한 변경 유즈케이스
class ChangeUserType {
  /// Repository 의존성
  final AdminUserRepository repository;
  /// 생성자
  const ChangeUserType(this.repository);

  /// 회원 권한 변경 실행
  /// [uid] : 회원 UID
  /// [newType] : 변경할 권한 타입
  /// return: Either<AppFailure, void>
  Future<Either<AppFailure, void>> call({required String uid, required String newType}) {
    return repository.changeUserType(uid: uid, newType: newType);
  }
} 