import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

/// 유저 도메인 엔티티
@freezed
class UserEntity with _$UserEntity {
  /// [uid] : 유저 고유 ID
  /// [email] : 이메일
  /// [nickname] : 닉네임
  /// [profileImageUrl] : 프로필 이미지 URL
  /// [userType] : 회원 타입
  /// [dayOfWeek] : 오프라인 회원 요일
  /// [createdAt] : 생성일
  /// [updatedAt] : 수정일
  const factory UserEntity({
    required String uid,
    required String email,
    required String nickname,
    required String profileImageUrl,
    required String userType,
    String? dayOfWeek,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
} 