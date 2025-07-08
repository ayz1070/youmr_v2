import 'package:youmr_v2/features/home/domain/entities/post.dart';

/// 게시글 저장소 인터페이스
/// 데이터 접근을 추상화하여 의존성 역전을 실현합니다.
abstract class PostRepository {
  /// 게시글 목록 조회
  Future<List<Post>> getPosts();
} 