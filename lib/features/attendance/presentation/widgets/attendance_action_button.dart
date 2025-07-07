import 'package:flutter/material.dart';

/// 출석/불참 버튼 위젯
class AttendanceActionButton extends StatelessWidget {
  final bool isChecked;
  final VoidCallback onTap;

  const AttendanceActionButton({
    super.key,
    required this.isChecked,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
} 