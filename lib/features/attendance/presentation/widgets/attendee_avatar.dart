import 'package:flutter/material.dart';

/// 참석자 아바타 위젯
class AttendeeAvatar extends StatelessWidget {
  final String nickname;
  final String? profileImageUrl;
  final double size;

  const AttendeeAvatar({
    super.key,
    required this.nickname,
    this.profileImageUrl,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
          ),
          child: ClipOval(
            child: (profileImageUrl != null && profileImageUrl!.isNotEmpty)
                ? Image.network(profileImageUrl!, fit: BoxFit.cover)
                : Image.asset('assets/images/default_profile.png', fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 2),
        SizedBox(
          width: size,
          child: Text(
            nickname,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
} 