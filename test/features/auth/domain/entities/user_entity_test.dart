import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/auth/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('Given 필수 값으로 생성 When getter 사용 Then 값이 일치해야 한다', () {
      // Given
      final user = UserEntity(
        uid: '1',
        email: 'test@email.com',
        nickname: '닉네임',
        profileImageUrl: 'url',
        userType: 'member',
        createdAt: DateTime(2024, 1, 1),
      );
      // When & Then
      expect(user.uid, '1');
      expect(user.email, 'test@email.com');
      expect(user.nickname, '닉네임');
      expect(user.profileImageUrl, 'url');
      expect(user.userType, 'member');
      expect(user.createdAt, DateTime(2024, 1, 1));
    });
  });
} 