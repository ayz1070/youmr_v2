import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// 게시글 목록 조회 유스케이스
class FetchPostsUseCase {
  final PostRepository repository;
  FetchPostsUseCase(this.repository);

  Future<List<PostEntity>> call({String? category, String? startAfterId, int limit = 20}) {
    return repository.fetchPosts(category: category, startAfterId: startAfterId, limit: limit);
  }
} 