import 'package:flutter/material.dart';

/// 공통 에러 상태 위젯
class ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  const ErrorState({Key? key, required this.message, this.onRetry}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 56, color: Theme.of(context).colorScheme.error),
            const SizedBox(height: 16),
            Text(message, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.error), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('다시 시도'),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 