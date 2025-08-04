import 'package:freezed_annotation/freezed_annotation.dart';

part 'fcm_token_dto.freezed.dart';
part 'fcm_token_dto.g.dart';

/// FCM 토큰 DTO
@freezed
class FcmTokenDto with _$FcmTokenDto {
  const factory FcmTokenDto({
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
  }) = _FcmTokenDto;

  factory FcmTokenDto.fromJson(Map<String, dynamic> json) => 
      _$FcmTokenDtoFromJson(json);
} 