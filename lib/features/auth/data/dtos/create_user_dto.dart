import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'create_user_dto.freezed.dart';
part 'create_user_dto.g.dart';

/// 사용자 생성 전용 DTO
/// - Firebase Auth 로그인 후 Firestore에 저장할 때 사용
/// - 생성 시 필요한 필드만 포함
@freezed
class CreateUserDto with _$CreateUserDto {
  /// 생성자
  const factory CreateUserDto({
    /// 유저 고유 ID (Firebase Auth에서 생성)
    required String uid,
    /// 이메일 (Firebase Auth에서 생성)
    required String email,
    /// 닉네임 (Firebase Auth displayName 또는 기본값)
    required String nickname,
    /// 실명 (nullable, 사용자가 나중에 설정)
    String? name,
    /// 프로필 이미지 URL (Firebase Auth photoURL 또는 기본값)
    String? profileImageUrl,
    /// 유저 타입 (기본값: 빈 문자열)
    @Default('') String userType,
    /// 요일 정보 (기본값: 빈 문자열)
    @Default('') String dayOfWeek,
    /// FCM 토큰 (기본값: 빈 문자열, 나중에 설정)
    @Default('') String fcmToken,
  }) = _CreateUserDto;

  /// JSON -> DTO
  factory CreateUserDto.fromJson(Map<String, dynamic> json) => 
      _$CreateUserDtoFromJson(json);
      
  /// Firebase Auth User 정보로부터 CreateUserDto 생성
  /// - [user] Firebase Auth User 객체
  /// - [defaultNickname] 기본 닉네임 (null인 경우 사용)
  static CreateUserDto fromFirebaseUser(
    User user, {
    String? defaultNickname,
  }) {
    return CreateUserDto(
      uid: user.uid,
      email: user.email ?? '',
      nickname: user.displayName ?? defaultNickname ?? '사용자',
      name: user.displayName,
      profileImageUrl: user.photoURL,
      userType: '',
      dayOfWeek: '',
      fcmToken: '',
    );
  }
}

/// CreateUserDto 확장 메서드
extension CreateUserDtoExtension on CreateUserDto {
  /// Firestore 저장용 Map으로 변환
  /// - 서버 타임스탬프 자동 추가
  /// - null 값은 빈 문자열로 변환
  Map<String, dynamic> toFirestoreData() => {
    'uid': uid,
    'email': email,
    'nickname': nickname,
    'name': name ?? '',
    'profileImageUrl': profileImageUrl ?? '',
    'userType': userType,
    'dayOfWeek': dayOfWeek,
    'fcmToken': fcmToken,
    'lastUpdated': FieldValue.serverTimestamp(),
  };
}
