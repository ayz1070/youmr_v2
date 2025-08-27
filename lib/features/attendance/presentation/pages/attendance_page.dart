import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';
import '../../../../core/utils/app_date_utils.dart';
import '../../di/attendance_module.dart';
import '../../domain/entities/attendance.dart';
import '../widgets/attendance_day_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_error_view.dart';
import 'package:youmr_v2/core/widgets/app_loading_view.dart';
import 'package:youmr_v2/features/attendance/presentation/widgets/attendance_banner_ad_widget.dart';
import 'package:youmr_v2/core/constants/error_messages.dart';
import '../providers/notifier/attendance_notifier.dart';
import '../providers/state/attendance_state.dart';

/// 출석 탭 페이지 (UI만 담당, 상태/로직은 Provider에서 관리)
class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);
    final notifier = ref.read(attendanceProvider.notifier);

    return Scaffold(
      appBar: PrimaryAppBar(
        title: "출석",
      ),
      body: attendanceAsync.when(
        data: (state) {
          if (state.isLoading) {
            return const AppLoadingView();
          } else if (state.hasError) {
            return AppErrorView(
              message: '출석 정보 로드 실패',
              errorDetail: '상태 오류',
              onRetry: () => ref.refresh(attendanceProvider),
            );
          } else if (state.hasData) {
            return _buildAttendanceContent(context, ref, notifier, state.attendance);
          } else {
            return _buildAttendanceContent(context, ref, notifier, null);
          }
        },
        loading: () => const AppLoadingView(),
        error: (e, st) => AppErrorView(
          message: ErrorMessages.attendanceLoadError,
          errorDetail: e.toString(),
          onRetry: () => ref.refresh(attendanceProvider),
        ),
      ),
    );
  }

  /// 출석 내용 UI 구성
  Widget _buildAttendanceContent(
    BuildContext context,
    WidgetRef ref,
    AttendanceNotifier notifier,
    Attendance? attendance,
  ) {
    final mySelectedDays = attendance?.selectedDays ?? [];
    final weekKey = attendance?.weekKey ?? AppDateUtils.getCurrentWeekKey();

    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 0),
      children: [
        ...AppConstants.days.asMap().entries.map(
          (entry) {
            final index = entry.key;
            final day = entry.value;
            final isLastDay = index == AppConstants.days.length - 1;
            
            return Padding(
              padding: const EdgeInsets.only(
                bottom: 16, left: 16, right: 16,
              ),
              child: AttendanceDayRow(
                day: day,
                mySelectedDays: mySelectedDays,
                isLoading: false, // 상태에서 로딩 여부 확인
                showDivider: !isLastDay,
                onAttendanceToggle: (selectedDay, checked) async {
                  await _handleAttendanceToggle(
                    notifier,
                    attendance,
                    weekKey,
                    selectedDay,
                    checked,
                  );
                },
              ),
            );
          },
        ),
        // 출석 체크 목록 하단에 출석 전용 배너 광고 추가
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: AttendanceBannerAdWidget(),
        ),
      ],
    );
  }

  /// 출석 토글 처리
  Future<void> _handleAttendanceToggle(
    AttendanceNotifier notifier,
    Attendance? attendance,
    String weekKey,
    String selectedDay,
    bool checked,
  ) async {
    try {
      final newDays = List<String>.from(attendance?.selectedDays ?? []);
      if (checked) {
        newDays.add(selectedDay);
      } else {
        newDays.remove(selectedDay);
      }
      
      // Provider를 통해 최신 사용자 정보 가져오기
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;
      
      final (userName, userProfileImageUrl) = await notifier.getCurrentUserProfile();
      
      await notifier.saveAttendance(
        (attendance ?? Attendance(
          weekKey: weekKey,
          userId: user.uid,
          selectedDays: [],
          name: userName,
          profileImageUrl: userProfileImageUrl,
          lastUpdated: null,
        )).copyWith(
          selectedDays: newDays,
          name: userName,
          profileImageUrl: userProfileImageUrl,
        ),
      );
    } catch (e) {
      // 에러 처리는 Provider에서 담당
    }
  }
} 