import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/features/auth/domain/entities/auth_user.dart';

part 'user_response_dto.freezed.dart';
part 'user_response_dto.g.dart';

/// 사용자 조회 전용 DTO
/// - Firestore에서 사용자 정보 조회 시 사용
/// - 조회 시 반환되는 모든 필드 포함
@freezed
class UserResponseDto with _$UserResponseDto {
  /// 생성자
  const factory UserResponseDto({
    /// 유저 고유 ID
    required String uid,
    /// 이메일
    required String email,
    /// 닉네임
    required String nickname,
    /// 실명 (nullable)
    String? name,
    /// 프로필 이미지 URL (nullable)
    String? profileImageUrl,
    /// 유저 타입(관리자/일반 등, nullable)
    String? userType,
    /// 요일 정보(nullable)
    String? dayOfWeek,
    /// FCM 토큰(푸시용, nullable)
    String? fcmToken,
    /// 피크 개수 (nullable)
    int? pick,
    /// 마지막 피크 획득 날짜 (nullable)
    DateTime? lastPickDate,
    /// 생성일(nullable)
    DateTime? createdAt,
    /// 수정일(nullable)
    DateTime? updatedAt,
    /// 마지막 업데이트(nullable)
    DateTime? lastUpdated,
  }) = _UserResponseDto;

  /// JSON -> DTO
  factory UserResponseDto.fromJson(Map<String, dynamic> json) => 
      _$UserResponseDtoFromJson(json);

  /// Firestore DocumentSnapshot으로부터 생성
  /// - [doc] Firestore 문서 스냅샷
  /// - 반환: [UserResponseDto] 인스턴스
  /// - 예외: 문서 데이터가 null인 경우
  factory UserResponseDto.fromFirestoreDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      throw Exception('Document data is null');
    }
    
    return UserResponseDto(
      uid: data['uid'] ?? '',
      email: data['email'] ?? '',
      nickname: data['nickname'] ?? '',
      name: data['name'],
      profileImageUrl: data['profileImageUrl'],
      userType: data['userType'],
      dayOfWeek: data['dayOfWeek'],
      fcmToken: data['fcmToken'],
      pick: data['pick'] as int?,
      lastPickDate: _timestampFromJson(data['lastPickDate']),
      createdAt: _timestampFromJson(data['createdAt']),
      updatedAt: _timestampFromJson(data['updatedAt']),
      lastUpdated: _timestampFromJson(data['lastUpdated']),
    );
  }
}

/// Firestore Timestamp 변환 헬퍼 함수들
DateTime? _timestampFromJson(dynamic timestamp) {
  if (timestamp is Timestamp) {
    return timestamp.toDate();
  }
  return null;
}

/// UserResponseDto <-> AuthUser 변환 확장
extension UserResponseDtoDomainMapper on UserResponseDto {
  /// DTO -> 도메인 엔티티
  AuthUser toDomain() => AuthUser(
        uid: uid,
        email: email,
        nickname: nickname,
        name: name,
        profileImageUrl: profileImageUrl,
        userType: userType,
        dayOfWeek: dayOfWeek,
        fcmToken: fcmToken,
        pick: pick,
        lastPickDate: lastPickDate,
        createdAt: createdAt,
        updatedAt: updatedAt,
      );
}

extension UserResponseDtoFromDomain on AuthUser {
  /// 도메인 엔티티 -> DTO
  UserResponseDto toResponseDto() => UserResponseDto(
        uid: uid,
        email: email,
        nickname: nickname,
        name: name,
        profileImageUrl: profileImageUrl,
        userType: userType,
        dayOfWeek: dayOfWeek,
        fcmToken: fcmToken,
        pick: pick,
        lastPickDate: lastPickDate,
        createdAt: createdAt,
        updatedAt: updatedAt,
        lastUpdated: updatedAt,
      );
}
