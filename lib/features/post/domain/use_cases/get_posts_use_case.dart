
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 게시글 목록 조회 유즈케이스
/// 비즈니스 로직에서 게시글 목록을 가져올 때 사용합니다.
class GetPostsUseCase {
  final PostRepository _repository;

  /// 생성자
  GetPostsUseCase({required PostRepository repository}) : _repository = repository;

  /// 게시글 목록 조회 실행
  Future<List<Post>> call() async {
    return await _repository.getPosts();
  }
} 