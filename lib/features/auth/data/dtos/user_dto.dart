import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:youmr_v2/features/auth/domain/entities/auth_user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// 인증 유저 DTO
/// - Firestore <-> 도메인 변환 담당
@freezed
class UserDto with _$UserDto {
  /// 생성자
  const factory UserDto({
    /// 유저 고유 ID
    required String uid,
    /// 이메일
    required String email,
    /// 닉네임
    required String nickname,
    /// 프로필 이미지 URL (nullable)
    String? profileImageUrl,
  }) = _UserDto;

  /// JSON -> DTO
  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}

/// UserDto <-> AuthUser 변환 확장
extension UserDtoDomainMapper on UserDto {
  /// DTO -> 도메인
  AuthUser toDomain() => AuthUser(
        uid: uid,
        email: email,
        nickname: nickname,
        profileImageUrl: profileImageUrl,
      );
}

extension UserDtoFromDomain on AuthUser {
  /// 도메인 -> DTO
  UserDto toDto() => UserDto(
        uid: uid,
        email: email,
        nickname: nickname,
        profileImageUrl: profileImageUrl,
      );
} 