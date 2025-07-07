import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/attendance/domain/entities/attendance_entity.dart';
import 'package:youmr_v2/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:youmr_v2/features/attendance/domain/use_cases/get_my_attendance_use_case.dart';

class MockAttendanceRepository extends Mock implements AttendanceRepository {}

void main() {
  late MockAttendanceRepository repository;
  late GetMyAttendanceUseCase useCase;
  late AttendanceEntity entity;

  setUp(() {
    repository = MockAttendanceRepository();
    useCase = GetMyAttendanceUseCase(repository);
    entity = AttendanceEntity(
      weekKey: '2024-23',
      userId: 'user1',
      nickname: '홍길동',
      profileImageUrl: '',
      selectedDays: ['월'],
    );
  });

  test('정상적으로 내 출석 정보를 반환한다', () async {
    // Arrange
    when(() => repository.getMyAttendance('2024-23', 'user1')).thenAnswer((_) async => entity);
    // Act
    final result = await useCase('2024-23', 'user1');
    // Assert
    expect(result, entity);
  });

  test('출석 정보가 없으면 null 반환', () async {
    // Arrange
    when(() => repository.getMyAttendance('2024-23', 'user1')).thenAnswer((_) async => null);
    // Act
    final result = await useCase('2024-23', 'user1');
    // Assert
    expect(result, isNull);
  });
} 