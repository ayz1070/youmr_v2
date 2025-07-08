import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youmr_v2/features/home/domain/entities/post.dart';
import 'package:youmr_v2/features/home/domain/use_cases/get_posts_use_case.dart';

/// 게시글 목록 상태
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

  /// 초기 상태
  factory PostListState.initial() => const PostListState(posts: [], isLoading: false);

  /// 상태 복사
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
class PostListNotifier extends StateNotifier<PostListState> {
  final GetPostsUseCase _getPostsUseCase;

  /// 생성자
  PostListNotifier({required GetPostsUseCase getPostsUseCase})
      : _getPostsUseCase = getPostsUseCase,
        super(PostListState.initial());

  /// 게시글 목록 불러오기
  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final posts = await _getPostsUseCase();
      state = state.copyWith(posts: posts, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

/// 게시글 목록 Provider 인스턴스
final postListProvider = StateNotifierProvider<PostListNotifier, PostListState>(
  (ref) => throw UnimplementedError('Provider는 main에서 주입되어야 합니다.'),
); 