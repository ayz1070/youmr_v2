import 'package:flutter/material.dart';

/// 게시판 로딩 상태 위젯
class PostLoadingView extends StatelessWidget {
  final ThemeData theme;
  const PostLoadingView({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
            strokeWidth: 4,
          ),
          const SizedBox(height: 20),
          Text(
            '게시글을 불러오는 중...'
            ,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
} 