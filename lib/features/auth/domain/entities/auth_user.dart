import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// 인증 유저 엔티티 (불변, Freezed)
/// - 인증된 사용자의 정보를 표현
@freezed
class AuthUser with _$AuthUser {
  /// 인증 유저 엔티티 생성자
  /// [uid] 유저 고유 ID
  /// [email] 이메일
  /// [nickname] 닉네임
  /// [profileImageUrl] 프로필 이미지 URL (nullable)
  /// [userType] 유저 타입(관리자/일반 등, nullable)
  /// [dayOfWeek] 요일 정보(nullable)
  /// [fcmToken] FCM 토큰(푸시용, nullable)
  /// [createdAt] 생성일(nullable)
  /// [updatedAt] 수정일(nullable)
  const factory AuthUser({
    /// 유저 고유 ID
    required String uid,
    /// 이메일
    required String email,
    /// 닉네임
    required String nickname,
    /// 프로필 이미지 URL (nullable)
    String? profileImageUrl,
    /// 유저 타입(관리자/일반 등, nullable)
    String? userType,
    /// 요일 정보(nullable)
    String? dayOfWeek,
    /// FCM 토큰(푸시용, nullable)
    String? fcmToken,
    /// 생성일(nullable)
    DateTime? createdAt,
    /// 수정일(nullable)
    DateTime? updatedAt,
  }) = _AuthUser;

  /// JSON -> AuthUser 변환
  /// [json] JSON 맵
  /// 반환: [AuthUser] 인스턴스
  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
} 