import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/attendance.dart';
import '../providers/attendance_provider.dart';
import '../widgets/attendance_day_row.dart';

/// 출석 탭 페이지 (UI만 담당, 상태/로직은 Provider에서 관리)
class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  static const List<String> days = ['월', '화', '수', '목', '금', '토', '일'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceProvider);
    final notifier = ref.read(attendanceProvider.notifier);
    final isLoading = attendanceAsync.isLoading;
    final attendance = attendanceAsync.value;
    final mySelectedDays = attendance?.selectedDays ?? [];

    return Scaffold(
      body: attendanceAsync.when(
        data: (attendance) {
          // attendance가 null일 수 있으므로, 기본값 생성
          final user = attendanceAsync.value == null
              ? null
              : attendanceAsync.value!.userId;
          final safeAttendance = attendance ?? Attendance(
            weekKey: '',
            userId: user ?? '',
            selectedDays: <String>[],
            nickname: '',
            profileImageUrl: '',
            lastUpdated: null,
          );
          return ListView(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 4),
                child: Text(
                  safeAttendance.weekKey,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              ...days.map((day) => Padding(
                padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                child: AttendanceDayRow(
                  day: day,
                  mySelectedDays: safeAttendance.selectedDays,
                  isLoading: isLoading,
                  onAttendanceToggle: (selectedDay, checked) async {
                    final newDays = List<String>.from(safeAttendance.selectedDays);
                    if (checked) {
                      newDays.add(selectedDay);
                    } else {
                      newDays.remove(selectedDay);
                    }
                    await notifier.saveAttendance(
                      safeAttendance.copyWith(selectedDays: newDays),
                    );
                  },
                ),
              )),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('에러가 발생했습니다.'),
              const SizedBox(height: 8),
              Text(e.toString(), style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.refresh(attendanceProvider),
                child: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 