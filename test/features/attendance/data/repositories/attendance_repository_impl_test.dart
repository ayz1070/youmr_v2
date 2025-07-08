import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:youmr_v2/features/attendance/data/repositories/attendance_repository_impl.dart';
import 'package:youmr_v2/features/attendance/data/data_sources/attendance_firestore_data_source.dart';
import 'package:youmr_v2/features/attendance/domain/entities/attendance.dart';
import 'package:youmr_v2/features/attendance/core/errors/attendance_failure.dart';

class MockAttendanceFirestoreDataSource extends Mock implements AttendanceFirestoreDataSource {}

void main() {
  group('AttendanceRepositoryImpl', () {
    late MockAttendanceFirestoreDataSource mockDataSource;
    late AttendanceRepositoryImpl repository;

    setUp(() {
      mockDataSource = MockAttendanceFirestoreDataSource();
      repository = AttendanceRepositoryImpl(dataSource: mockDataSource);
    });

    test('Given 정상 데이터, When getMyAttendance 호출, Then Attendance 반환', () async {
      // Given
      const weekKey = '2024-20';
      const userId = 'user1';
      final data = {
        'weekKey': weekKey,
        'userId': userId,
        'selectedDays': ['월', '화'],
        'nickname': '홍길동',
        'profileImageUrl': '',
      };
      when(() => mockDataSource.fetchMyAttendance(weekKey: weekKey, userId: userId)).thenAnswer((_) async => data);

      // When
      final result = await repository.getMyAttendance(weekKey: weekKey, userId: userId);

      // Then
      expect(result.isRight(), true);
      expect(result.getOrElse(() => null)?.userId, userId);
    });

    test('Given 예외 발생, When getMyAttendance 호출, Then Failure 반환', () async {
      // Given
      when(() => mockDataSource.fetchMyAttendance(weekKey: any(named: 'weekKey'), userId: any(named: 'userId')))
          .thenThrow(Exception('Firestore 오류'));

      // When
      final result = await repository.getMyAttendance(weekKey: '2024-20', userId: 'user1');

      // Then
      expect(result.isLeft(), true);
      expect(result.fold((l) => l, (r) => null), isA<AttendanceFailure>());
    });
  });
} 