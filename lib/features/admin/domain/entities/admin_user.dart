import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// 관리자/회원 엔터티
@freezed
class AdminUser with _$AdminUser {
  const factory AdminUser({
    required String uid,
    required String nickname,
    required String email,
    required String userType,
    required String profileImageUrl,
    required DateTime createdAt,
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);
} 