import 'package:flutter/material.dart';

/// 공통 에러 화면 위젯
/// - message: 사용자에게 보여줄 에러 메시지(기본값: '에러가 발생했습니다.')
/// - onRetry: 재시도 콜백(선택)
/// - errorDetail: 상세 에러(선택, 개발/디버깅용)
class AppErrorView extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? errorDetail;

  const AppErrorView({
    super.key,
    this.message = '에러가 발생했습니다.',
    this.onRetry,
    this.errorDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (errorDetail != null && errorDetail!.isNotEmpty)
            Text(
              errorDetail!,
              style: const TextStyle(color: Colors.red, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('다시 시도'),
            ),
          ],
        ],
      ),
    );
  }
} 