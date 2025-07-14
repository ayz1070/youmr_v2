import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youmr_v2/core/widgets/primary_app_bar.dart';
import '../../data/data_sources/post_firestore_data_source.dart';
import '../widgets/post_category_tabbar.dart';
import '../widgets/post_card.dart';
import '../widgets/ad_banner.dart';
import '../../domain/entities/post.dart';
import 'write_page.dart'; // 글쓰기 페이지 import
import '../widgets/post_notice_list.dart';
import '../widgets/post_grid_list.dart';
import '../widgets/post_error_view.dart';
import '../widgets/post_loading_view.dart';
import '../widgets/post_empty_view.dart';

/// 게시글 피드 + 카테고리 + 광고를 보여주는 홈 탭 메인 페이지
///
/// - 상태/로직은 Provider로 분리 권장(현재는 StatefulWidget)
/// - 공통 위젯(AppLoadingView, AppErrorView 등) 사용 권장
/// - 컬러/문구/패딩 등은 core/constants로 상수화 권장
class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final List<String> _categories = ['전체', '자유', '밴드', '영상'];
  final PostFirestoreDataSource _dataSource = PostFirestoreDataSource();

  // 게시글/공지글 상태 변수
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
  ///
  /// [reset]이 true면 목록 초기화 후 새로 불러옴
  Future<void> _fetchPosts({bool reset = false}) async {
    if (_isLoading) return;
    setState(() => _isLoading = true);
    try {
      // 공지글 먼저 불러오기 (isNotice==true, 최신순, 최대 3개)
      final QuerySnapshot<Map<String, dynamic>> noticeSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('isNotice', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(3)
          .get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> notices = noticeSnap.docs;
      // 일반 게시글 불러오기
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = await _dataSource.fetchPosts(
        category: _currentCategory,
        startAfter: reset ? null : _lastDoc,
        limit: 20,
      );
      // 공지글은 일반글에서 제외
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> filteredDocs = docs.where((d) => d['isNotice'] != true).toList();
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
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar:PrimaryAppBar(title: "게시판",actions: [
        IconButton(
          icon: const Icon(Icons.add_box_outlined),
          tooltip: '글쓰기',
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const WritePage(),
              ),
            );
          },
        ),
      ],),
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
                    ? PostErrorView(error: _error!, onRetry: () => _fetchPosts(reset: true), theme: theme)
                    : _isLoading && _posts.isEmpty && _notices.isEmpty
                        ? PostLoadingView(theme: theme)
                        : _posts.isEmpty && _notices.isEmpty
                            ? PostEmptyView(theme: theme)
                            : RefreshIndicator(
                                color: theme.colorScheme.primary,
                                backgroundColor: theme.colorScheme.surface,
                                onRefresh: () => _fetchPosts(reset: true),
                                child: CustomScrollView(
                                  controller: _scrollController,
                                  slivers: [
                                    if (_notices.isNotEmpty)
                                      SliverToBoxAdapter(
                                        child: PostNoticeList(notices: _notices, theme: theme),
                                      ),
                                    // PostGridList를 SliverToBoxAdapter로 감싸지 않고 바로 추가
                                    PostGridList(
                                      posts: _posts,
                                      hasMore: _hasMore,
                                      theme: theme,
                                    ),
                                  ],
                                ),
                              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 