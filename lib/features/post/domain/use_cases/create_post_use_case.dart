import '../repositories/post_repository.dart';

/// 게시글 작성 유스케이스
class CreatePostUseCase {
  final PostRepository repository;
  CreatePostUseCase(this.repository);

  Future<void> call({
    required String title,
    required String content,
    required String category,
    required String authorId,
    required String authorNickname,
    required String authorProfileUrl,
    String? youtubeUrl,
  }) {
    return repository.createPost(
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