import 'package:youmr_v2/features/home/data/dtos/post_dto.dart';
import 'package:youmr_v2/features/home/domain/entities/post.dart' as domain;
import 'package:youmr_v2/features/home/domain/repositories/post_repository.dart';

/// 게시글 저장소 구현체
/// Firestore 등 외부 데이터 소스와의 통신을 담당합니다.
class PostRepositoryImpl implements PostRepository {
  /// 생성자
  PostRepositoryImpl();

  /// 게시글 목록 조회 (예시)
  @override
  Future<List<domain.Post>> getPosts() async {
    // TODO: Firestore 등에서 데이터 조회 후 PostDto → domain.Post 변환
    // 임시 스텁 데이터 반환
    return [
      domain.Post(
        id: '1',
        authorId: 'user1',
        authorName: '홍길동',
        title: '첫 번째 게시글',
        content: '안녕하세요, 첫 글입니다.',
        category: '자유',
        createdAt: DateTime.now().toIso8601String(),
        updatedAt: DateTime.now().toIso8601String(),
        likeCount: 0,
        commentCount: 0,
        imageUrls: [],
      ),
    ];
  }
} 