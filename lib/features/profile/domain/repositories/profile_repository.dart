import 'package:dartz/dartz.dart';
import '../entities/profile.dart';
import '../../../../core/errors/profile_failure.dart';

/// 프로필 관련 Repository 인터페이스
abstract class ProfileRepository {
  /// 내 프로필 정보 불러오기
  Future<Either<ProfileFailure, Profile>> getMyProfile({required String uid});

  /// 내 프로필 정보 저장
  Future<Either<ProfileFailure, void>> saveMyProfile({required Profile profile});
} 