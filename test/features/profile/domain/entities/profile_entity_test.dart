import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/profile/domain/entities/profile_entity.dart';

void main() {
  group('ProfileEntity', () {
    test('Given 필수 값으로 생성 When getter 사용 Then 값이 일치해야 한다', () {
      // Given
      final profile = ProfileEntity(
        id: '1',
        email: 'test@email.com',
        nickname: '닉네임',
        userType: 'member',
        profileImageUrl: 'url',
        createdAt: DateTime(2024, 1, 1),
      );
      // When & Then
      expect(profile.id, '1');
      expect(profile.email, 'test@email.com');
      expect(profile.nickname, '닉네임');
      expect(profile.userType, 'member');
      expect(profile.profileImageUrl, 'url');
      expect(profile.createdAt, DateTime(2024, 1, 1));
    });
  });
} 