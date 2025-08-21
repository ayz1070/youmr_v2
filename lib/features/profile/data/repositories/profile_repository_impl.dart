import 'package:dartz/dartz.dart';
import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_firestore_data_source.dart';
import '../dtos/profile_dto.dart';
import '../../../../core/errors/profile_failure.dart';

/// 프로필 Repository 구현체
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileFirestoreDataSource dataSource;
  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<ProfileFailure, Profile>> getMyProfile({required String uid}) async {
    try {
      final data = await dataSource.fetchMyProfile(uid: uid);
      if (data == null) return Left(ProfileFirestoreFailure('프로필 정보 없음'));
      final dto = ProfileDto.fromJson(data);
      return Right(dto.toDomain());
    } catch (e) {
      return Left(ProfileFirestoreFailure('프로필 정보 조회 실패: $e'));
    }
  }

  @override
  Future<Either<ProfileFailure, void>> saveMyProfile({required Profile profile}) async {
    try {
      final dto = ProfileDto.fromDomain(profile);
      await dataSource.saveMyProfile(uid: dto.uid, data: dto.toJson());
      return const Right(null);
    } catch (e) {
      return Left(ProfileFirestoreFailure('프로필 정보 저장 실패: $e'));
    }
  }
} 