import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/attendance_module.dart';
import '../../../domain/entities/attendance.dart';
import '../../../domain/use_cases/get_current_user_profile.dart';
import '../../../domain/use_cases/get_my_attendance.dart';
import '../../../domain/use_cases/save_my_attendance.dart';
import '../state/attendance_state.dart';

/// 출석 상태를 관리하는 Notifier
/// - 출석 데이터의 CRUD 작업을 담당
/// - UI와 비즈니스 로직을 분리
/// - 상태 변경을 통한 UI 업데이트 관리
class AttendanceNotifier extends AsyncNotifier<AttendanceState> {
  late final GetMyAttendance _getMyAttendance;
  late final SaveMyAttendance _saveMyAttendance;
  late final GetCurrentUserProfile _getCurrentUserProfile;

  @override
  FutureOr<AttendanceState> build() async {
    // DI를 통해 Repository 주입받기
    final repository = ref.watch(attendanceRepositoryProvider);
    
    // UseCase 초기화
    _getMyAttendance = GetMyAttendance(repository);
    _saveMyAttendance = SaveMyAttendance(repository);
    _getCurrentUserProfile = GetCurrentUserProfile(repository);

    // 현재 로그인 유저 정보 확인
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return AttendanceState.error(
        message: '사용자 인증 정보가 없습니다',
      );
    }

    try {
      // 사용자 프로필 정보 가져오기 (현재는 사용하지 않지만 향후 확장을 위해 유지)
      await _getCurrentUserProfile();

      final weekKey = _getCurrentWeekKey();
      final result = await _getMyAttendance(weekKey: weekKey, userId: user.uid);
      
      return result.fold(
        (failure) => AttendanceState.error(
          message: '출석 정보 불러오기 실패',
          errorDetail: failure.message,
        ),
        (attendance) {
          // 출석 정보가 없으면 빈 상태로 반환
          if (attendance == null) {
            return AttendanceState.empty;
          }
          return AttendanceState.success(attendance: attendance);
        },
      );
    } catch (e) {
      return AttendanceState.error(
        message: '출석 정보 초기화 실패',
        errorDetail: e.toString(),
      );
    }
  }

  /// 출석 정보 저장
  Future<void> saveAttendance(Attendance attendance) async {
    state = const AsyncValue.loading();
    
    try {
      final result = await _saveMyAttendance(attendance: attendance);
      
      result.fold(
        (failure) {
          state = AsyncValue.data(AttendanceState.error(
            message: '출석 정보 저장 실패',
            errorDetail: failure.message,
          ));
        },
        (_) async {
          // 저장 후 최신 정보 다시 불러오기
          final user = FirebaseAuth.instance.currentUser;
          if (user == null) {
            state = AsyncValue.data(AttendanceState.error(
              message: '사용자 인증 정보가 없습니다',
            ));
            return;
          }
          
          final weekKey = _getCurrentWeekKey();
          final newResult = await _getMyAttendance(weekKey: weekKey, userId: user.uid);
          
          newResult.fold(
            (failure) {
              state = AsyncValue.data(AttendanceState.error(
                message: '출석 정보 새로고침 실패',
                errorDetail: failure.message,
              ));
            },
            (attendance) {
              if (attendance == null) {
                state = AsyncValue.data(AttendanceState.empty);
              } else {
                state = AsyncValue.data(AttendanceState.success(attendance: attendance));
              }
            },
          );
        },
      );
    } catch (e) {
      state = AsyncValue.data(AttendanceState.error(
        message: '출석 정보 저장 중 오류 발생',
        errorDetail: e.toString(),
      ));
    }
  }

  /// 요일별 참석자 스트림 반환
  Stream<List<Attendance>> attendeesByDay(String day) {
    final weekKey = _getCurrentWeekKey();
    final repository = ref.read(attendanceRepositoryProvider);
    
    // Either 스트림을 성공 시 리스트, 실패 시 빈 리스트로 변환
    return repository.attendeesByDayStream(weekKey: weekKey, day: day).map((either) =>
      either.fold((_) => <Attendance>[], (list) => list),
    );
  }

  /// 현재 사용자 프로필 정보 가져오기
  Future<(String name, String profileImageUrl)> getCurrentUserProfile() async {
    final result = await _getCurrentUserProfile();
    return result.fold(
      (failure) => ('이름없음', ''),
      (profile) => profile,
    );
  }

  /// 한 주의 시작(월요일)~끝(일요일) 구간을 문자열로 반환
  String _getCurrentWeekKey() {
    final now = DateTime.now();
    final start = now.subtract(Duration(days: now.weekday - 1));
    final end = start.add(const Duration(days: 6));
    String format(DateTime d) => '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    return '${format(start)}~${format(end)}';
  }
}