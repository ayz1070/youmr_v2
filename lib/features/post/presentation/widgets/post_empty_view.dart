import 'package:flutter/material.dart';

/// 게시판 빈 상태 위젯
///
/// - 공통 빈 상태 위젯(AppEmptyView 등) 사용 권장
/// - 메시지/컬러/패딩 등은 core/constants로 상수화 권장
class PostEmptyView extends StatelessWidget {
  /// 테마 데이터
  final ThemeData theme;
  /// 생성자
  const PostEmptyView({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.forum_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              '게시글이 없습니다.',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '첫 번째 게시글을 작성해보세요!',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 