import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token.freezed.dart';
part 'fcm_token.g.dart';

/// FCM 토큰 엔티티
@freezed
class FcmToken with _$FcmToken {
  const factory FcmToken({
    /// 사용자 ID
    required String userId,
    
    /// FCM 토큰
    required String token,
    
    /// 생성 시간
    required DateTime createdAt,
    
    /// 수정 시간
    required DateTime updatedAt,
    
    /// 디바이스 정보
    @Default({}) Map<String, dynamic> deviceInfo,
  }) = _FcmToken;

  factory FcmToken.fromJson(Map<String, dynamic> json) => 
      _$FcmTokenFromJson(json);
} 