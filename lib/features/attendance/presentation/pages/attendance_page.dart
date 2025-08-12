import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/constants/app_constants.dart';
import '../../di/attendance_module.dart';
import '../../domain/entities/attendance.dart';
import '../widgets/attendance_day_row.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/app_error_view.dart';
import 'package:youmr_v2/core/widgets/app_loading_view.dart';
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
        title: "출석",
      ),
      body: attendanceAsync.when(
        data: (attendance) {
          // 출석 데이터가 없어도 항상 출석 체크 UI를 노출
          // attendance가 null이거나 selectedDays가 비어 있어도 체크 UI가 보임
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
                      // null 안전 처리: 출석 데이터가 없으면 빈 리스트 전달
                      mySelectedDays: attendance?.selectedDays ?? [],
                      isLoading: isLoading,
                      showDivider: !isLastDay, // 마지막 요일에는 divider 표시하지 않음

                      onAttendanceToggle: (selectedDay, checked) async {
                        final newDays = List<String>.from(attendance?.selectedDays ?? []);
                        if (checked) {
                          newDays.add(selectedDay);
                        } else {
                          newDays.remove(selectedDay);
                        }
                        
                        // Provider를 통해 최신 사용자 정보 가져오기
                        final user = FirebaseAuth.instance.currentUser;
                        final (userName, userProfileImageUrl) = await notifier.getCurrentUserProfile();
                        
                        await notifier.saveAttendance(
                          (attendance ?? Attendance(
                            weekKey: weekKey,
                            userId: user?.uid ?? '',
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
                      },
                    ),
                  );
                },
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