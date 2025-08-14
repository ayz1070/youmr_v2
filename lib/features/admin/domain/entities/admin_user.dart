import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// 관리자/회원 엔터티
@freezed
class AdminUser with _$AdminUser {
  /// 생성자
  /// [uid] : 회원 UID
  /// [nickname] : 닉네임
  /// [name] : 이름
  /// [email] : 이메일
  /// [userType] : 회원 유형(admin, user 등)
  /// [profileImageUrl] : 프로필 이미지 URL
  /// [createdAt] : 가입일(생성일)
  const factory AdminUser({
    /// 회원 UID
    required String uid,
    /// 닉네임
    required String nickname,
    /// 이름
    String? name,
    /// 이메일
    required String email,
    /// 회원 유형(admin, user 등)
    required String userType,
    /// 프로필 이미지 URL
    required String profileImageUrl,
    /// 가입일(생성일)
    required DateTime createdAt,
  }) = _AdminUser;

  /// JSON → 도메인 엔티티 변환
  factory AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);
} 