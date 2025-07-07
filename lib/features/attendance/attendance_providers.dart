import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/data_sources/attendance_firestore_data_source.dart';
import 'data/repositories/attendance_repository_impl.dart';
import 'domain/repositories/attendance_repository.dart';
import 'domain/use_cases/save_attendance_use_case.dart';
import 'domain/entities/attendance_entity.dart';
import 'presentation/controllers/attendance_controller.dart';

/// 출석 관련 의존성 주입 provider 모음

// 데이터소스 provider
final attendanceFirestoreDataSourceProvider = Provider<AttendanceFirestoreDataSource>((ref) {
  return AttendanceFirestoreDataSource();
});

// 리포지토리 provider
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final dataSource = ref.watch(attendanceFirestoreDataSourceProvider);
  return AttendanceRepositoryImpl(dataSource);
});

// 유스케이스 provider
final saveAttendanceUseCaseProvider = Provider<SaveAttendanceUseCase>((ref) {
  final repository = ref.watch(attendanceRepositoryProvider);
  return SaveAttendanceUseCase(repository);
});

// 컨트롤러 provider
final attendanceControllerProvider = AsyncNotifierProvider<AttendanceController, AttendanceEntity?>(
  AttendanceController.new,
); 