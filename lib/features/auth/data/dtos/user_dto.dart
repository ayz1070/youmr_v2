import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_dto.g.dart';

/// Firestore/Firebase 유저 데이터 DTO
@JsonSerializable(fieldRename: FieldRename.snake)
class UserDTO {
  final String uid;
  final String email;
  final String nickname;
  final String profileImageUrl;
  final String userType;
  final String? dayOfWeek;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserDTO({
    required this.uid,
    required this.email,
    required this.nickname,
    required this.profileImageUrl,
    required this.userType,
    this.dayOfWeek,
    this.createdAt,
    this.updatedAt,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  /// DTO → 도메인 엔티티 변환
  UserEntity toEntity() => UserEntity(
        uid: uid,
        email: email,
        nickname: nickname,
        profileImageUrl: profileImageUrl,
        userType: userType,
        dayOfWeek: dayOfWeek,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

  /// 도메인 엔티티 → DTO 변환
  factory UserDTO.fromEntity(UserEntity entity) => UserDTO(
        uid: entity.uid,
        email: entity.email,
        nickname: entity.nickname,
        profileImageUrl: entity.profileImageUrl,
        userType: entity.userType,
        dayOfWeek: entity.dayOfWeek,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );
} 