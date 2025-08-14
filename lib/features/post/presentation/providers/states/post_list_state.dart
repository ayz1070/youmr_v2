import '../../../domain/entities/post.dart';

class PostListState {
  /// 게시글 목록 (도메인 엔티티)
  final List<Post> posts;

  /// 공지글 목록
  final List<Post> notices;

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
    List<Post>? posts,
    List<Post>? notices,
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
