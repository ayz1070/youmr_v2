import 'package:flutter/material.dart';

/// 게시판 에러 상태 위젯
///
/// - 공통 에러 위젯(AppErrorView 등) 사용 권장
/// - 에러 메시지, 버튼 텍스트 등은 core/constants로 상수화 권장
class PostErrorView extends StatelessWidget {
  /// 에러 메시지
  final String error;
  /// 재시도 콜백
  final VoidCallback onRetry;
  /// 테마 데이터
  final ThemeData theme;
  /// 생성자
  const PostErrorView({super.key, required this.error, required this.onRetry, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              error,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 시도'),
              style: FilledButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 