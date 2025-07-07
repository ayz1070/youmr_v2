import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/use_cases/fetch_posts_use_case.dart';
import '../../domain/use_cases/fetch_post_detail_use_case.dart';
import '../../domain/use_cases/save_post_use_case.dart';
import '../../domain/use_cases/delete_post_use_case.dart';

// part 'post_controller.g.dart'; // 삭제된 파일 import 제거
// 없는 provider/클래스/메서드/참조 코드 주석 처리

/// 게시글 상태
class PostState {
  final List<PostEntity> posts;
  final bool isLoading;
  final String? error;
  const PostState({this.posts = const [], this.isLoading = false, this.error});
}

/// 게시글 컨트롤러 (AsyncNotifier)
class PostController extends AsyncNotifier<PostState> {
  late final FetchPostsUseCase _fetchPostsUseCase;
  late final FetchPostDetailUseCase _fetchPostDetailUseCase;
  late final SavePostUseCase _savePostUseCase;
  late final DeletePostUseCase _deletePostUseCase;

  @override
  Future<PostState> build() async {
    // DI: 유스케이스 주입 (실제 DI는 provider에서 처리)
    return const PostState();
  }

  /// 게시글 목록 조회
  Future<void> fetchPosts({String? category}) async {
    state = const AsyncLoading();
    try {
      final posts = await _fetchPostsUseCase(category: category);
      state = AsyncData(PostState(posts: posts));
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 게시글 상세 조회
  Future<PostEntity?> fetchPostDetail(String postId) async {
    try {
      return await _fetchPostDetailUseCase(postId);
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return null;
    }
  }

  /// 게시글 저장(작성/수정)
  Future<void> savePost(PostEntity post) async {
    state = const AsyncLoading();
    try {
      await _savePostUseCase(post);
      await fetchPosts();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }

  /// 게시글 삭제
  Future<void> deletePost(String postId) async {
    state = const AsyncLoading();
    try {
      await _deletePostUseCase(postId);
      await fetchPosts();
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
    }
  }
} 