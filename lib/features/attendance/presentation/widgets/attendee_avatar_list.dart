import 'package:flutter/material.dart';
import '../../domain/entities/attendance_entity.dart';

/// 참석자 아바타 리스트 위젯
class AttendeeAvatarList extends StatelessWidget {
  final List<AttendanceEntity> attendees;

  const AttendeeAvatarList({super.key, required this.attendees});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: attendees.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, idx) {
          final a = attendees[idx];
          return Column(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).dividerColor, width: 1),
                ),
                child: ClipOval(
                  child: a.profileImageUrl.isNotEmpty
                      ? Image.network(a.profileImageUrl, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person))
                      : Image.asset('assets/images/default_profile.png', fit: BoxFit.cover),
                ),
              ),
              const SizedBox(height: 2),
              SizedBox(
                width: 40,
                child: Text(
                  a.nickname,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
} 