import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/attendance_entity.dart';
import '../controllers/attendance_controller.dart';
import 'attendance_action_button.dart';
import 'attendee_avatar_list.dart';

/// 요일별 출석 리스트 위젯
class AttendanceDayList extends ConsumerWidget {
  final String weekKey;
  final String userId;
  final List<String> mySelectedDays;
  final void Function(List<String>) onSaveAttendance;
  final List<String> days;

  const AttendanceDayList({
    super.key,
    required this.weekKey,
    required this.userId,
    required this.mySelectedDays,
    required this.onSaveAttendance,
    this.days = const ['월', '화', '수', '목', '금', '토', '일'],
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: days.map((day) {
        final isChecked = mySelectedDays.contains(day);
        final attendeesStream = ref.watch(
          attendanceControllerProvider(weekKey: weekKey, userId: userId).notifier
        ).attendeesByDay(weekKey, day);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2, bottom: 8),
                child: Text('$day요일', style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
              Row(
                children: [
                  AttendanceActionButton(
                    isChecked: isChecked,
                    onTap: () {
                      final newDays = List<String>.from(mySelectedDays);
                      if (!isChecked) {
                        newDays.add(day);
                      } else {
                        newDays.remove(day);
                      }
                      onSaveAttendance(newDays);
                    },
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StreamBuilder<List<AttendanceEntity>>(
                      stream: attendeesStream,
                      builder: (context, snapshot) {
                        final attendees = snapshot.data ?? [];
                        return AttendeeAvatarList(attendees: attendees);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
} 