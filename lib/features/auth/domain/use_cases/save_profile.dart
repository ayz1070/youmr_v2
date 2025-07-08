import '../entities/auth_user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failure.dart';
import 'package:dartz/dartz.dart';

/// 프로필 저장 유즈케이스
class SaveProfile {
  final AuthRepository repository;
  const SaveProfile(this.repository);

  Future<Either<AuthFailure, void>> call({required AuthUser user}) {
    return repository.saveProfile(user: user);
  }
} 