import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../data/data_sources/attendance_firestore_data_source.dart';
import '../data/repositories/attendance_repository_impl.dart';
import '../domain/repositories/attendance_repository.dart';
import '../presentation/providers/notifier/attendance_notifier.dart';
import '../presentation/providers/state/attendance_state.dart';

/// Firestore 인스턴스 Provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

/// 출석 데이터 소스 Provider
final attendanceDataSourceProvider = Provider<AttendanceFirestoreDataSource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  return AttendanceFirestoreDataSource(firestore: firestore);
});

/// 출석 Repository Provider
final attendanceRepositoryProvider = Provider<AttendanceRepository>((ref) {
  final dataSource = ref.watch(attendanceDataSourceProvider);
  return AttendanceRepositoryImpl(dataSource: dataSource);
});

/// 출석 상태 관리 Provider (AsyncNotifier)
final attendanceProvider = AsyncNotifierProvider<AttendanceNotifier, AttendanceState>(
  AttendanceNotifier.new,
);
