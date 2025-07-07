import 'package:flutter_test/flutter_test.dart';
import 'package:youmr_v2/features/attendance/domain/entities/attendance_entity.dart';

void main() {
  group('AttendanceEntity', () {
    test('Given 필수 값으로 생성 When getter 사용 Then 값이 일치해야 한다', () {
      // Given
      final attendance = AttendanceEntity(
        weekKey: '2024-23',
        userId: 'user1',
        nickname: '홍길동',
        profileImageUrl: 'url',
        selectedDays: ['월'],
        lastUpdated: DateTime(2024, 1, 1),
      );
      // When & Then
      expect(attendance.weekKey, '2024-23');
      expect(attendance.userId, 'user1');
      expect(attendance.nickname, '홍길동');
      expect(attendance.profileImageUrl, 'url');
      expect(attendance.selectedDays, ['월']);
      expect(attendance.lastUpdated, DateTime(2024, 1, 1));
    });
  });
} 