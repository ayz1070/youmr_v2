import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/attendance/domain/entities/attendance_entity.dart';
import 'package:youmr_v2/features/attendance/domain/repositories/attendance_repository.dart';
import 'package:youmr_v2/features/attendance/domain/use_cases/save_attendance_use_case.dart';

class MockAttendanceRepository extends Mock implements AttendanceRepository {}

void main() {
  late MockAttendanceRepository repository;
  late SaveAttendanceUseCase useCase;
  late AttendanceEntity entity;

  setUp(() {
    repository = MockAttendanceRepository();
    useCase = SaveAttendanceUseCase(repository);
    entity = AttendanceEntity(
      weekKey: '2024-23',
      userId: 'user1',
      nickname: '홍길동',
      profileImageUrl: '',
      selectedDays: ['월'],
    );
  });

  test('정상적으로 출석 정보를 저장한다', () async {
    // Arrange
    when(() => repository.saveAttendance(entity)).thenAnswer((_) async {});
    // Act
    await useCase(entity);
    // Assert
    verify(() => repository.saveAttendance(entity)).called(1);
  });
} 