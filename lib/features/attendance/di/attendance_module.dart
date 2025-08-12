import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/entities/attendance.dart';
import '../presentation/providers/notifier/attendance_notifier.dart';

/// 출석 상태 관리 Provider (AsyncNotifier)
final attendanceProvider = AsyncNotifierProvider<AttendanceNotifier, Attendance?>(
  AttendanceNotifier.new,
);
