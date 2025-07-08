import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile.freezed.dart';
part 'profile.g.dart';

/// 프로필 엔티티 (불변, Freezed)
@freezed
class Profile with _$Profile {
  const factory Profile({
    required String uid,
    required String nickname,
    required String userType, // 값 객체로 분리 가능
    String? profileImageUrl,
    String? dayOfWeek,
  }) = _Profile;

  factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);
} 