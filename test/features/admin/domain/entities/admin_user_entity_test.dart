import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/admin/domain/entities/admin_user_entity.dart';

void main() {
  group('AdminUserEntity', () {
    test('Given 필수 값으로 생성 When getter 사용 Then 값이 일치해야 한다', () {
      // Given
      final user = AdminUserEntity(
        id: '1',
        email: 'test@email.com',
        nickname: '관리자',
        userType: 'admin',
        profileImageUrl: 'url',
        createdAt: DateTime(2024, 1, 1),
      );
      // When & Then
      expect(user.id, '1');
      expect(user.email, 'test@email.com');
      expect(user.nickname, '관리자');
      expect(user.userType, 'admin');
      expect(user.profileImageUrl, 'url');
      expect(user.createdAt, DateTime(2024, 1, 1));
    });
  });
} 