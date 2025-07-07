import 'package:flutter/material.dart';

/// 공통 빈 상태(EmptyState) 위젯
class EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? subMessage;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.message,
    this.subMessage,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 56, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(subMessage!, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            ],
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 