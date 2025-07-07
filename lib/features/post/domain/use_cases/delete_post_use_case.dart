import '../repositories/post_repository.dart';

/// 게시글 삭제 유스케이스
class DeletePostUseCase {
  final PostRepository repository;
  DeletePostUseCase(this.repository);

  Future<void> call(String postId) {
    return repository.deletePost(postId);
  }
} 