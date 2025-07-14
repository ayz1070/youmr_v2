import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/admin_user.dart';

part 'admin_user_dto.freezed.dart';
part 'admin_user_dto.g.dart';

/// 관리자/회원 DTO (Firestore ↔️ Domain 변환)
///
/// - Firestore 컬렉션/필드명은 core/constants/firestore_constants.dart에서 상수로 관리
/// - fromDomain/toDomain 확장 제공
/// - 모든 필드/생성자/함수/파라미터/반환값에 한글 주석 필수
@freezed
class AdminUserDto with _$AdminUserDto {
  /// 생성자
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory AdminUserDto({
    /// 회원 UID
    required String uid,
    /// 닉네임
    required String nickname,
    /// 이메일
    required String email,
    /// 회원 유형(admin, user 등)
    required String userType,
    /// 프로필 이미지 URL
    required String profileImageUrl,
    /// 가입일(생성일)
    required DateTime createdAt,
  }) = _AdminUserDto;

  /// JSON → DTO 변환
  factory AdminUserDto.fromJson(Map<String, dynamic> json) => _$AdminUserDtoFromJson(json);

  /// 도메인 엔티티 → DTO 변환
  factory AdminUserDto.fromDomain(AdminUser user) => AdminUserDto(
    uid: user.uid,
    nickname: user.nickname,
    email: user.email,
    userType: user.userType,
    profileImageUrl: user.profileImageUrl,
    createdAt: user.createdAt,
  );
}

/// DTO → 도메인 엔티티 변환 확장
extension AdminUserDtoX on AdminUserDto {
  /// DTO → 도메인 엔티티 변환
  AdminUser toDomain() => AdminUser(
    uid: uid,
    nickname: nickname,
    email: email,
    userType: userType,
    profileImageUrl: profileImageUrl,
    createdAt: createdAt,
  );
} 