import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// 인증 유저 엔티티 (불변, Freezed)
@freezed
class AuthUser with _$AuthUser {
  const factory AuthUser({
    required String uid,
    required String email,
    required String nickname,
    String? profileImageUrl,
    String? userType,
    String? dayOfWeek,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);
} 