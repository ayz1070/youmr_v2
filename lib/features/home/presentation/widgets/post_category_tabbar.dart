import 'package:flutter/material.dart';

/// 게시글 카테고리 탭바 위젯
class PostCategoryTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;
  
  const PostCategoryTabBar({
    super.key,
    required this.tabController,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
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