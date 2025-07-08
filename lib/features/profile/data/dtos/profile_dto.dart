import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

/// 프로필 DTO (Firestore ↔️ Domain 변환)
@freezed
class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required String uid,
    required String nickname,
    required String userType,
    String? profileImageUrl,
    String? dayOfWeek,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, dynamic> json) => _$ProfileDtoFromJson(json);

  factory ProfileDto.fromDomain(Profile profile) => ProfileDto(
    uid: profile.uid,
    nickname: profile.nickname,
    userType: profile.userType,
    profileImageUrl: profile.profileImageUrl,
    dayOfWeek: profile.dayOfWeek,
  );
}

/// ProfileDto → Profile 변환 확장
extension ProfileDtoX on ProfileDto {
  Profile toDomain() => Profile(
    uid: uid,
    nickname: nickname,
    userType: userType,
    profileImageUrl: profileImageUrl,
    dayOfWeek: dayOfWeek,
  );
} 