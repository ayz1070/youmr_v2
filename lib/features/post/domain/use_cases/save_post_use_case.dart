import '../entities/post_entity.dart';
import '../repositories/post_repository.dart';

/// 게시글 저장(작성/수정) 유스케이스
class SavePostUseCase {
  final PostRepository repository;
  SavePostUseCase(this.repository);

  Future<void> call(PostEntity post) {
    return repository.savePost(post);
  }
} 