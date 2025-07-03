import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/data_sources/post_firestore_data_source.dart';
import '../widgets/post_category_tabbar.dart';
import '../widgets/post_card.dart';
import '../widgets/ad_banner.dart';

/// 홈 탭 메인 페이지 (게시글 피드 + 카테고리 + 광고)
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _categories = ['전체', '자유', '신청곡', '영상'];
  final PostFirestoreDataSource _dataSource = PostFirestoreDataSource();

  // 상태 변수
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _posts = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _notices = [];
  bool _isLoading = false;
  bool _hasMore = true;
  String _currentCategory = '전체';
  DocumentSnapshot? _lastDoc;
  String? _error;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _categories.length, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
    _fetchPosts(reset: true);
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
    setState(() {
      _currentCategory = _categories[_tabController.index];
      _posts = [];
      _notices = [];
      _lastDoc = null;
      _hasMore = true;
      _error = null;
    });
    _fetchPosts(reset: true);
  }

  /// 스크롤 하단 도달 시 추가 로드
  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      if (!_isLoading && _hasMore) {
        _fetchPosts();
      }
    }
  }

  /// Firestore에서 게시글/공지글 불러오기
  Future<void> _fetchPosts({bool reset = false}) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      // 공지글 먼저 불러오기 (isNotice==true, 최신순, 최대 3개)
      final noticeSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('isNotice', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(3)
          .get();
      final notices = noticeSnap.docs;
      // 일반 게시글 불러오기
      final docs = await _dataSource.fetchPosts(
        category: _currentCategory,
        startAfter: reset ? null : _lastDoc,
        limit: 20,
      );
      // 공지글은 일반글에서 제외
      final filteredDocs = docs.where((d) => d['isNotice'] != true).toList();
      setState(() {
        if (reset) {
          _notices = notices;
          _posts = filteredDocs;
        } else {
          _posts.addAll(filteredDocs);
        }
        _lastDoc = docs.isNotEmpty ? docs.last : _lastDoc;
        _hasMore = docs.length == 20;
        _error = null;
      });
    } catch (e) {
      setState(() => _error = '게시글을 불러오지 못했습니다.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.background,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // 카테고리 탭바
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.08),
                    width: 1,
                  ),
                ),
              ),
              child: PostCategoryTabBar(
                tabController: _tabController,
                categories: _categories,
              ),
            ),
            // 게시글 리스트 + 광고 배너
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _error != null
                    ? _buildErrorWidget(theme)
                    : _isLoading && _posts.isEmpty && _notices.isEmpty
                        ? _buildLoadingWidget(theme)
                        : _posts.isEmpty && _notices.isEmpty
                            ? _buildEmptyWidget(theme)
                            : _buildPostList(theme),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget(ThemeData theme) {
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
              _error!,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.error,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => _fetchPosts(reset: true),
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

  Widget _buildLoadingWidget(ThemeData theme) {
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

  Widget _buildEmptyWidget(ThemeData theme) {
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

  Widget _buildPostList(ThemeData theme) {
    return RefreshIndicator(
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.surface,
      onRefresh: () => _fetchPosts(reset: true),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // 공지글은 기존대로 상단에 노출
          if (_notices.isNotEmpty)
            SliverToBoxAdapter(
              child: Column(
                children: _notices.map((noticeDoc) {
                  final notice = noticeDoc.data();
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Card(
                      elevation: 3,
                      color: theme.colorScheme.primaryContainer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: BorderSide(
                          color: theme.colorScheme.primary.withOpacity(0.18),
                          width: 1.2,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.campaign,
                                color: theme.colorScheme.onPrimary,
                                size: 22,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: PostCard(
                                postId: noticeDoc.id,
                                title: '[공지] ${notice['title'] ?? ''}',
                                content: notice['content'] ?? '',
                                author: notice['authorNickname'] ?? '',
                                authorProfileUrl: notice['authorProfileUrl'] ?? '',
                                createdAt: notice['createdAt'] != null ? (notice['createdAt'] as Timestamp).toDate() : null,
                                youtubeUrl: notice['youtubeUrl'],
                                likes: notice['likes'] ?? [],
                                likesCount: notice['likesCount'] ?? 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          // 광고 배너는 기존대로 (여기선 생략, 필요시 추가)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, idx) {
                  if (idx >= _posts.length) {
                    // 로딩 인디케이터(무한 스크롤)
                    return _hasMore
                        ? Padding(
                            padding: const EdgeInsets.all(16),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: theme.colorScheme.primary,
                              ),
                            ),
                          )
                        : const SizedBox.shrink();
                  }
                  final post = _posts[idx].data();
                  return PostCard(
                    postId: _posts[idx].id,
                    title: post['title'] ?? '',
                    content: post['content'] ?? '',
                    author: post['authorNickname'] ?? '',
                    authorProfileUrl: post['authorProfileUrl'] ?? '',
                    createdAt: post['createdAt'] != null ? (post['createdAt'] as Timestamp).toDate() : null,
                    youtubeUrl: post['youtubeUrl'],
                    likes: post['likes'] ?? [],
                    likesCount: post['likesCount'] ?? 0,
                  );
                },
                childCount: _posts.length + (_hasMore ? 1 : 0),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 