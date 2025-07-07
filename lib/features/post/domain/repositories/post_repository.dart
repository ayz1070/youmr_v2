import '../entities/post_entity.dart';

/// 게시글 리포지토리 인터페이스
abstract class PostRepository {
  /// 게시글 목록 조회
  Future<List<PostEntity>> fetchPosts({String? category, String? startAfterId, int limit});

  /// 게시글 상세 조회
  Future<PostEntity> fetchPostDetail(String postId);

  /// 게시글 저장(작성/수정)
  Future<void> savePost(PostEntity post);

  /// 게시글 삭제
  Future<void> deletePost(String postId);

  /// 게시글 작성
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    String? youtubeUrl,
  });
} 