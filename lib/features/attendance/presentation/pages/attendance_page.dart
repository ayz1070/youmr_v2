import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/attendance_entity.dart';
import '../controllers/attendance_controller.dart';
import '../widgets/attendance_day_list.dart';

/// 출석 탭 페이지 (Riverpod 기반)
class AttendancePage extends ConsumerWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: weekKey, userId는 실제 로그인 정보/날짜에서 가져와야 함
    final String weekKey = _getCurrentWeekKey();
    final String userId = 'userId'; // 실제 로그인 유저 ID로 대체
    final attendanceAsync = ref.watch(attendanceControllerProvider(weekKey: weekKey, userId: userId));

    return Scaffold(
      body: attendanceAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) => Center(child: SelectableText.rich(
          TextSpan(text: '에러: $e', style: const TextStyle(color: Colors.red)),
        )),
        data: (attendance) => ListView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 12, top: 4),
              child: Text(_getCurrentWeekText(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
            ),
            AttendanceDayList(
              weekKey: weekKey,
              userId: userId,
              mySelectedDays: attendance?.selectedDays ?? [],
              onSaveAttendance: (days) async {
                if (attendance == null) return;
                final notifier = ref.read(attendanceControllerProvider(weekKey: weekKey, userId: userId).notifier);
                await notifier.saveAttendance(
                  attendance.copyWith(selectedDays: days),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  static String _getCurrentWeekKey() {
    final now = DateTime.now();
    final weekStr = now.weekOfYear.toString();
    return '${now.year}-$weekStr';
  }

  static String _getCurrentWeekText() {
    final now = DateTime.now();
    final weekOfYear = now.weekOfYear;
    final month = now.month;
    return '$month월 ${weekOfYear}주차';
  }
}

extension on DateTime {
  int get weekOfYear {
    final firstDayOfYear = DateTime(year, 1, 1);
    final daysOffset = weekday - firstDayOfYear.weekday;
    final firstMonday = firstDayOfYear.add(Duration(days: daysOffset));
    final diff = difference(firstMonday).inDays;
    return (diff / 7).ceil() + 1;
  }
} 