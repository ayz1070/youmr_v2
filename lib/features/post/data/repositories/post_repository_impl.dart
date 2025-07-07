import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_firestore_data_source.dart';

/// 게시글 리포지토리 구현체
class PostRepositoryImpl implements PostRepository {
  final PostFirestoreDataSource _dataSource;
  PostRepositoryImpl(this._dataSource);

  @override
  Future<List<PostEntity>> fetchPosts({String? category, String? startAfterId, int limit = 20}) async {
    // startAfterId는 실제 페이징에 맞게 구현 필요
    return _dataSource.fetchPosts(category: category, limit: limit);
  }

  @override
  Future<PostEntity> fetchPostDetail(String postId) {
    return _dataSource.fetchPostDetail(postId);
  }

  @override
  Future<void> savePost(PostEntity post) {
    return _dataSource.savePost(post);
  }

  @override
  Future<void> deletePost(String postId) {
    return _dataSource.deletePost(postId);
  }

  @override
  Future<void> createPost({
    required String title,
    required String content,
    required String category,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    String? youtubeUrl,
  }) {
    return _dataSource.createPost(
      title: title,
      content: content,
      category: category,
      authorId: authorId,
      authorNickname: authorNickname,
      authorProfileUrl: authorProfileUrl,
      youtubeUrl: youtubeUrl,
    );
  }
} 