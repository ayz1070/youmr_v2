import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  const factory AdminUserDto({
    /// 회원 UID
    String? uid,
    /// 닉네임
    String? nickname,
    /// 이름
    String? name,
    /// 이메일
    String? email,
    /// 회원 유형(admin, user 등)
    String? userType,
    /// 프로필 이미지 URL
    String? profileImageUrl,
    /// 가입일(생성일)
    @TimestampConverter() DateTime? createdAt,
  }) = _AdminUserDto;

  /// JSON → DTO 변환
  factory AdminUserDto.fromJson(Map<String, dynamic> json) => _$AdminUserDtoFromJson(json);

  /// 도메인 엔티티 → DTO 변환
  factory AdminUserDto.fromDomain(AdminUser user) => AdminUserDto(
    uid: user.uid,
    nickname: user.nickname,
    name: user.name,
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
    uid: uid ?? '',
    nickname: nickname ?? '',
    name: name,
    email: email ?? '',
    userType: userType ?? 'member',
    profileImageUrl: profileImageUrl ?? '',
    createdAt: createdAt ?? DateTime.now(),
  );
}


/// Firestore Timestamp를 DateTime으로 변환하는 컨버터
class TimestampConverter implements JsonConverter<DateTime?, Object?> {
  const TimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.tryParse(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    return object != null ? Timestamp.fromDate(object) : null;
  }
}