import 'package:flutter/material.dart';

/// 게시글 카테고리 탭바 위젯
///
/// - 탭/카테고리명 등은 core/constants로 상수화 권장
/// - 접근성(semantic label 등) 고려 권장
class PostCategoryTabBar extends StatelessWidget {
  /// 탭 컨트롤러
  final TabController tabController;
  /// 카테고리 목록
  final List<String> categories;
  /// 생성자
  const PostCategoryTabBar({
    super.key,
    required this.tabController,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.surface,
      child: TabBar(
        controller: tabController,
        tabs: categories.map((c) => Tab(text: c)).toList(),
        labelColor: theme.colorScheme.primary,
        unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
        indicatorColor: theme.colorScheme.primary,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.normal,
        ),
        dividerColor: theme.colorScheme.outline.withOpacity(0.2),
        dividerHeight: 1,
      ),
    );
  }
} 