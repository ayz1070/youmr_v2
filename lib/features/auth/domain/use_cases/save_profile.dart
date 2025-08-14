import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 프로필 저장 유즈케이스
/// - 유저 프로필 정보를 Firestore에 저장
class SaveProfile {
  /// 인증 레포지토리
  final AuthRepository repository;

  /// [repository]: 인증 레포지토리 DI
  const SaveProfile({required this.repository});

  /// 프로필 저장 실행
  /// [user]: 저장할 유저 정보
  /// 반환: 성공 시 void, 실패 시 [AuthFailure]
  Future<Either<AuthFailure, void>> call({required AuthUser user}) {
    return repository.saveProfile(user: user);
  }
} 