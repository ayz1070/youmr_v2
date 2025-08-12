import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import 'package:youmr_v2/core/widgets/banner_ad_widget.dart';
import 'package:youmr_v2/core/constants/post_constants.dart';
import '../../di/post_module.dart';
import '../widgets/post_category_tabbar.dart';

import 'post_write_page.dart'; // 글쓰기 페이지 import
import '../widgets/simple_notice_widget.dart';
import '../widgets/post_grid_list.dart';
import '../widgets/post_error_view.dart';
import '../widgets/post_loading_view.dart';
import '../widgets/post_empty_view.dart';

/// 게시글 피드 + 카테고리 + 광고를 보여주는 홈 탭 메인 페이지
///
/// - 실시간 스트림을 사용하여 좋아요 등 실시간 업데이트 지원
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class PostPage extends ConsumerStatefulWidget {
  const PostPage({super.key});

  @override
  ConsumerState<PostPage> createState() => _PostPageState();
}

class _PostPageState extends ConsumerState<PostPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _categories = PostConstants.categories;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  /// 탭 변경 시 카테고리 변경
  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;
    final category = _categories[_tabController.index];
    ref.read(postListProvider.notifier).changeCategory(category);
  }

  /// 스크롤 하단 도달 시 추가 로드 (현재는 무한 스크롤 미지원)
  void _onScroll() {
    // TODO: 무한 스크롤 구현 시 사용
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final postState = ref.watch(postListProvider);
    
    return Scaffold(
      appBar: PrimaryAppBar(
        title: "홈",
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            tooltip: '글쓰기',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PostWritePage(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 카테고리 탭바
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withValues(alpha: 0.08),
                    width: 1,
                  ),
                ),
              ),
              child: PostCategoryTabBar(
                tabController: _tabController,
                categories: _categories,
              ),
            ),
            // 심플한 공지글 위젯
            const SimpleNoticeWidget(),
            // 게시글 리스트
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: postState.error != null
                    ? PostErrorView(
                        error: postState.error!,
                        onRetry: () async {
                          ref.read(postListProvider.notifier).changeCategory(_categories[_tabController.index]);
                        },
                        theme: theme,
                      )
                    : postState.isLoading && postState.posts.isEmpty
                        ? PostLoadingView(theme: theme)
                        : postState.posts.isEmpty
                            ? PostEmptyView(theme: theme)
                            : RefreshIndicator(
                                color: theme.colorScheme.primary,
                                backgroundColor: theme.colorScheme.surface,
                                onRefresh: () async {
                                  ref.read(postListProvider.notifier).changeCategory(_categories[_tabController.index]);
                                },
                                child: CustomScrollView(
                                  controller: _scrollController,
                                  slivers: [
                                    // 원래의 PostGridList 사용
                                    PostGridList(
                                      posts: postState.posts,
                                      hasMore: false, // 현재는 무한 스크롤 미지원
                                      theme: theme,
                                    ),
                                  ],
                                ),
                              ),
              ),
            ),
            // 배너 광고
            const BannerAdWidget(),
          ],
        ),
      ),
    );
  }
} 