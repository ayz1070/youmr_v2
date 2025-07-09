import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';
import '../../domain/entities/attendance.dart';
import '../providers/attendance_provider.dart';
import '../widgets/attendance_day_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_v2/core/utils/app_date_utils.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_error_view.dart';
import 'package:youmr_v2/core/widgets/app_loading_view.dart';
import 'package:youmr_v2/core/widgets/app_empty_view.dart';
import 'package:youmr_v2/core/constants/error_messages.dart';

/// 출석 탭 페이지 (UI만 담당, 상태/로직은 Provider에서 관리)
class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);
    final notifier = ref.read(attendanceProvider.notifier);
    final isLoading = attendanceAsync.isLoading;
    final attendance = attendanceAsync.value;
    final mySelectedDays = attendance?.selectedDays ?? [];
    final weekKey = attendance?.weekKey ?? '';

    return Scaffold(
      appBar: PrimaryAppBar(
        // 기존 텍스트 위젯을 그대로 title로 전달
        title: Text(
          " ${AppDateUtils.formatWeekKey(weekKey)} 출석",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: attendanceAsync.when(
        data: (attendance) {
          // attendance가 null이거나 출석 데이터가 없을 때 빈 상태 처리
          if (attendance == null || attendance.selectedDays.isEmpty) {
            return const AppEmptyView(
              message: ErrorMessages.emptyAttendance,
            );
          }
          // 불필요한 중복 제거 및 const 최적화
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            children: [
              ...AppConstants.days.map(
                (day) => Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16, left: 16, right: 16,
                  ),
                  child: AttendanceDayRow(
                    day: day,
                    mySelectedDays: attendance.selectedDays,
                    isLoading: isLoading,
                    onAttendanceToggle: (selectedDay, checked) async {
                      final newDays = List<String>.from(attendance.selectedDays);
                      if (checked) {
                        newDays.add(selectedDay);
                      } else {
                        newDays.remove(selectedDay);
                      }
                      // 현재 로그인 유저 정보로 nickname, profileImageUrl을 항상 반영
                      final user = FirebaseAuth.instance.currentUser;
                      await notifier.saveAttendance(
                        attendance.copyWith(
                          selectedDays: newDays,
                          nickname: user?.displayName ?? '이름없음',
                          profileImageUrl: user?.photoURL ?? '',
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
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
} 