import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/firestore_constants.dart';
import '../../domain/entities/attendance.dart';
import '../../domain/use_cases/get_my_attendance.dart';
import '../../domain/use_cases/save_my_attendance.dart';
import '../../domain/use_cases/get_attendees_by_day.dart';
import '../../data/repositories/attendance_repository_impl.dart';
import '../../data/data_sources/attendance_firestore_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// 출석 상태 관리 Provider (AsyncNotifier)
final attendanceProvider = AsyncNotifierProvider<AttendanceNotifier, Attendance?>(
  AttendanceNotifier.new,
);

class AttendanceNotifier extends AsyncNotifier<Attendance?> {
  late final GetMyAttendance _getMyAttendance;
  late final SaveMyAttendance _saveMyAttendance;
  late final GetAttendeesByDay _getAttendeesByDay;

  @override
  FutureOr<Attendance?> build() async {
    // DI: 실제 구현체 주입
    final repository = AttendanceRepositoryImpl(
      dataSource: AttendanceFirestoreDataSource(),
    );
    _getMyAttendance = GetMyAttendance(repository);
    _saveMyAttendance = SaveMyAttendance(repository);
    _getAttendeesByDay = GetAttendeesByDay(repository);

    // 현재 로그인 유저 정보로 출석 정보 불러오기
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;
    
    // 사용자 테이블에서 프로필 정보 가져오기
    String userNickname = user.displayName ?? '이름없음';
    String userProfileImageUrl = '';
    
    try {
      final userDoc = await FirebaseFirestore.instance
          .collection(FirestoreConstants.usersCollection)
          .doc(user.uid)
          .get();
      
      if (userDoc.exists) {
        final userData = userDoc.data()!;
        userNickname = userData[FirestoreConstants.nickname] ?? user.displayName ?? '이름없음';
        userProfileImageUrl = userData[FirestoreConstants.profileImageUrl] ?? '';
      }
    } catch (e) {
      // 사용자 정보 조회 실패 시 기본값 사용
      userNickname = user.displayName ?? '이름없음';
      userProfileImageUrl = '';
    }
    
    final weekKey = _getCurrentWeekKey();
    final result = await _getMyAttendance(weekKey: weekKey, userId: user.uid);
    return result.fold(
      (failure) => throw AsyncError(failure, StackTrace.current),
      (attendance) {
        // 출석 정보가 없으면 기본값으로 생성하여 반환
        if (attendance == null) {
          return Attendance(
            weekKey: weekKey,
            userId: user.uid,
            selectedDays: <String>[],
            nickname: userNickname,
            profileImageUrl: userProfileImageUrl,
            lastUpdated: null,
          );
        }
        return attendance;
      },
    );
  }

  /// 출석 정보 저장
  Future<void> saveAttendance(Attendance attendance) async {
    state = const AsyncValue.loading();
    final result = await _saveMyAttendance(attendance: attendance);
    result.fold(
      (failure) => state = AsyncValue.error(failure, StackTrace.current),
      (_) async {
        // 저장 후 최신 정보 다시 불러오기
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) return;
        final weekKey = _getCurrentWeekKey();
        final newResult = await _getMyAttendance(weekKey: weekKey, userId: user.uid);
        newResult.fold(
          (failure) => state = AsyncValue.error(failure, StackTrace.current),
          (attendance) => state = AsyncValue.data(attendance),
        );
      },
    );
  }

  /// 요일별 참석자 스트림 반환
  Stream<List<Attendance>> attendeesByDay(String day) {
    final weekKey = _getCurrentWeekKey();
    // Either 스트림을 성공 시 리스트, 실패 시 빈 리스트로 변환
    return _getAttendeesByDay(weekKey: weekKey, day: day).map((either) =>
      either.fold((_) => <Attendance>[], (list) => list),
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