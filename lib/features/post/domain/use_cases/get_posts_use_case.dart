
import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// 게시글 목록 조회 유즈케이스
/// - 비즈니스 로직에서 게시글 목록을 가져올 때 사용
class GetPostsUseCase {
  /// 게시글 저장소
  final PostRepository _repository;

  /// [repository]: 게시글 저장소(DI)
  GetPostsUseCase({required PostRepository repository}) : _repository = repository;

  /// 게시글 목록 조회 실행
  /// 반환: [Post] 리스트
  Future<List<Post>> call() async {
    return await _repository.getPosts();
  }
} 