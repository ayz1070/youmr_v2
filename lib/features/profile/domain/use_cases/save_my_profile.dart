import '../entities/profile.dart';
import '../repositories/profile_repository.dart';
import '../../core/errors/profile_failure.dart';
import 'package:dartz/dartz.dart';

/// 내 프로필 정보 저장 유즈케이스
class SaveMyProfile {
  final ProfileRepository repository;
  const SaveMyProfile(this.repository);

  Future<Either<ProfileFailure, void>> call({required Profile profile}) {
    return repository.saveMyProfile(profile: profile);
  }
} 