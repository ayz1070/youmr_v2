import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youmr_v2/features/attendance/presentation/controllers/attendance_controller.dart';
import 'package:youmr_v2/features/attendance/domain/use_cases/fetch_attendance_use_case.dart';
import 'package:youmr_v2/features/attendance/domain/entities/attendance_entity.dart';

class MockFetchAttendanceUseCase extends Mock implements FetchAttendanceUseCase {}

void main() {
  group('AttendanceController', () {
    late AttendanceController controller;
    late MockFetchAttendanceUseCase fetchAttendanceUseCase;

    setUp(() {
      fetchAttendanceUseCase = MockFetchAttendanceUseCase();
      controller = AttendanceController()
        .._fetchAttendanceUseCase = fetchAttendanceUseCase;
    });

    test('Given fetchAttendance 성공 When fetchAttendance 호출 Then 상태가 attendance로 변경', () async {
      // Given
      final attendances = [AttendanceEntity(id: '1', userId: 'u', date: DateTime.now(), status: '출석')];
      when(() => fetchAttendanceUseCase(userId: any(named: 'userId'))).thenAnswer((_) async => attendances);
      // When
      await controller.fetchAttendance(userId: 'u');
      // Then
      expect(controller.debugState.valueOrNull?.attendances, attendances);
    });
  });
} 