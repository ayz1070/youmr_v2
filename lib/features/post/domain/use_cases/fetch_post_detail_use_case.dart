import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// 게시글 상세 조회 유스케이스
class FetchPostDetailUseCase {
  final PostRepository repository;
  FetchPostDetailUseCase(this.repository);

  Future<PostEntity> call(String postId) {
    return repository.fetchPostDetail(postId);
  }
} 