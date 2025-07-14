
import '../entities/post.dart';

/// 게시글 저장소 인터페이스
/// - 데이터 접근을 추상화하여 의존성 역전을 실현
abstract class PostRepository {
  /// 게시글 목록 조회
  /// 반환: [Post] 리스트
  Future<List<Post>> getPosts();
} 