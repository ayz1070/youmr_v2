import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';
part 'profile_entity.g.dart';

/// 프로필 도메인 엔티티
@freezed
class ProfileEntity with _$ProfileEntity {
  /// [id] 유저 고유 ID
  /// [email] 이메일
  /// [nickname] 닉네임
  /// [userType] 권한(관리자/개발자/일반 등)
  /// [profileImageUrl] 프로필 이미지 URL
  /// [dayOfWeek] 오프라인 회원 요일
  /// [createdAt] 가입일
  const factory ProfileEntity({
    required String id,
    required String email,
    required String nickname,
    required String userType,
    required String profileImageUrl,
    String? dayOfWeek,
    required DateTime createdAt,
  }) = _ProfileEntity;

  factory ProfileEntity.fromJson(Map<String, dynamic> json) => _$ProfileEntityFromJson(json);
} 