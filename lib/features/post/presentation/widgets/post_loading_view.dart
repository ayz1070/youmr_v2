import 'package:flutter/material.dart';

/// 게시판 로딩 상태 위젯
///
/// - 공통 로딩 위젯(AppLoadingView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class PostLoadingView extends StatelessWidget {
  /// 테마 데이터
  final ThemeData theme;
  /// 생성자
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