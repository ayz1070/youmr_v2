
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../data_sources/post_firestore_data_source.dart';
import '../dtos/post_dto.dart';

/// 게시글 저장소 구현체
/// - DataSource/DTO만 의존, 도메인 변환/예외 처리 담당
class PostRepositoryImpl implements PostRepository {
  final PostFirestoreDataSource dataSource;

  /// [dataSource]: 게시글 데이터 소스(DI)
  PostRepositoryImpl({required this.dataSource});

  /// 게시글 목록 조회
  /// 반환: [Post] 리스트
  @override
  Future<List<Post>> getPosts() async {
    // TODO: Firestore 등에서 데이터 조회 후 PostDto → domain.Post 변환
    // 임시 스텁 데이터 반환(실제 Firestore 연동 시 아래 코드로 대체)
    /*
    final docs = await dataSource.fetchPosts();
    return docs.map((doc) => PostDto.fromJson(doc.data()).toDomain()).toList();
    */
    return [
      Post(
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