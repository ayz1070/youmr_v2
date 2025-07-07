import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/attendance_entity.dart';
import '../../domain/use_cases/get_my_attendance_use_case.dart';
import '../../domain/use_cases/save_attendance_use_case.dart';
import '../../domain/use_cases/get_attendees_by_day_use_case.dart';

/// 출석 상태 관리 컨트롤러
class AttendanceController extends AsyncNotifier<AttendanceEntity?> {
  late final GetMyAttendanceUseCase _getMyAttendance;
  late final SaveAttendanceUseCase _saveAttendance;
  late final GetAttendeesByDayUseCase _getAttendeesByDay;

  @override
  FutureOr<AttendanceEntity?> build() async {
    // DI 및 초기 상태 설정
    return null;
  }

  /// 출석 정보 저장
  Future<void> saveAttendance(AttendanceEntity entity) async {
    state = const AsyncValue.loading();
    try {
      await _saveAttendance(entity);
      state = AsyncValue.data(entity);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// 요일별 참석자 스트림 반환
  Stream<List<AttendanceEntity>> attendeesByDay(String weekKey, String day) {
    return _getAttendeesByDay(weekKey, day);
  }
} 