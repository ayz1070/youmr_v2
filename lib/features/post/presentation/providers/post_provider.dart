import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/post.dart';
import '../../domain/use_cases/get_posts_use_case.dart';

/// 게시글 목록 상태 클래스
/// - 게시글 목록, 로딩 여부, 에러 메시지 등 상태를 관리합니다.
class PostListState {
  /// 게시글 목록
  final List<Post> posts;

  /// 로딩 여부
  final bool isLoading;

  /// 에러 메시지(있을 경우)
  final String? error;

  /// 생성자
  const PostListState({
    required this.posts,
    required this.isLoading,
    this.error,
  });

  /// 초기 상태 반환
  factory PostListState.initial() => const PostListState(posts: [], isLoading: false);

  /// 상태 복사 (immutable 패턴)
  PostListState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? error,
  }) {
    return PostListState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// 게시글 목록 Provider (StateNotifier)
///
/// DI 구조 개선: StateNotifierProvider에서 외부에서 useCase를 주입받도록 main에서 ProviderScope.override 사용 권장
/// 테스트 용이성을 위해 StateNotifier 생성자에 의존성 주입 필수
/// 공통 로딩/에러 위젯(AppLoadingView, AppErrorView 등) 사용 권장
class PostListNotifier extends StateNotifier<PostListState> {
  final GetPostsUseCase _getPostsUseCase;

  /// 생성자
  /// [getPostsUseCase]는 외부에서 주입받아야 하며, 테스트 시 mock 객체 주입 가능
  PostListNotifier({required GetPostsUseCase getPostsUseCase})
      : _getPostsUseCase = getPostsUseCase,
        super(PostListState.initial());

  /// 게시글 목록 불러오기
  ///
  /// 에러 발생 시 state.error에 메시지 저장
  /// 로딩 상태는 state.isLoading으로 관리
  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final List<Post> posts = await _getPostsUseCase();
      state = state.copyWith(posts: posts, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

/// 게시글 목록 Provider 인스턴스
///
/// DI 구조 개선: main.dart에서 ProviderScope.override로 주입 권장
final StateNotifierProvider<PostListNotifier, PostListState> postListProvider =
    StateNotifierProvider<PostListNotifier, PostListState>(
  (ref) => throw UnimplementedError('Provider는 main에서 주입되어야 합니다.'),
); 