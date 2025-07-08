import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/attendance_provider.dart';
import 'attendee_avatar.dart';

/// 요일별 참석자 리스트 + 출석 버튼 위젯
class AttendanceDayRow extends ConsumerWidget {
  final String day;
  final List<String> mySelectedDays;
  final void Function(String day, bool checked) onAttendanceToggle;
  final bool isLoading;

  const AttendanceDayRow({
    super.key,
    required this.day,
    required this.mySelectedDays,
    required this.onAttendanceToggle,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendeesStream = ref.read(attendanceProvider.notifier).attendeesByDay(day);
    final isChecked = mySelectedDays.contains(day);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 2, bottom: 8),
          child: Text(
            '$day요일',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        StreamBuilder<List<dynamic>>( // 실제 타입은 Attendance
          stream: attendeesStream,
          builder: (context, snapshot) {
            final attendees = snapshot.data ?? [];
            return SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: attendees.length + 1,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, idx) {
                  if (idx == 0) {
                    // 출석 버튼
                    return GestureDetector(
                      onTap: isLoading ? null : () => onAttendanceToggle(day, !isChecked),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: isChecked ? Theme.of(context).colorScheme.primary.withOpacity(0.12) : Theme.of(context).colorScheme.surface,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).dividerColor,
                                width: 1.5,
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                isChecked ? Icons.remove : Icons.check,
                                size: 22,
                                color: isChecked ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isChecked ? '불참' : '출석',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                          ),
                        ],
                      ),
                    );
                  }
                  final a = attendees[idx - 1];
                  return AttendeeAvatar(
                    nickname: a.nickname,
                    profileImageUrl: a.profileImageUrl,
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
} 