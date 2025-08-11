import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/data_sources/post_firestore_data_source.dart';

/// 게시글 목록 상태 클래스
/// - 게시글 목록, 로딩 여부, 에러 메시지 등 상태를 관리합니다.
class PostListState {
  /// 게시글 목록 (QueryDocumentSnapshot)
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> posts;

  /// 공지글 목록
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> notices;

  /// 로딩 여부
  final bool isLoading;

  /// 에러 메시지(있을 경우)
  final String? error;

  /// 생성자
  const PostListState({
    required this.posts,
    required this.notices,
    required this.isLoading,
    this.error,
  });

  /// 초기 상태 반환
  factory PostListState.initial() => const PostListState(
    posts: [], 
    notices: [], 
    isLoading: false
  );

  /// 상태 복사 (immutable 패턴)
  PostListState copyWith({
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? posts,
    List<QueryDocumentSnapshot<Map<String, dynamic>>>? notices,
    bool? isLoading,
    String? error,
  }) {
    return PostListState(
      posts: posts ?? this.posts,
      notices: notices ?? this.notices,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 최신 공지글 상태 클래스
class LatestNoticeState {
  /// 최신 공지글 (단일)
  final QueryDocumentSnapshot<Map<String, dynamic>>? notice;
  /// 로딩 여부
  final bool isLoading;
  /// 에러 메시지(있을 경우)
  final String? error;

  /// 생성자
  const LatestNoticeState({
    this.notice,
    required this.isLoading,
    this.error,
  });

  /// 초기 상태 반환
  factory LatestNoticeState.initial() => const LatestNoticeState(isLoading: false);

  /// 상태 복사 (immutable 패턴)
  LatestNoticeState copyWith({
    QueryDocumentSnapshot<Map<String, dynamic>>? notice,
    bool? isLoading,
    String? error,
  }) {
    return LatestNoticeState(
      notice: notice ?? this.notice,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 게시글 목록 Provider (StateNotifier)
///
/// 실시간 스트림을 사용하여 좋아요 등 실시간 업데이트 지원
class PostListNotifier extends StateNotifier<PostListState> {
  final PostFirestoreDataSource _dataSource;
  String _currentCategory = '전체';
  StreamSubscription<List<QueryDocumentSnapshot<Map<String, dynamic>>>>? _postsSubscription;

  /// 생성자
  PostListNotifier({required PostFirestoreDataSource dataSource})
      : _dataSource = dataSource,
        super(PostListState.initial()) {
    // 초기 데이터 로드
    _loadPosts();
  }

  /// 카테고리 변경
  void changeCategory(String category) {
    _currentCategory = category;
    _loadPosts();
  }

  /// 게시글 목록 로드 (실시간 스트림)
  void _loadPosts() {
    // 기존 구독 해제
    _postsSubscription?.cancel();
    
    state = state.copyWith(isLoading: true, error: null);
    
    // 공지글 로드
    _loadNotices();
    
    // 일반 게시글 실시간 스트림 구독
    _postsSubscription = _dataSource
        .fetchPostsStream(category: _currentCategory, limit: 20)
        .listen(
          (posts) {
            // 공지글 제외
            final filteredPosts = posts.where((post) => 
              post.data()['isNotice'] != true
            ).toList();
            
            state = state.copyWith(
              posts: filteredPosts,
              isLoading: false,
              error: null,
            );
          },
          onError: (error) {
            state = state.copyWith(
              isLoading: false,
              error: error.toString(),
            );
          },
        );
  }

  /// 공지글 로드
  Future<void> _loadNotices() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> noticeSnap = 
          await FirebaseFirestore.instance
              .collection('posts')
              .where('isNotice', isEqualTo: true)
              .orderBy('createdAt', descending: true)
              .limit(3)
              .get();
      
      state = state.copyWith(notices: noticeSnap.docs);
    } catch (e) {
      // 공지글 로드 실패는 무시 (일반 게시글은 계속 표시)
    }
  }

  @override
  void dispose() {
    _postsSubscription?.cancel();
    super.dispose();
  }
}

/// 최신 공지글 Provider (StateNotifier)
class LatestNoticeNotifier extends StateNotifier<LatestNoticeState> {
  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _noticeSubscription;

  /// 생성자
  LatestNoticeNotifier() : super(LatestNoticeState.initial()) {
    _loadLatestNotice();
  }

  /// 최신 공지글 로드 (실시간 스트림)
  void _loadLatestNotice() {
    state = state.copyWith(isLoading: true, error: null);
    
    _noticeSubscription = FirebaseFirestore.instance
        .collection('posts')
        .where('isNotice', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen(
          (snapshot) {
            final notice = snapshot.docs.isNotEmpty ? snapshot.docs.first : null;
            state = state.copyWith(
              notice: notice,
              isLoading: false,
              error: null,
            );
          },
          onError: (error) {
            state = state.copyWith(
              isLoading: false,
              error: error.toString(),
            );
          },
        );
  }

  @override
  void dispose() {
    _noticeSubscription?.cancel();
    super.dispose();
  }
}

/// 게시글 목록 Provider 인스턴스
final postListProvider = StateNotifierProvider<PostListNotifier, PostListState>(
  (ref) => PostListNotifier(
    dataSource: PostFirestoreDataSource(),
  ),
);

/// 최신 공지글 Provider 인스턴스
final latestNoticeProvider = StateNotifierProvider<LatestNoticeNotifier, LatestNoticeState>(
  (ref) => LatestNoticeNotifier(),
); 