import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_user.dart';

part 'admin_user_dto.freezed.dart';
part 'admin_user_dto.g.dart';

/// 관리자/회원 DTO (Firestore ↔️ Domain 변환)
@freezed
class AdminUserDto with _$AdminUserDto {
  const factory AdminUserDto({
    required String uid,
    required String nickname,
    required String email,
    required String userType,
    required String profileImageUrl,
    required DateTime createdAt,
  }) = _AdminUserDto;

  factory AdminUserDto.fromJson(Map<String, dynamic> json) => _$AdminUserDtoFromJson(json);

  factory AdminUserDto.fromDomain(AdminUser user) => AdminUserDto(
    uid: user.uid,
    nickname: user.nickname,
    email: user.email,
    userType: user.userType,
    profileImageUrl: user.profileImageUrl,
    createdAt: user.createdAt,
  );
}

extension AdminUserDtoX on AdminUserDto {
  AdminUser toDomain() => AdminUser(
    uid: uid,
    nickname: nickname,
    email: email,
    userType: userType,
    profileImageUrl: profileImageUrl,
    createdAt: createdAt,
  );
} 