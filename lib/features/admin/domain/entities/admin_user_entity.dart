import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user_entity.freezed.dart';
part 'admin_user_entity.g.dart';

/// 관리자 기능에서 사용하는 유저 도메인 엔티티
@freezed
class AdminUserEntity with _$AdminUserEntity {
  /// [id] 유저 고유 ID
  /// [email] 이메일
  /// [nickname] 닉네임
  /// [userType] 권한(관리자/개발자/일반 등)
  /// [profileImageUrl] 프로필 이미지 URL
  /// [createdAt] 가입일
  const factory AdminUserEntity({
    required String id,
    required String email,
    required String nickname,
    required String userType,
    required String profileImageUrl,
    required DateTime createdAt,
  }) = _AdminUserEntity;

  factory AdminUserEntity.fromJson(Map<String, dynamic> json) => _$AdminUserEntityFromJson(json);
} 