import '../entities/profile.dart';
import '../repositories/profile_repository.dart';
import '../../core/errors/profile_failure.dart';
import 'package:dartz/dartz.dart';

/// 내 프로필 정보 조회 유즈케이스
class GetMyProfile {
  final ProfileRepository repository;
  const GetMyProfile(this.repository);

  Future<Either<ProfileFailure, Profile>> call({required String uid}) {
    return repository.getMyProfile(uid: uid);
  }
} 